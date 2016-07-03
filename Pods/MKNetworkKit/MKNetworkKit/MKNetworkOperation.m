//
//  MKNetworkOperation.m
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

OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,
                                 SecIdentityRef *outIdentity,
                                 SecTrustRef *outTrust,
                                 CFStringRef keyPassword);

@interface MKNetworkOperation (/*Private Methods*/)
@property (strong, nonatomic) NSURLConnection *connection;
@property (copy, nonatomic) NSString *uniqueId;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) NSHTTPURLResponse *response;

@property (strong, nonatomic) NSMutableDictionary *fieldsToBePosted;
@property (strong, nonatomic) NSMutableArray *filesToBePosted;
@property (strong, nonatomic) NSMutableArray *dataToBePosted;

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

@property (nonatomic, strong) NSMutableArray *responseBlocks;
@property (nonatomic, strong) NSMutableArray *errorBlocks;
@property (nonatomic, strong) NSMutableArray *errorBlocksType2;

@property (nonatomic, assign) MKNetworkOperationState state;
@property (nonatomic, assign) BOOL isCancelled;

@property (strong, nonatomic) NSMutableData *mutableData;
@property (assign, nonatomic) NSUInteger downloadedDataSize;

@property (nonatomic, strong) NSMutableArray *notModifiedHandlers;

@property (nonatomic, strong) NSMutableArray *uploadProgressChangedHandlers;
@property (nonatomic, strong) NSMutableArray *downloadProgressChangedHandlers;
@property (nonatomic, copy) MKNKEncodingBlock postDataEncodingHandler;

@property (nonatomic, assign) NSInteger startPosition;

@property (nonatomic, strong) NSMutableArray *downloadStreams;
@property (nonatomic, copy) NSData *cachedResponse;
@property (nonatomic, copy) MKNKResponseBlock cacheHandlingBlock;

@property (nonatomic, assign) SecTrustRef serverTrust;

#if TARGET_OS_IPHONE
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskId;
#endif

@property (strong, nonatomic) NSError *error;

- (id)initWithURLString:(NSString *)aURLString
                 params:(NSDictionary *)body
             httpMethod:(NSString *)method;

-(NSData*) bodyData;

-(NSString*) encodedPostDataString;
- (void) showLocalNotification;
- (void) endBackgroundTask;

@end

@implementation MKNetworkOperation

@dynamic freezable;

// A RESTful service should always return the same response for a given URL and it's parameters.
// this means if these values are correct, you can cache the responses
// This is another reason why we check only GET methods.
// even if URL and others are same, POST, DELETE, PUT methods should not be cached and should not be treated equal.

-(BOOL) isCacheable {
  
  return [self.request.HTTPMethod isEqualToString:@"GET"];
}


//===========================================================
// + (BOOL)automaticallyNotifiesObserversForKey:
//
//===========================================================
+ (BOOL)automaticallyNotifiesObserversForKey: (NSString *)theKey
{
  BOOL automatic;
  
  if ([theKey isEqualToString:@"postDataEncoding"]) {
    automatic = NO;
  } else {
    automatic = [super automaticallyNotifiesObserversForKey:theKey];
  }
  
  return automatic;
}

//===========================================================
//  postDataEncoding
//===========================================================
- (MKNKPostDataEncodingType)postDataEncoding
{
  return _postDataEncoding;
}
- (void)setPostDataEncoding:(MKNKPostDataEncodingType)aPostDataEncoding
{
  _postDataEncoding = aPostDataEncoding;
  
  NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
  
  switch (self.postDataEncoding) {
      
    case MKNKPostDataEncodingTypeURL: {
      [self.request setValue:
       [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset]
          forHTTPHeaderField:@"Content-Type"];
    }
      break;
    case MKNKPostDataEncodingTypeJSON: {
      [self.request setValue:
       [NSString stringWithFormat:@"application/json; charset=%@", charset]
          forHTTPHeaderField:@"Content-Type"];
    }
      break;
    case MKNKPostDataEncodingTypePlist: {
      [self.request setValue:
       [NSString stringWithFormat:@"application/x-plist; charset=%@", charset]
          forHTTPHeaderField:@"Content-Type"];
    }
      
    default:
      break;
  }
}

-(NSString*) encodedPostDataString {
  
  NSString *returnValue = @"";
  if(self.postDataEncodingHandler)
    returnValue = self.postDataEncodingHandler(self.fieldsToBePosted);
  else if(self.postDataEncoding == MKNKPostDataEncodingTypeURL)
    returnValue = [self.fieldsToBePosted urlEncodedKeyValueString];
  else if(self.postDataEncoding == MKNKPostDataEncodingTypeJSON)
    returnValue = [self.fieldsToBePosted jsonEncodedKeyValueString];
  else if(self.postDataEncoding == MKNKPostDataEncodingTypePlist)
    returnValue = [self.fieldsToBePosted plistEncodedKeyValueString];
  return returnValue;
}

-(void) setCustomPostDataEncodingHandler:(MKNKEncodingBlock) postDataEncodingHandler forType:(NSString*) contentType {
  
  NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
  self.postDataEncoding = MKNKPostDataEncodingTypeCustom;
  self.postDataEncodingHandler = postDataEncodingHandler;
  [self.request setValue:
   [NSString stringWithFormat:@"%@; charset=%@", contentType, charset]
      forHTTPHeaderField:@"Content-Type"];
}
//===========================================================
//  freezable
//===========================================================
- (BOOL)freezable
{
  return _freezable;
}

-(NSString*) url {
  
  return [[self.request URL] absoluteString];
}

-(NSURLRequest*) readonlyRequest {
  
  return [self.request copy];
}

-(NSHTTPURLResponse*) readonlyResponse {
  
  return [self.response copy];
}

- (NSDictionary *) readonlyPostDictionary {
  
  return [self.fieldsToBePosted copy];
}

-(NSString*) HTTPMethod {
  
  return self.request.HTTPMethod;
}

-(NSInteger) HTTPStatusCode {
  
  if(self.response)
    return self.response.statusCode;
  else
    return 0;
}

- (void)setFreezable:(BOOL)flag
{
  // get method cannot be frozen.
  // No point in freezing a method that doesn't change server state.
  if([self.request.HTTPMethod isEqualToString:@"GET"] && flag) return;
  _freezable = flag;
  
  if(_freezable && self.uniqueId == nil)
    self.uniqueId = [NSString uniqueString];
}


-(BOOL) isEqual:(id)object {
  
  if([self.request.HTTPMethod isEqualToString:@"GET"] || [self.request.HTTPMethod isEqualToString:@"HEAD"]) {
    
    MKNetworkOperation *anotherObject = (MKNetworkOperation*) object;
    return ([[self uniqueIdentifier] isEqualToString:[anotherObject uniqueIdentifier]]);
  }
  
  return NO;
}


-(NSString*) uniqueIdentifier {
  
  NSMutableString *str = [NSMutableString stringWithFormat:@"%@ %@", self.request.HTTPMethod, self.url];
  
  if(self.username || self.password) {
    
    [str appendFormat:@" [%@:%@]",
     self.username ? self.username : @"",
     self.password ? self.password : @""];
  }
  
  if(self.freezable) {
    
    [str appendString:self.uniqueId];
  }
  return [str md5];
}

-(BOOL) isCachedResponse {
  
  return self.cachedResponse != nil;
}

-(void) notifyCache {
  
  if(![self isCacheable]) return;
  if(!([self.response statusCode] >= 200 && [self.response statusCode] < 300)) return;
  
  if(![self isCancelled])
    self.cacheHandlingBlock(self);
}

-(MKNetworkOperationState) state {
  
  return (MKNetworkOperationState)_state;
}

-(void) setState:(MKNetworkOperationState)newState {
  
  switch (newState) {
    case MKNetworkOperationStateReady:
      [self willChangeValueForKey:@"isReady"];
      break;
    case MKNetworkOperationStateExecuting:
      [self willChangeValueForKey:@"isReady"];
      [self willChangeValueForKey:@"isExecuting"];
      break;
    case MKNetworkOperationStateFinished:
      [self willChangeValueForKey:@"isExecuting"];
      [self willChangeValueForKey:@"isFinished"];
      break;
  }
  
  _state = newState;
  
  switch (newState) {
    case MKNetworkOperationStateReady:
      [self didChangeValueForKey:@"isReady"];
      break;
    case MKNetworkOperationStateExecuting:
      [self didChangeValueForKey:@"isReady"];
      [self didChangeValueForKey:@"isExecuting"];
      break;
    case MKNetworkOperationStateFinished:
      [self didChangeValueForKey:@"isExecuting"];
      [self didChangeValueForKey:@"isFinished"];
      break;
  }
  
  if(self.operationStateChangedHandler) {
    self.operationStateChangedHandler(newState);
  }
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeInteger:(NSInteger)self.stringEncoding forKey:@"stringEncoding"];
  [encoder encodeInteger:_postDataEncoding forKey:@"postDataEncoding"];
  
  [encoder encodeObject:self.uniqueId forKey:@"uniqueId"];
  [encoder encodeObject:self.request forKey:@"request"];
  [encoder encodeObject:self.response forKey:@"response"];
  [encoder encodeObject:self.fieldsToBePosted forKey:@"fieldsToBePosted"];
  [encoder encodeObject:self.filesToBePosted forKey:@"filesToBePosted"];
  [encoder encodeObject:self.dataToBePosted forKey:@"dataToBePosted"];
  [encoder encodeObject:self.username forKey:@"username"];
  [encoder encodeObject:self.password forKey:@"password"];
  [encoder encodeObject:self.clientCertificate forKey:@"clientCertificate"];
  [encoder encodeObject:self.clientCertificatePassword forKey:@"clientCertificatePassword"];
  [encoder encodeBool:self.shouldContinueWithInvalidCertificate forKey:@"shouldContinueWithInvalidCertificate"];
#if TARGET_OS_IPHONE
  [encoder encodeObject:self.localNotification forKey:@"localNotification"];
#endif
  self.state = MKNetworkOperationStateReady;
  [encoder encodeInt32:_state forKey:@"state"];
  [encoder encodeBool:self.isCancelled forKey:@"isCancelled"];
  [encoder encodeObject:self.mutableData forKey:@"mutableData"];
  [encoder encodeInteger:(NSInteger)self.downloadedDataSize forKey:@"downloadedDataSize"];
  [encoder encodeObject:self.downloadStreams forKey:@"downloadStreams"];
  [encoder encodeInteger:self.startPosition forKey:@"startPosition"];
  [encoder encodeInteger:self.credentialPersistence forKey:@"credentialPersistence"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  self = [super init];
  if (self) {
    [self setStringEncoding:(NSStringEncoding)[decoder decodeIntegerForKey:@"stringEncoding"]];
    _postDataEncoding = (MKNKPostDataEncodingType) [decoder decodeIntegerForKey:@"postDataEncoding"];
    self.request = [decoder decodeObjectForKey:@"request"];
    self.uniqueId = [decoder decodeObjectForKey:@"uniqueId"];
    
    self.response = [decoder decodeObjectForKey:@"response"];
    self.fieldsToBePosted = [decoder decodeObjectForKey:@"fieldsToBePosted"];
    self.filesToBePosted = [decoder decodeObjectForKey:@"filesToBePosted"];
    self.dataToBePosted = [decoder decodeObjectForKey:@"dataToBePosted"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.password = [decoder decodeObjectForKey:@"password"];
    self.clientCertificate = [decoder decodeObjectForKey:@"clientCertificate"];
    self.clientCertificatePassword = [decoder decodeObjectForKey:@"clientCertificatePassword"];
#if TARGET_OS_IPHONE
    self.localNotification = [decoder decodeObjectForKey:@"localNotification"];
#endif
    [self setState:(MKNetworkOperationState)[decoder decodeInt32ForKey:@"state"]];
    self.isCancelled = [decoder decodeBoolForKey:@"isCancelled"];
    self.mutableData = [decoder decodeObjectForKey:@"mutableData"];
    self.downloadedDataSize = [decoder decodeIntegerForKey:@"downloadedDataSize"];
    self.downloadStreams = [decoder decodeObjectForKey:@"downloadStreams"];
    self.startPosition = [decoder decodeIntegerForKey:@"startPosition"];
    self.credentialPersistence = [decoder decodeIntegerForKey:@"credentialPersistence"];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  MKNetworkOperation *theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
  
  theCopy.postDataEncoding = _postDataEncoding;
  [theCopy setStringEncoding:self.stringEncoding];
  [theCopy setUniqueId:[self.uniqueId copy]];
  
  [theCopy setConnection:[self.connection copy]];
  [theCopy setRequest:[self.request copy]];
  [theCopy setResponse:[self.response copy]];
  [theCopy setFieldsToBePosted:[self.fieldsToBePosted copy]];
  [theCopy setFilesToBePosted:[self.filesToBePosted copy]];
  [theCopy setDataToBePosted:[self.dataToBePosted copy]];
  [theCopy setUsername:[self.username copy]];
  [theCopy setPassword:[self.password copy]];
  [theCopy setClientCertificate:[self.clientCertificate copy]];
  [theCopy setResponseBlocks:[self.responseBlocks copy]];
  [theCopy setErrorBlocks:[self.errorBlocks copy]];
  [theCopy setErrorBlocksType2:[self.errorBlocksType2 copy]];
  [theCopy setState:self.state];
  [theCopy setIsCancelled:self.isCancelled];
  [theCopy setMutableData:[self.mutableData copy]];
  [theCopy setDownloadedDataSize:self.downloadedDataSize];
  [theCopy setNotModifiedHandlers:[self.notModifiedHandlers copy]];
  [theCopy setUploadProgressChangedHandlers:[self.uploadProgressChangedHandlers copy]];
  [theCopy setDownloadProgressChangedHandlers:[self.downloadProgressChangedHandlers copy]];
  [theCopy setDownloadStreams:[self.downloadStreams copy]];
  [theCopy setCachedResponse:[self.cachedResponse copy]];
  [theCopy setCacheHandlingBlock:self.cacheHandlingBlock];
  [theCopy setStartPosition:self.startPosition];
  [theCopy setCredentialPersistence:self.credentialPersistence];
  
  return theCopy;
}

-(void) dealloc {
  
  [_connection cancel];
  _connection = nil;
}

-(void) updateHandlersFromOperation:(MKNetworkOperation*) operation {
  
  [self.responseBlocks addObjectsFromArray:operation.responseBlocks];
  [self.errorBlocks addObjectsFromArray:operation.errorBlocks];
  [self.errorBlocksType2 addObjectsFromArray:operation.errorBlocksType2];
  [self.notModifiedHandlers addObjectsFromArray:operation.notModifiedHandlers];
  [self.uploadProgressChangedHandlers addObjectsFromArray:operation.uploadProgressChangedHandlers];
  [self.downloadProgressChangedHandlers addObjectsFromArray:operation.downloadProgressChangedHandlers];
  [self.downloadStreams addObjectsFromArray:operation.downloadStreams];
}

-(void) setCachedData:(NSData*) cachedData {
  
  self.cachedResponse = cachedData;
  [self operationSucceeded];
}

-(void) updateOperationBasedOnPreviousHeaders:(NSMutableDictionary*) headers {
  
  NSString *lastModified = headers[@"Last-Modified"];
  NSString *eTag = headers[@"ETag"];
  if(lastModified) {
    [self.request setValue:lastModified forHTTPHeaderField:@"IF-MODIFIED-SINCE"];
  }
  
  if(eTag) {
    [self.request setValue:eTag forHTTPHeaderField:@"IF-NONE-MATCH"];
  }
}

-(void) setUsername:(NSString*) username password:(NSString*) password {
  
  self.username = username;
  self.password = password;
}

-(void) setUsername:(NSString*) username password:(NSString*) password basicAuth:(BOOL) bYesOrNo {
  
  [self setUsername:username password:password];
  NSString *base64EncodedString = [[[NSString stringWithFormat:@"%@:%@", self.username, self.password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
  
  [self setAuthorizationHeaderValue:base64EncodedString forAuthType:@"Basic"];
}

-(void) onCompletion:(MKNKResponseBlock) response onError:(MKNKErrorBlock) error {
  
  [self.responseBlocks addObject:[response copy]];
  [self.errorBlocks addObject:[error copy]];
}

-(void) addCompletionHandler:(MKNKResponseBlock)response errorHandler:(MKNKResponseErrorBlock)error {
  
  if(response)
    [self.responseBlocks addObject:[response copy]];
  if(error)
    [self.errorBlocksType2 addObject:[error copy]];
}

-(void) onNotModified:(MKNKVoidBlock)notModifiedBlock {
  
  [self.notModifiedHandlers addObject:[notModifiedBlock copy]];
}

-(void) onUploadProgressChanged:(MKNKProgressBlock) uploadProgressBlock {
  
  [self.uploadProgressChangedHandlers addObject:[uploadProgressBlock copy]];
}

-(void) onDownloadProgressChanged:(MKNKProgressBlock) downloadProgressBlock {
  
  [self.downloadProgressChangedHandlers addObject:[downloadProgressBlock copy]];
}

-(void) setUploadStream:(NSInputStream*) inputStream {
  
#warning Method not tested yet.
  self.request.HTTPBodyStream = inputStream;
}

-(void) addDownloadStream:(NSOutputStream*) outputStream {
  
  [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
  [self.downloadStreams addObject:outputStream];
}

- (id)initWithURLString:(NSString *)aURLString
                 params:(NSDictionary *)params
             httpMethod:(NSString *)method

{
  if((self = [super init])) {
    
    self.responseBlocks = [NSMutableArray array];
    self.errorBlocks = [NSMutableArray array];
    self.errorBlocksType2 = [NSMutableArray array];
    self.filesToBePosted = [NSMutableArray array];
    self.dataToBePosted = [NSMutableArray array];
    self.fieldsToBePosted = [NSMutableDictionary dictionary];
    
    self.notModifiedHandlers = [NSMutableArray array];
    self.uploadProgressChangedHandlers = [NSMutableArray array];
    self.downloadProgressChangedHandlers = [NSMutableArray array];
    self.downloadStreams = [NSMutableArray array];
    
    self.credentialPersistence = NSURLCredentialPersistenceForSession;
    
    NSURL *finalURL = nil;
    
    if(params)
      self.fieldsToBePosted = [params mutableCopy];
    
    self.stringEncoding = NSUTF8StringEncoding; // use a delegate to get these values later
    
    if ([method isEqualToString:@"GET"])
      self.cacheHeaders = [NSMutableDictionary dictionary];
    
    if (([method isEqualToString:@"GET"] ||
         [method isEqualToString:@"DELETE"]) && (params && [params count] > 0)) {
      
      finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", aURLString,
                                       [self encodedPostDataString]]];
    } else {
      finalURL = [NSURL URLWithString:aURLString];
    }
    
    self.request = [NSMutableURLRequest requestWithURL:finalURL
                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:kMKNetworkKitRequestTimeOutInSeconds];
    
    [self.request setHTTPMethod:method];
    
    [self.request setValue:[NSString stringWithFormat:@"%@, en-us",
                            [[NSLocale preferredLanguages] componentsJoinedByString:@", "]
                            ] forHTTPHeaderField:@"Accept-Language"];
    
    if (([method isEqualToString:@"POST"] ||
         [method isEqualToString:@"PUT"]) && (params && [params count] > 0)) {
      
      self.postDataEncoding = MKNKPostDataEncodingTypeURL;
    }
    
    self.state = MKNetworkOperationStateReady;
  }
  
  return self;
}

-(void) addHeaders:(NSDictionary*) headersDictionary {
  
  [headersDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [self.request addValue:obj forHTTPHeaderField:key];
  }];
}

-(void) setAuthorizationHeaderValue:(NSString*) token forAuthType:(NSString*) authType {
  
  [self.request setValue:[NSString stringWithFormat:@"%@ %@", authType, token]
      forHTTPHeaderField:@"Authorization"];
}
/*
 Printing a MKNetworkOperation object is printed in curl syntax
 */

-(NSString*) description {
  
  NSMutableString *displayString = [NSMutableString stringWithFormat:@"%@\nRequest\n-------\n%@",
                                    [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],
                                    [self curlCommandLineString]];
  
  NSString *responseString = [self responseString];
  if([responseString length] > 0) {
    [displayString appendFormat:@"\n--------\nResponse\n--------\n%@\n", responseString];
  }
  
  return displayString;
}

-(NSString*) curlCommandLineString
{
  __block NSMutableString *displayString = [NSMutableString stringWithFormat:@"curl -X %@", self.request.HTTPMethod];
  
  if([self.filesToBePosted count] == 0 && [self.dataToBePosted count] == 0) {
    [[self.request allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop)
     {
       [displayString appendFormat:@" -H \"%@: %@\"", key, val];
     }];
  }
  
  [displayString appendFormat:@" \"%@\"",  self.url];
  
  if ([self.request.HTTPMethod isEqualToString:@"POST"] ||
      [self.request.HTTPMethod isEqualToString:@"PUT"] ||
      [self.request.HTTPMethod isEqualToString:@"PATCH"]) {
    
    NSString *option = [self.filesToBePosted count] == 0 ? @"-d" : @"-F";
    if(self.postDataEncoding == MKNKPostDataEncodingTypeURL) {
      [self.fieldsToBePosted enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [displayString appendFormat:@" %@ \"%@=%@\"", option, key, obj];
      }];
    } else {
      [displayString appendFormat:@" -d \"%@\"", [self encodedPostDataString]];
    }
    
    
    [self.filesToBePosted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      
      NSDictionary *thisFile = (NSDictionary*) obj;
      [displayString appendFormat:@" -F \"%@=@%@;type=%@\"", thisFile[@"name"],
       thisFile[@"filepath"], thisFile[@"mimetype"]];
    }];
    
    /* Not sure how to do this via curl
     [self.dataToBePosted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     
     NSDictionary *thisData = (NSDictionary*) obj;
     [displayString appendFormat:@" --data-binary \"%@\"", [thisData objectForKey:@"data"]];
     }];*/
  }
  
  return displayString;
}


-(void) addData:(NSData*) data forKey:(NSString*) key {
  
  [self addData:data forKey:key mimeType:@"application/octet-stream" fileName:@"file"];
}

-(void) addData:(NSData*) data forKey:(NSString*) key mimeType:(NSString*) mimeType fileName:(NSString*) fileName {
  
  if ([self.request.HTTPMethod isEqualToString:@"GET"]) {
    [self.request setHTTPMethod:@"POST"];
  }
  
  NSDictionary *dict = @{@"data": data,
  @"name": key,
  @"mimetype": mimeType,
  @"filename": fileName};
  
  [self.dataToBePosted addObject:dict];
}

-(void) addFile:(NSString*) filePath forKey:(NSString*) key {
  
  [self addFile:filePath forKey:key mimeType:@"application/octet-stream"];
}

-(void) addFile:(NSString*) filePath forKey:(NSString*) key mimeType:(NSString*) mimeType {
  
  if ([self.request.HTTPMethod isEqualToString:@"GET"]) {
    [self.request setHTTPMethod:@"POST"];
  }
  
  NSDictionary *dict = @{@"filepath": filePath,
  @"name": key,
  @"mimetype": mimeType};
  
  [self.filesToBePosted addObject:dict];
}

-(NSData*) bodyData {
  
  if([self.filesToBePosted count] == 0 && [self.dataToBePosted count] == 0) {
    
    return [[self encodedPostDataString] dataUsingEncoding:self.stringEncoding];
  }
  
  NSString *boundary = @"0xKhTmLbOuNdArY";
  NSMutableData *body = [NSMutableData data];
  __block NSUInteger postLength = 0;
  
  [self.fieldsToBePosted enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    
    NSString *thisFieldString = [NSString stringWithFormat:
                                 @"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@",
                                 boundary, key, obj];
    
    [body appendData:[thisFieldString dataUsingEncoding:[self stringEncoding]]];
    [body appendData:[@"\r\n" dataUsingEncoding:[self stringEncoding]]];
  }];
  
  [self.filesToBePosted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
    NSDictionary *thisFile = (NSDictionary*) obj;
    NSString *thisFieldString = [NSString stringWithFormat:
                                 @"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\nContent-Transfer-Encoding: binary\r\n\r\n",
                                 boundary,
                                 thisFile[@"name"],
                                 [thisFile[@"filepath"] lastPathComponent],
                                 thisFile[@"mimetype"]];
    
    [body appendData:[thisFieldString dataUsingEncoding:[self stringEncoding]]];
    [body appendData: [NSData dataWithContentsOfFile:thisFile[@"filepath"]]];
    [body appendData:[@"\r\n" dataUsingEncoding:[self stringEncoding]]];
  }];
  
  [self.dataToBePosted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
    NSDictionary *thisDataObject = (NSDictionary*) obj;
    NSString *thisFieldString = [NSString stringWithFormat:
                                 @"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\nContent-Transfer-Encoding: binary\r\n\r\n",
                                 boundary,
                                 thisDataObject[@"name"],
                                 thisDataObject[@"filename"],
                                 thisDataObject[@"mimetype"]];
    
    [body appendData:[thisFieldString dataUsingEncoding:[self stringEncoding]]];
    [body appendData:thisDataObject[@"data"]];
    [body appendData:[@"\r\n" dataUsingEncoding:[self stringEncoding]]];
  }];
  
  if (postLength >= 1)
    [self.request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) postLength] forHTTPHeaderField:@"Content-Length"];
  
  [body appendData: [[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:self.stringEncoding]];
  
  NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
  
  if(([self.filesToBePosted count] > 0) || ([self.dataToBePosted count] > 0)) {
    [self.request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, boundary]
        forHTTPHeaderField:@"Content-Type"];
    
    [self.request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [body length]] forHTTPHeaderField:@"Content-Length"];
  }
  
  return body;
}


-(void) setCacheHandler:(MKNKResponseBlock) cacheHandler {
  
  self.cacheHandlingBlock = cacheHandler;
}

#pragma mark -
#pragma Main method
-(void) main {
  
  @autoreleasepool {
    [self start];
  }
}

-(void) endBackgroundTask {
  
#if TARGET_OS_IPHONE
  dispatch_async(dispatch_get_main_queue(), ^{
    if (self.backgroundTaskId != UIBackgroundTaskInvalid) {
      [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskId];
      self.backgroundTaskId = UIBackgroundTaskInvalid;
    }
  });
#endif
}

- (void) start
{
  
#if TARGET_OS_IPHONE
  self.backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    
    dispatch_async(dispatch_get_main_queue(), ^{
      if (self.backgroundTaskId != UIBackgroundTaskInvalid)
      {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskId];
        self.backgroundTaskId = UIBackgroundTaskInvalid;
        [self cancel];
      }
    });
  }];
  
#endif
  
  if(!self.isCancelled) {
    
    if (([self.request.HTTPMethod isEqualToString:@"POST"] ||
         [self.request.HTTPMethod isEqualToString:@"PUT"] ||
         [self.request.HTTPMethod isEqualToString:@"PATCH"]) && !self.request.HTTPBodyStream) {
      
      [self.request setHTTPBody:[self bodyData]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.connection = [[NSURLConnection alloc] initWithRequest:self.request
                                                        delegate:self
                                                startImmediately:NO];
      
      [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                 forMode:NSRunLoopCommonModes];
      
      [self.connection start];
    });
    
    self.state = MKNetworkOperationStateExecuting;
  }
  else {
    self.state = MKNetworkOperationStateFinished;
    [self endBackgroundTask];
  }
}

#pragma -
#pragma mark NSOperation stuff

- (BOOL)isConcurrent
{
  return YES;
}

- (BOOL)isReady {
  
  return (self.state == MKNetworkOperationStateReady && [super isReady]);
}

- (BOOL)isFinished
{
  return (self.state == MKNetworkOperationStateFinished);
}

- (BOOL)isExecuting {
  
  return (self.state == MKNetworkOperationStateExecuting);
}

-(void) cancel {
  
  if([self isFinished])
    return;
  
  @synchronized(self) {
    self.isCancelled = YES;
    
    [self.connection cancel];
    
    [self.responseBlocks removeAllObjects];
    self.responseBlocks = nil;
    
    [self.errorBlocks removeAllObjects];
    self.errorBlocks = nil;
    
    [self.errorBlocksType2 removeAllObjects];
    self.errorBlocksType2 = nil;
    
    [self.notModifiedHandlers removeAllObjects];
    self.notModifiedHandlers = nil;
    
    [self.uploadProgressChangedHandlers removeAllObjects];
    self.uploadProgressChangedHandlers = nil;
    
    [self.downloadProgressChangedHandlers removeAllObjects];
    self.downloadProgressChangedHandlers = nil;
    
    for(NSOutputStream *stream in self.downloadStreams)
      [stream close];
    
    [self.downloadStreams removeAllObjects];
    self.downloadStreams = nil;
    
    self.authHandler = nil;
    self.mutableData = nil;
    self.downloadedDataSize = 0;
    
    self.cacheHandlingBlock = nil;
    
    if(self.state == MKNetworkOperationStateExecuting)
      self.state = MKNetworkOperationStateFinished; // This notifies the queue and removes the operation.
    // if the operation is not removed, the spinner continues to spin, not a good UX
    
    [self endBackgroundTask];
  }
  [super cancel];
}

#pragma mark -
#pragma mark NSURLConnection delegates

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  
  self.state = MKNetworkOperationStateFinished;
  self.mutableData = nil;
  self.downloadedDataSize = 0;
  for(NSOutputStream *stream in self.downloadStreams)
    [stream close];
  
  [self operationFailedWithError:error];
  [self endBackgroundTask];
}

// https://developer.apple.com/library/mac/#documentation/security/conceptual/CertKeyTrustProgGuide/iPhone_Tasks/iPhone_Tasks.html
OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,        // 5
                                 SecIdentityRef *outIdentity,
                                 SecTrustRef *outTrust,
                                 CFStringRef keyPassword)
{
  OSStatus securityError = errSecSuccess;
  
  
  const void *keys[] =   { kSecImportExportPassphrase };
  const void *values[] = { keyPassword };
  CFDictionaryRef optionsDictionary = NULL;
  
  /* Create a dictionary containing the passphrase if one
   was specified.  Otherwise, create an empty dictionary. */
  optionsDictionary = CFDictionaryCreate(
                                         NULL, keys,
                                         values, (keyPassword ? 1 : 0),
                                         NULL, NULL);  // 6
  
  CFArrayRef items = NULL;
  securityError = SecPKCS12Import(inPKCS12Data,
                                  optionsDictionary,
                                  &items);                    // 7
  
  
  //
  if (securityError == 0) {                                   // 8
    CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
    const void *tempIdentity = NULL;
    tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,
                                         kSecImportItemIdentity);
    CFRetain(tempIdentity);
    *outIdentity = (SecIdentityRef)tempIdentity;
    const void *tempTrust = NULL;
    tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
    
    CFRetain(tempTrust);
    *outTrust = (SecTrustRef)tempTrust;
  }
  
  if (optionsDictionary)
    CFRelease(optionsDictionary);                           // 9
  
  if (items)
    CFRelease(items);
  
  return securityError;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  
  if (challenge.previousFailureCount == 0) {
    
    if (((challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodDefault) ||
         (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic) ||
         (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPDigest) ||
         (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodNTLM)) &&
        (self.username && self.password))
    {
      
      // for NTLM, we will assume user name to be of the form "domain\\username"
      NSURLCredential *credential = [NSURLCredential credentialWithUser:self.username
                                                               password:self.password
                                                            persistence:self.credentialPersistence];
      
      [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }
    else if ((challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate) && self.clientCertificate) {
      
      NSError *error = nil;
      NSData *certData = [[NSData alloc] initWithContentsOfFile:self.clientCertificate options:0 error:&error];
      
      SecIdentityRef identity;
      SecTrustRef trust;
      OSStatus status = extractIdentityAndTrust((__bridge CFDataRef) certData, &identity, &trust, (__bridge CFStringRef) self.clientCertificatePassword);
      if(status == errSecSuccess) {
        SecCertificateRef certificate;
        SecIdentityCopyCertificate(identity, &certificate);
        const void *certs[] = { certificate };
        CFArrayRef certsArray = CFArrayCreate(NULL, certs, 1, NULL);
        NSArray *certificatesForCredential = (__bridge NSArray *)certsArray;
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity
                                                                 certificates:certificatesForCredential
                                                                  persistence:NSURLCredentialPersistencePermanent];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        CFRelease(identity);
        CFRelease(certificate);
        CFRelease(certsArray);
      } else {
        [challenge.sender cancelAuthenticationChallenge:challenge];
      }
    }
    else if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
      
      if(challenge.previousFailureCount < 5) {
        
        self.serverTrust = challenge.protectionSpace.serverTrust;
        SecTrustResultType result;
        SecTrustEvaluate(self.serverTrust, &result);
        
        if(result == kSecTrustResultProceed ||
           result == kSecTrustResultUnspecified || //The cert is valid, but user has not explicitly accepted/denied. Ok to proceed (Ch 15: iOS PTL :Pg 269)
           result == kSecTrustResultRecoverableTrustFailure //The cert is invalid, but is invalid because of name mismatch. Ok to proceed (Ch 15: iOS PTL :Pg 269)
           ) {
          
          [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
        else if(result == kSecTrustResultConfirm) {
          
          if(self.shouldContinueWithInvalidCertificate) {
            
            // Cert not trusted, but user is OK with that
            DLog(@"Certificate is not trusted, but self.shouldContinueWithInvalidCertificate is YES");
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
          } else {
            
            DLog(@"Certificate is not trusted, continuing without credentials. Might result in 401 Unauthorized");
            [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
          }
        }
        else {
          
          // invalid or revoked certificate
          if(self.shouldContinueWithInvalidCertificate) {
            DLog(@"Certificate is invalid, but self.shouldContinueWithInvalidCertificate is YES");
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
          } else {
            DLog(@"Certificate is invalid, continuing without credentials. Might result in 401 Unauthorized");
            [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
          }
        }
      } else {
        
        [challenge.sender cancelAuthenticationChallenge:challenge];
      }
    }
    else if (self.authHandler) {
      
      // forward the authentication to the view controller that created this operation
      // If this happens for NSURLAuthenticationMethodHTMLForm, you have to
      // do some shit work like showing a modal webview controller and close it after authentication.
      // I HATE THIS.
      self.authHandler(challenge);
    }
    else {
      [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
  } else {
    //  apple proposes to cancel authentication, which results in NSURLErrorDomain error -1012, but we prefer to trigger a 401
    //        [[challenge sender] cancelAuthenticationChallenge:challenge];
    [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  
  NSUInteger size = [self.response expectedContentLength] < 0 ? 0 : (NSUInteger)[self.response expectedContentLength];
  self.response = (NSHTTPURLResponse*) response;
  
  // dont' save data if the operation was created to download directly to a stream.
  if([self.downloadStreams count] == 0)
    self.mutableData = [NSMutableData dataWithCapacity:size];
  else
    self.mutableData = nil;
  
  for(NSOutputStream *stream in self.downloadStreams)
    [stream open];
  
  NSDictionary *httpHeaders = [self.response allHeaderFields];
  
  // if you attach a stream to the operation, MKNetworkKit will not cache the response.
  // Streams are usually "big data chunks" that doesn't need caching anyways.
  
  if([self.request.HTTPMethod isEqualToString:@"GET"] && [self.downloadStreams count] == 0) {
    
    // We have all this complicated cache handling since NSURLRequestReloadRevalidatingCacheData is not implemented
    // do cache processing only if the request is a "GET" method
    NSString *lastModified = httpHeaders[@"Last-Modified"];
    NSString *eTag = httpHeaders[@"ETag"];
    NSString *expiresOn = httpHeaders[@"Expires"];
    
    NSString *contentType = httpHeaders[@"Content-Type"];
    // if contentType is image,
    
    NSDate *expiresOnDate = nil;
    
    if([contentType rangeOfString:@"image"].location != NSNotFound) {
      
      // For images let's assume a expiry date of 7 days if there is no eTag or Last Modified.
      if(!eTag && !lastModified)
        expiresOnDate = [[NSDate date] dateByAddingTimeInterval:kMKNetworkKitDefaultImageCacheDuration];
      else
        expiresOnDate = [[NSDate date] dateByAddingTimeInterval:kMKNetworkKitDefaultImageHeadRequestDuration];
    }
    
    NSString *cacheControl = httpHeaders[@"Cache-Control"]; // max-age, must-revalidate, no-cache
    NSArray *cacheControlEntities = [cacheControl componentsSeparatedByString:@","];
    
    for(NSString *substring in cacheControlEntities) {
      
      if([substring rangeOfString:@"max-age"].location != NSNotFound) {
        
        // do some processing to calculate expiresOn
        NSString *maxAge = nil;
        NSArray *array = [substring componentsSeparatedByString:@"="];
        if([array count] > 1)
          maxAge = array[1];
        
        expiresOnDate = [[NSDate date] dateByAddingTimeInterval:[maxAge intValue]];
      }
      if([substring rangeOfString:@"no-cache"].location != NSNotFound) {
        
        // Don't cache this request
        expiresOnDate = [[NSDate date] dateByAddingTimeInterval:kMKNetworkKitDefaultCacheDuration];
      }
    }
    
    // if there was a cacheControl entity, we would have a expiresOnDate that is not nil.
    // "Cache-Control" headers take precedence over "Expires" headers
    
    if(expiresOnDate)
      expiresOn = [expiresOnDate rfc1123String];
    
    // now remember lastModified, eTag and expires for this request in cache
    if(expiresOn)
      (self.cacheHeaders)[@"Expires"] = expiresOn;
    if(lastModified)
      (self.cacheHeaders)[@"Last-Modified"] = lastModified;
    if(eTag)
      (self.cacheHeaders)[@"ETag"] = eTag;
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  if (self.downloadedDataSize == 0) {
    // This is the first batch of data
    // Check for a range header and make changes as neccesary
    NSString *rangeString = [[self request] valueForHTTPHeaderField:@"Range"];
    if ([rangeString hasPrefix:@"bytes="] && [rangeString hasSuffix:@"-"]) {
      NSString *bytesText = [rangeString substringWithRange:NSMakeRange(6, [rangeString length] - 7)];
      self.startPosition = [bytesText integerValue];
      self.downloadedDataSize = self.startPosition;
      DLog(@"Resuming at %lu bytes", (unsigned long) self.startPosition);
    }
  }
  
  if([self.downloadStreams count] == 0)
    [self.mutableData appendData:data];
  
  for(NSOutputStream *stream in self.downloadStreams) {
    
    if ([stream hasSpaceAvailable]) {
      const uint8_t *dataBuffer = [data bytes];
      [stream write:&dataBuffer[0] maxLength:[data length]];
    }
  }
  
  self.downloadedDataSize += [data length];
  
  for(MKNKProgressBlock downloadProgressBlock in self.downloadProgressChangedHandlers) {
    
    if([self.response expectedContentLength] > 0) {
      
      double progress = (double)(self.downloadedDataSize) / (double)(self.startPosition + [self.response expectedContentLength]);
      downloadProgressBlock(progress);
    }
  }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
  
  for(MKNKProgressBlock uploadProgressBlock in self.uploadProgressChangedHandlers) {
    
    if(totalBytesExpectedToWrite > 0) {
      uploadProgressBlock(((double)totalBytesWritten/(double)totalBytesExpectedToWrite));
    }
  }
}

// http://stackoverflow.com/questions/1446509/handling-redirects-correctly-with-nsurlconnection
- (NSURLRequest *)connection: (NSURLConnection *)inConnection
             willSendRequest: (NSURLRequest *)inRequest
            redirectResponse: (NSURLResponse *)inRedirectResponse;
{
  if (inRedirectResponse) {
    NSMutableURLRequest *r = [self.request mutableCopy];
    [r setURL: [inRequest URL]];
    
    return r;
  } else {
    return inRequest;
  }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  if([self isCancelled])
    return;
  
  self.state = MKNetworkOperationStateFinished;
  
  for(NSOutputStream *stream in self.downloadStreams)
    [stream close];
  
  if (self.response.statusCode >= 200 && self.response.statusCode < 300 && ![self isCancelled]) {
    
    self.cachedResponse = nil; // remove cached data
    [self notifyCache];
    [self operationSucceeded];
    
  }
  if (self.response.statusCode >= 300 && self.response.statusCode < 400) {
    
    if(self.response.statusCode == 301) {
      DLog(@"%@ has moved to %@", self.url, [self.response.URL absoluteString]);
    }
    else if(self.response.statusCode == 304) {
      
      for(MKNKVoidBlock notModifiedBlock in self.notModifiedHandlers) {
        
        notModifiedBlock();
      }
    }
    else if(self.response.statusCode == 307) {
      DLog(@"%@ temporarily redirected", self.url);
    }
    else {
      DLog(@"%@ returned status %d", self.url, (int) self.response.statusCode);
    }
    
  } else if (self.response.statusCode >= 400 && self.response.statusCode < 600 && ![self isCancelled]) {
    
    [self operationFailedWithError:[NSError errorWithDomain:NSURLErrorDomain
                                                       code:self.response.statusCode
                                                   userInfo:self.response.allHeaderFields]];
  }
  [self endBackgroundTask];
  
}

#pragma mark -
#pragma mark Our methods to get data

-(NSData*) responseData {
  
  if([self isFinished])
    return self.mutableData;
  else if(self.cachedResponse)
    return self.cachedResponse;
  else
    return nil;
}

-(NSString*)responseString {
  
  return [self responseStringWithEncoding:self.stringEncoding];
}

-(NSString*) responseStringWithEncoding:(NSStringEncoding) encoding {
  
  return [[NSString alloc] initWithData:[self responseData] encoding:encoding];
}

#if TARGET_OS_IPHONE
-(UIImage*) responseImage {
  
  return [UIImage imageWithData:[self responseData]];
}

-(void) decompressedResponseImageOfSize:(CGSize) size completionHandler:(void (^)(UIImage *decompressedImage)) imageDecompressionHandler {
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    __block CGSize targetSize = size;
    UIImage *image = [self responseImage];
    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    BOOL sameSize = NO;
    if (CGSizeEqualToSize(targetSize, CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef)))) {
      targetSize = CGSizeMake(1, 1);
      sameSize = YES;
    }
    
    size_t imageWidth = (size_t)targetSize.width;
    size_t imageHeight = (size_t)targetSize.height;
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 // Just always return width * 4 will be enough
                                                 imageWidth * 4,
                                                 // System only supports RGB, set explicitly
                                                 colorSpace,
                                                 // Makes system don't need to do extra conversion when displayed.
                                                 alphaInfo | kCGBitmapByteOrder32Little);
    CGColorSpaceRelease(colorSpace);
    if (!context) {
      return;
    }
    
    
    CGRect rect = (CGRect){CGPointZero, {imageWidth, imageHeight}};
    CGContextDrawImage(context, rect, imageRef);
    if (sameSize) {
      CGContextRelease(context);
      dispatch_async(dispatch_get_main_queue(), ^{
        imageDecompressionHandler(image);
      });
      return;
    }
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    static float scale = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      scale = [UIScreen mainScreen].scale;
    });
    
    UIImage *decompressedImage = [[UIImage alloc] initWithCGImage:decompressedImageRef scale:scale orientation:image.imageOrientation];
    CGImageRelease(decompressedImageRef);
    dispatch_async(dispatch_get_main_queue(), ^{
      imageDecompressionHandler(decompressedImage);
    });
  });
}

#elif TARGET_OS_MAC
-(NSImage*) responseImage {
  
  return [[NSImage alloc] initWithData:[self responseData]];
}

-(NSXMLDocument*) responseXML {
  
  return [[NSXMLDocument alloc] initWithData:[self responseData] options:0 error:nil];
}
#endif

-(id) responseJSON {
  
  if([self responseData] == nil) return nil;
  NSError *error = nil;
  id returnValue = [NSJSONSerialization JSONObjectWithData:[self responseData] options:0 error:&error];
  if(error) DLog(@"JSON Parsing Error: %@", error);
  return returnValue;
}

-(void) responseJSONWithCompletionHandler:(void (^)(id jsonObject)) jsonDecompressionHandler {
  
  if([self responseData] == nil) {
    
    jsonDecompressionHandler(nil);
    return;
  }
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:[self responseData] options:0 error:&error];
    if(error) {
      
      DLog(@"JSON Parsing Error: %@", error);
      jsonDecompressionHandler(nil);
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      jsonDecompressionHandler(returnValue);
    });
  });
}
#pragma mark -
#pragma mark Overridable methods

-(void) operationSucceeded {
  
  for(MKNKResponseBlock responseBlock in self.responseBlocks)
    responseBlock(self);
}

-(void) showLocalNotification {
#if TARGET_OS_IPHONE
  
  if(self.localNotification) {
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:self.localNotification];
  } else if(self.shouldShowLocalNotificationOnError) {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.alertBody = [self.error localizedDescription];
    localNotification.alertAction = NSLocalizedString(@"Dismiss", @"");
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
  }
#endif
}

-(void) operationFailedWithError:(NSError*) error {
  
  self.error = error;
  DLog(@"%@, [%@]", self, [self.error localizedDescription]);
  for(MKNKErrorBlock errorBlock in self.errorBlocks)
    errorBlock(error);
  
  for(MKNKResponseErrorBlock errorBlock in self.errorBlocksType2)
    errorBlock(self, error);
  
#if TARGET_OS_IPHONE
  DLog(@"State: %d", [[UIApplication sharedApplication] applicationState]);
  if([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)
    [self showLocalNotification];
#endif
  
}

@end
