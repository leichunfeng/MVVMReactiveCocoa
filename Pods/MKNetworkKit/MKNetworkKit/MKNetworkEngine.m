//
//  MKNetworkEngine.m
//  MKNetworkKit
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic Consulting and Training Pte Ltd

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MKNetworkKit.h"
#define kFreezableOperationExtension @"mknetworkkitfrozenoperation"

#ifdef __OBJC_GC__
#error MKNetworkKit does not support Objective-C Garbage Collection
#endif

#if TARGET_OS_IPHONE
#ifndef __IPHONE_5_0
#error MKNetworkKit does not support iOS 4 and lower
#endif
#endif

#if ! __has_feature(objc_arc)
#error MKNetworkKit is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

@interface MKNetworkEngine (/*Private Methods*/)

@property (copy, nonatomic) NSString *hostName;
@property (strong, nonatomic) Reachability *reachability;
@property (copy, nonatomic) NSDictionary *customHeaders;
@property (assign, nonatomic) Class customOperationSubclass;

@property (nonatomic, strong) NSMutableDictionary *memoryCache;
@property (nonatomic, strong) NSMutableArray *memoryCacheKeys;
@property (nonatomic, strong) NSMutableDictionary *cacheInvalidationParams;

#if OS_OBJECT_USE_OBJC
@property (strong, nonatomic) dispatch_queue_t backgroundCacheQueue;
@property (strong, nonatomic) dispatch_queue_t operationQueue;
#else
@property (assign, nonatomic) dispatch_queue_t backgroundCacheQueue;
@property (assign, nonatomic) dispatch_queue_t operationQueue;
#endif

-(void) saveCache;
-(void) saveCacheData:(NSData*) data forKey:(NSString*) cacheDataKey;

-(void) freezeOperations;
-(void) checkAndRestoreFrozenOperations;

-(BOOL) isCacheEnabled;
@end

static NSOperationQueue *_sharedNetworkQueue;

@implementation MKNetworkEngine

// Network Queue is a shared singleton object.
// no matter how many instances of MKNetworkEngine is created, there is one and only one network queue
// In theory an app should contain as many network engines as the number of domains it talks to

#pragma mark -
#pragma mark Initialization

+(void) initialize {
  
  if(!_sharedNetworkQueue) {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
      _sharedNetworkQueue = [[NSOperationQueue alloc] init];
      [_sharedNetworkQueue addObserver:[self self] forKeyPath:@"operationCount" options:0 context:NULL];
      [_sharedNetworkQueue setMaxConcurrentOperationCount:6];
      
    });
  }
}

- (id) init {
  
  return [self initWithHostName:nil];
}

- (id) initWithHostName:(NSString*) hostName {
  
  return [self initWithHostName:hostName apiPath:nil customHeaderFields:nil];
}

- (id) initWithHostName:(NSString*) hostName apiPath:(NSString*) apiPath customHeaderFields:(NSDictionary*) headers {
  
  if((self = [super init])) {
    
    self.apiPath = apiPath;
    self.backgroundCacheQueue = dispatch_queue_create("com.mknetworkkit.cachequeue", DISPATCH_QUEUE_SERIAL);
    self.operationQueue = dispatch_queue_create("com.mknetworkkit.operationqueue", DISPATCH_QUEUE_SERIAL);
    
    if(hostName) {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(reachabilityChanged:)
                                                   name:kReachabilityChangedNotification
                                                 object:nil];
      
      self.hostName = hostName;
      self.reachability = [Reachability reachabilityWithHostname:self.hostName];
      
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.reachability startNotifier];
      });
    }
    
    if(headers[@"User-Agent"] == nil) {
      
      NSMutableDictionary *newHeadersDict = [headers mutableCopy];
      NSString *userAgentString = [NSString stringWithFormat:@"%@/%@",
                                   [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey],
                                   [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey]];
      newHeadersDict[@"User-Agent"] = userAgentString;
      self.customHeaders = newHeadersDict;
    } else {
      self.customHeaders = [headers mutableCopy];
    }
    
    self.customOperationSubclass = [MKNetworkOperation class];
  }
  
  return self;
}

- (id) initWithHostName:(NSString*) hostName customHeaderFields:(NSDictionary*) headers {
  
  return [self initWithHostName:hostName apiPath:nil customHeaderFields:headers];
}

#pragma mark -
#pragma mark Memory Mangement

-(void) dealloc {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
#if TARGET_OS_IPHONE
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
#elif TARGET_OS_MAC
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationWillHideNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationWillResignActiveNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationWillTerminateNotification object:nil];
#endif
  
}

+(void) dealloc {
  
  [_sharedNetworkQueue removeObserver:[self self] forKeyPath:@"operationCount"];
}

#pragma mark -
#pragma mark KVO for network Queue

+ (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
  if (object == _sharedNetworkQueue && [keyPath isEqualToString:@"operationCount"]) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMKNetworkEngineOperationCountChanged
                                                        object:[NSNumber numberWithInteger:(NSInteger)[_sharedNetworkQueue operationCount]]];
#if TARGET_OS_IPHONE
    [UIApplication sharedApplication].networkActivityIndicatorVisible =
    ([_sharedNetworkQueue.operations count] > 0);
#endif
  }
  else {
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
  }
}

#pragma mark -
#pragma mark Reachability related

-(void) reachabilityChanged:(NSNotification*) notification
{
  if([self.reachability currentReachabilityStatus] == ReachableViaWiFi)
  {
    DLog(@"Server [%@] is reachable via Wifi", self.hostName);
    [_sharedNetworkQueue setMaxConcurrentOperationCount:6];
    
    [self checkAndRestoreFrozenOperations];
  }
  else if([self.reachability currentReachabilityStatus] == ReachableViaWWAN)
  {
    if(self.wifiOnlyMode) {
      
      DLog(@" Disabling engine as server [%@] is reachable only via cellular data.", self.hostName);
      [_sharedNetworkQueue setMaxConcurrentOperationCount:0];
    } else {
      DLog(@"Server [%@] is reachable only via cellular data", self.hostName);
      [_sharedNetworkQueue setMaxConcurrentOperationCount:2];
      [self checkAndRestoreFrozenOperations];
    }
  }
  else if([self.reachability currentReachabilityStatus] == NotReachable)
  {
    DLog(@"Server [%@] is not reachable", self.hostName);
    [self freezeOperations];
  }
  
  if(self.reachabilityChangedHandler) {
    self.reachabilityChangedHandler([self.reachability currentReachabilityStatus]);
  }
}

#pragma mark Freezing operations (Called when network connectivity fails)
-(void) freezeOperations {
  
  if(![self isCacheEnabled]) return;
  
  for(MKNetworkOperation *operation in _sharedNetworkQueue.operations) {
    
    // freeze only freeable operations.
    if(![operation freezable]) continue;
    
    if(!self.hostName) return;
    
    // freeze only operations that belong to this server
    if([[operation url] rangeOfString:self.hostName].location == NSNotFound) continue;
    
    NSString *archivePath = [[[self cacheDirectoryName] stringByAppendingPathComponent:[operation uniqueIdentifier]]
                             stringByAppendingPathExtension:kFreezableOperationExtension];
    [NSKeyedArchiver archiveRootObject:operation toFile:archivePath];
    [operation cancel];
  }
  
}

-(void) checkAndRestoreFrozenOperations {
  
  if(![self isCacheEnabled]) return;
  
  NSError *error = nil;
  NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self cacheDirectoryName] error:&error];
  if(error)
    DLog(@"%@", error);
  
  NSArray *pendingOperations = [files filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
    
    NSString *thisFile = (NSString*) evaluatedObject;
    return ([thisFile rangeOfString:kFreezableOperationExtension].location != NSNotFound);
  }]];
  
  for(NSString *pendingOperationFile in pendingOperations) {
    
    NSString *archivePath = [[self cacheDirectoryName] stringByAppendingPathComponent:pendingOperationFile];
    MKNetworkOperation *pendingOperation = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    [self enqueueOperation:pendingOperation];
    NSError *error2 = nil;
    [[NSFileManager defaultManager] removeItemAtPath:archivePath error:&error2];
    if(error2)
      DLog(@"%@", error2);
  }
}

-(NSString*) readonlyHostName {
  
  return [_hostName copy];
}

-(BOOL) isReachable {
  
  return ([self.reachability currentReachabilityStatus] != NotReachable);
}

#pragma mark -
#pragma mark Create methods

-(void) registerOperationSubclass:(Class) aClass {
  
  self.customOperationSubclass = aClass;
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path {
  
  return [self operationWithPath:path params:nil];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSDictionary*) body {
  
  return [self operationWithPath:path
                          params:body
                      httpMethod:@"GET"];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSDictionary*) body
                              httpMethod:(NSString*)method  {
  
  return [self operationWithPath:path params:body httpMethod:method ssl:NO];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSDictionary*) body
                              httpMethod:(NSString*)method
                                     ssl:(BOOL) useSSL {
  
  if(self.hostName == nil) {
    
    DLog(@"Hostname is nil, use operationWithURLString: method to create absolute URL operations");
    return nil;
  }
  
  NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", useSSL ? @"https" : @"http", self.hostName];
  
  if(self.portNumber != 0)
    [urlString appendFormat:@":%d", self.portNumber];
  
  if(self.apiPath)
    [urlString appendFormat:@"/%@", self.apiPath];
  
  [urlString appendFormat:@"/%@", path];
  
  return [self operationWithURLString:urlString params:body httpMethod:method];
}

-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString {
  
  return [self operationWithURLString:urlString params:nil httpMethod:@"GET"];
}

-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                                       params:(NSDictionary*) body {
  
  return [self operationWithURLString:urlString params:body httpMethod:@"GET"];
}


-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                                       params:(NSDictionary*) body
                                   httpMethod:(NSString*)method {
  
  MKNetworkOperation *operation = [[self.customOperationSubclass alloc] initWithURLString:urlString params:body httpMethod:method];
  
  [self prepareHeaders:operation];
  return operation;
}

-(void) prepareHeaders:(MKNetworkOperation*) operation {
  
  [operation addHeaders:self.customHeaders];
}

-(NSData*) cachedDataForOperation:(MKNetworkOperation*) operation {
  
  NSData *cachedData = (self.memoryCache)[[operation uniqueIdentifier]];
  if(cachedData) return cachedData;
  
  NSString *filePath = [[self cacheDirectoryName] stringByAppendingPathComponent:[operation uniqueIdentifier]];
  
  if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    
    cachedData = [NSData dataWithContentsOfFile:filePath];
    [self saveCacheData:cachedData forKey:[operation uniqueIdentifier]]; // bring it back to the in-memory cache
    return cachedData;
  }
  
  return nil;
}

-(void) enqueueOperation:(MKNetworkOperation*) operation {
  
  [self enqueueOperation:operation forceReload:NO];
}

-(void) enqueueOperation:(MKNetworkOperation*) operation forceReload:(BOOL) forceReload {
  
  NSParameterAssert(operation != nil);
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [operation setCacheHandler:^(MKNetworkOperation* completedCacheableOperation) {
      
      // if this is not called, the request would have been a non cacheable request
      //completedCacheableOperation.cacheHeaders;
      NSString *uniqueId = [completedCacheableOperation uniqueIdentifier];
      [self saveCacheData:[completedCacheableOperation responseData]
                   forKey:uniqueId];
      
      (self.cacheInvalidationParams)[uniqueId] = completedCacheableOperation.cacheHeaders;
    }];
    
    __block double expiryTimeInSeconds = 0.0f;
    
    if([operation isCacheable]) {
      
      NSData *cachedData = [self cachedDataForOperation:operation];
      if(cachedData) {
        dispatch_async(dispatch_get_main_queue(), ^{
          // Jump back to the original thread here since setCachedData updates the main thread
          [operation setCachedData:cachedData];
        });
        
        if(!forceReload) {
          
          NSString *uniqueId = [operation uniqueIdentifier];
          NSMutableDictionary *savedCacheHeaders = (self.cacheInvalidationParams)[uniqueId];
          // there is a cached version.
          // this means, the current operation is a "GET"
          if(savedCacheHeaders) {
            NSString *expiresOn = savedCacheHeaders[@"Expires"];
            
            dispatch_sync(self.operationQueue, ^{
              NSDate *expiresOnDate = [NSDate dateFromRFC1123:expiresOn];
              expiryTimeInSeconds = [expiresOnDate timeIntervalSinceNow];
            });
            
            [operation updateOperationBasedOnPreviousHeaders:savedCacheHeaders];
          }
        }
      }
      
      dispatch_sync(self.operationQueue, ^{
        
        NSArray *operations = _sharedNetworkQueue.operations;
        NSUInteger index = [operations indexOfObject:operation];
        BOOL operationFinished = NO;
        if(index != NSNotFound) {
          
          MKNetworkOperation *queuedOperation = (MKNetworkOperation*) (operations)[index];
          operationFinished = [queuedOperation isFinished];
          if(!operationFinished)
            [queuedOperation updateHandlersFromOperation:operation];
        }
        
        if(expiryTimeInSeconds <= 0 || forceReload || operationFinished)
          [_sharedNetworkQueue addOperation:operation];
        // else don't do anything
      });
      
    } else {
      
      [_sharedNetworkQueue addOperation:operation];
    }
    
    if([self.reachability currentReachabilityStatus] == NotReachable)
      [self freezeOperations];
  });
}

- (MKNetworkOperation*)imageAtURL:(NSURL *)url completionHandler:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock {
 
#ifdef DEBUG
  // I could enable caching here, but that hits performance and inturn affects table view scrolling
  // if imageAtURL is called for loading thumbnails.
  if(![self isCacheEnabled]) DLog(@"imageAtURL:onCompletion: requires caching to be enabled.")
#endif
    
    if (url == nil) {
      return nil;
    }
  
  MKNetworkOperation *op = [self operationWithURLString:[url absoluteString]];
  
  [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
    
    imageFetchedBlock([completedOperation responseImage],
                      url,
                      [completedOperation isCachedResponse]);
    
  } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
    
    errorBlock(completedOperation, error);
  }];
  
  [self enqueueOperation:op];
  
  return op;
}

#if TARGET_OS_IPHONE

- (MKNetworkOperation*)imageAtURL:(NSURL *)url size:(CGSize) size completionHandler:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock {
    
#ifdef DEBUG
  // I could enable caching here, but that hits performance and inturn affects table view scrolling
  // if imageAtURL is called for loading thumbnails.
  if(![self isCacheEnabled]) DLog(@"imageAtURL:size:onCompletion: requires caching to be enabled.")
#endif
    
    if (url == nil) {
      return nil;
    }
  
  MKNetworkOperation *op = [self operationWithURLString:[url absoluteString]];
  
  [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
    [completedOperation decompressedResponseImageOfSize:size
                                      completionHandler:^(UIImage *decompressedImage) {
                                        
                                        imageFetchedBlock(decompressedImage,
                                                          url,
                                                          [completedOperation isCachedResponse]);
                                      }];
  } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
    
    errorBlock(completedOperation, error);
    DLog(@"%@", error);
  }];
  
  [self enqueueOperation:op];
  
  return op;
}

- (MKNetworkOperation*)imageAtURL:(NSURL *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock {
  
  return [self imageAtURL:url size:size completionHandler:imageFetchedBlock errorHandler:^(MKNetworkOperation* op, NSError* error){}];
}

#endif

- (MKNetworkOperation*)imageAtURL:(NSURL *)url onCompletion:(MKNKImageBlock) imageFetchedBlock
{
  return [self imageAtURL:url completionHandler:imageFetchedBlock errorHandler:^(MKNetworkOperation* op, NSError* error){}];
}


#pragma mark -
#pragma mark Cache related

-(NSString*) cacheDirectoryName {
  
  static NSString *cacheDirectoryName = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:MKNETWORKCACHE_DEFAULT_DIRECTORY];
  });
  
  return cacheDirectoryName;
}

-(int) cacheMemoryCost {
  
  return MKNETWORKCACHE_DEFAULT_COST;
}

-(void) saveCache {
  
  for(NSString *cacheKey in [self.memoryCache allKeys])
  {
    NSString *filePath = [[self cacheDirectoryName] stringByAppendingPathComponent:cacheKey];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
      
      NSError *error = nil;
      [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
      ELog(error);
    }
    
    [(self.memoryCache)[cacheKey] writeToFile:filePath atomically:YES];
  }
  
  [self.memoryCache removeAllObjects];
  [self.memoryCacheKeys removeAllObjects];
  
  NSString *cacheInvalidationPlistFilePath = [[self cacheDirectoryName] stringByAppendingPathExtension:@"plist"];
  [self.cacheInvalidationParams writeToFile:cacheInvalidationPlistFilePath atomically:YES];
}

-(void) saveCacheData:(NSData*) data forKey:(NSString*) cacheDataKey
{
  dispatch_async(self.backgroundCacheQueue, ^{
    
    (self.memoryCache)[cacheDataKey] = data;
    
    NSUInteger index = [self.memoryCacheKeys indexOfObject:cacheDataKey];
    if(index != NSNotFound)
      [self.memoryCacheKeys removeObjectAtIndex:index];
    
    [self.memoryCacheKeys insertObject:cacheDataKey atIndex:0]; // remove it and insert it at start
    
    if([self.memoryCacheKeys count] >= (NSUInteger)[self cacheMemoryCost])
    {
      NSString *lastKey = [self.memoryCacheKeys lastObject];
      NSData *data2 = (self.memoryCache)[lastKey];
      NSString *filePath = [[self cacheDirectoryName] stringByAppendingPathComponent:lastKey];
      
      if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        ELog(error);
      }
      [data2 writeToFile:filePath atomically:YES];
      
      [self.memoryCacheKeys removeLastObject];
      [self.memoryCache removeObjectForKey:lastKey];
    }
  });
}

/*
 - (BOOL) dataOldness:(NSString*) imagePath
 {
 NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:imagePath error:nil];
 NSDate *creationDate = [attributes valueForKey:NSFileCreationDate];
 
 return abs([creationDate timeIntervalSinceNow]);
 }*/

-(BOOL) isCacheEnabled {
  
  BOOL isDir = NO;
  BOOL isCachingEnabled = [[NSFileManager defaultManager] fileExistsAtPath:[self cacheDirectoryName] isDirectory:&isDir];
  return isCachingEnabled;
}

-(void) useCache {
  
  self.memoryCache = [NSMutableDictionary dictionaryWithCapacity:[self cacheMemoryCost]];
  self.memoryCacheKeys = [NSMutableArray arrayWithCapacity:[self cacheMemoryCost]];
  self.cacheInvalidationParams = [NSMutableDictionary dictionary];
  
  NSString *cacheDirectory = [self cacheDirectoryName];
  BOOL isDirectory = YES;
  BOOL folderExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheDirectory isDirectory:&isDirectory] && isDirectory;
  
  if (!folderExists)
  {
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:&error];
  }
  
  NSString *cacheInvalidationPlistFilePath = [cacheDirectory stringByAppendingPathExtension:@"plist"];
  
  BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheInvalidationPlistFilePath];
  
  if (fileExists)
  {
    self.cacheInvalidationParams = [NSMutableDictionary dictionaryWithContentsOfFile:cacheInvalidationPlistFilePath];
  }
  
#if TARGET_OS_IPHONE
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:UIApplicationWillTerminateNotification
                                             object:nil];
  
#elif TARGET_OS_MAC
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:NSApplicationWillHideNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:NSApplicationWillResignActiveNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCache)
                                               name:NSApplicationWillTerminateNotification
                                             object:nil];
  
#endif
  
  
}

-(void) emptyCache {
  
  [self saveCache]; // ensures that invalidation params are written to disk properly
  NSError *error = nil;
  NSArray *directoryContents = [[NSFileManager defaultManager]
                                contentsOfDirectoryAtPath:[self cacheDirectoryName] error:&error];
  if(error) DLog(@"%@", error);
  
  error = nil;
  for(NSString *fileName in directoryContents) {
    
    NSString *path = [[self cacheDirectoryName] stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if(error) DLog(@"%@", error);
  }
  
  error = nil;
  NSString *cacheInvalidationPlistFilePath = [[self cacheDirectoryName] stringByAppendingPathExtension:@"plist"];
  [[NSFileManager defaultManager] removeItemAtPath:cacheInvalidationPlistFilePath error:&error];
  if(error) DLog(@"%@", error);
}

@end
