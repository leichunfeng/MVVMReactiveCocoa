//
//  MKNetworkEngine.h
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
/*!
 @header MKNetworkEngine.h
 @abstract   Represents a subclassable Network Engine for your app
 */

/*!
 *  @class MKNetworkEngine
 *  @abstract Represents a subclassable Network Engine for your app
 *  
 *  @discussion
 *	This class is the heart of MKNetworkEngine
 *  You create network operations and enqueue them here
 *  MKNetworkEngine encapsulates a Reachability object that relieves you of managing network connectivity losses
 *  MKNetworkEngine also allows you to provide custom header fields that gets appended automatically to every request
 */
@interface MKNetworkEngine : NSObject

/*!
 *  @abstract Initializes your network engine with a hostname
 *  
 *  @discussion
 *	Creates an engine for a given host name
 *  The hostname parameter is optional
 *  The hostname, if not null, initializes a Reachability notifier.
 *  Network reachability notifications are automatically taken care of by MKNetworkEngine
 *  
 */
- (id) initWithHostName:(NSString*) hostName;

/*!
 *  @abstract Initializes your network engine with a hostname and custom header fields
 *  
 *  @discussion
 *	Creates an engine for a given host name
 *  The default headers you specify here will be appened to every operation created in this engine
 *  The hostname, if not null, initializes a Reachability notifier.
 *  Network reachability notifications are automatically taken care of by MKNetworkEngine
 *  Both parameters are optional
 *  
 */
- (id) initWithHostName:(NSString*) hostName customHeaderFields:(NSDictionary*) headers;

/*!
 *  @abstract Initializes your network engine with a hostname
 *  
 *  @discussion
 *	Creates an engine for a given host name
 *  The hostname parameter is optional
 *  The apiPath paramter is optional
 *  The apiPath is prefixed to every call to operationWithPath: You can use this method if your server's API location is not at the root (/)
 *  The hostname, if not null, initializes a Reachability notifier.
 *  Network reachability notifications are automatically taken care of by MKNetworkEngine
 *  
 */
- (id) initWithHostName:(NSString*) hostName apiPath:(NSString*) apiPath customHeaderFields:(NSDictionary*) headers;

/*!
 *  @abstract Creates a simple GET Operation with a request URL
 *  
 *  @discussion
 *	Creates an operation with the given URL path.
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The HTTP Method is implicitly assumed to be GET
 *  
 */

-(MKNetworkOperation*) operationWithPath:(NSString*) path;

/*!
 *  @abstract Creates a simple GET Operation with a request URL and parameters
 *  
 *  @discussion
 *	Creates an operation with the given URL path.
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The body dictionary in this method gets attached to the URL as query parameters
 *  The HTTP Method is implicitly assumed to be GET
 *  
 */
-(MKNetworkOperation*) operationWithPath:(NSString*) path
                         params:(NSDictionary*) body;

/*!
 *  @abstract Creates a simple GET Operation with a request URL, parameters and HTTP Method
 *  
 *  @discussion
 *	Creates an operation with the given URL path.
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The params dictionary in this method gets attached to the URL as query parameters if the HTTP Method is GET/DELETE
 *  The params dictionary is attached to the body if the HTTP Method is POST/PUT
 *  The HTTP Method is implicitly assumed to be GET
 */
-(MKNetworkOperation*) operationWithPath:(NSString*) path
                         params:(NSDictionary*) body
                   httpMethod:(NSString*)method;

/*!
 *  @abstract Creates a simple GET Operation with a request URL, parameters, HTTP Method and the SSL switch
 *  
 *  @discussion
 *	Creates an operation with the given URL path.
 *  The ssl option when true changes the URL to https.
 *  The ssl option when false changes the URL to http.
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The params dictionary in this method gets attached to the URL as query parameters if the HTTP Method is GET/DELETE
 *  The params dictionary is attached to the body if the HTTP Method is POST/PUT
 *  The previously mentioned methods operationWithPath: and operationWithPath:params: call this internally
 */
-(MKNetworkOperation*) operationWithPath:(NSString*) path
                         params:(NSDictionary*) body
                   httpMethod:(NSString*)method 
                          ssl:(BOOL) useSSL;

/*!
 *  @abstract Creates a simple GET Operation with a request URL
 *  
 *  @discussion
 *	Creates an operation with the given absolute URL.
 *  The hostname of the engine is *NOT* prefixed
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The HTTP method is implicitly assumed to be GET.
 */
-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString;

/*!
 *  @abstract Creates a simple GET Operation with a request URL and parameters
 *  
 *  @discussion
 *	Creates an operation with the given absolute URL.
 *  The hostname of the engine is *NOT* prefixed
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The body dictionary in this method gets attached to the URL as query parameters
 *  The HTTP method is implicitly assumed to be GET.
 */
-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                                       params:(NSDictionary*) body;

/*!
 *  @abstract Creates a simple Operation with a request URL, parameters and HTTP Method
 *  
 *  @discussion
 *	Creates an operation with the given absolute URL.
 *  The hostname of the engine is *NOT* prefixed
 *  The default headers you specified in your MKNetworkEngine subclass gets added to the headers
 *  The params dictionary in this method gets attached to the URL as query parameters if the HTTP Method is GET/DELETE
 *  The params dictionary is attached to the body if the HTTP Method is POST/PUT
 *	This method can be over-ridden by subclasses to tweak the operation creation mechanism.
 *  You would typically over-ride this method to create a subclass of MKNetworkOperation (if you have one). After you create it, you should call [super prepareHeaders:operation] to attach any custom headers from super class.
 *  @seealso
 *  prepareHeaders:
 */
-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                              params:(NSDictionary*) body
                        httpMethod:(NSString*) method;

/*!
 *  @abstract adds the custom default headers
 *  
 *  @discussion
 *	This method adds custom default headers to the factory created MKNetworkOperation.
 *	This method can be over-ridden by subclasses to add more default headers if necessary.
 *  You would typically over-ride this method if you have over-ridden operationWithURLString:params:httpMethod:.
 *  @seealso
 *  operationWithURLString:params:httpMethod:
 */
-(void) prepareHeaders:(MKNetworkOperation*) operation;

#if TARGET_OS_IPHONE
/*!
 *  @abstract Handy helper method for fetching images asynchronously in the background
 *
 *  @discussion
 *	Creates an operation with the given image URL.
 *  The hostname of the engine is *NOT* prefixed.
 *  The image is returned to the caller via MKNKImageBlock callback block. This image is resized as per the size and decompressed in background.
 *  @seealso
 *  imageAtUrl:onCompletion:
 */
- (MKNetworkOperation*)imageAtURL:(NSURL *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock DEPRECATED_ATTRIBUTE;

/*!
 *  @abstract Handy helper method for fetching images
 *
 *  @discussion
 *	Creates an operation with the given image URL.
 *  The hostname of the engine is *NOT* prefixed.
 *  The image is returned to the caller via MKNKImageBlock callback block.
 */
- (MKNetworkOperation*)imageAtURL:(NSURL *)url onCompletion:(MKNKImageBlock) imageFetchedBlock DEPRECATED_ATTRIBUTE;

/*!
 *  @abstract Handy helper method for fetching images in the background
 *
 *  @discussion
 *	Creates an operation with the given image URL.
 *  The hostname of the engine is *NOT* prefixed.
 *  The image is returned to the caller via MKNKImageBlock callback block. This image is resized as per the size and decompressed in background.
 *  @seealso
 *  imageAtUrl:onCompletion:
 */
- (MKNetworkOperation*)imageAtURL:(NSURL *)url completionHandler:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock;

/*!
 *  @abstract Handy helper method for fetching images asynchronously in the background
 *
 *  @discussion
 *	Creates an operation with the given image URL.
 *  The hostname of the engine is *NOT* prefixed.
 *  The image is returned to the caller via MKNKImageBlock callback block. This image is resized as per the size and decompressed in background.
 *  @seealso
 *  imageAtUrl:onCompletion:
 */
- (MKNetworkOperation*)imageAtURL:(NSURL *)url size:(CGSize) size completionHandler:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock;
#endif

/*!
 *  @abstract Enqueues your operation into the shared queue
 *  
 *  @discussion
 *	The operation you created is enqueued to the shared queue. If the response for this operation was previously cached, the cached data will be returned.
 *  @seealso
 *  enqueueOperation:forceReload:
 */
-(void) enqueueOperation:(MKNetworkOperation*) request;

/*!
 *  @abstract Enqueues your operation into the shared queue.
 *  
 *  @discussion
 *	The operation you created is enqueued to the shared queue. 
 *  When forceReload is NO, this method behaves like enqueueOperation:
 *  When forceReload is YES, No cached data will be returned even if cached data is available.
 *  @seealso
 *  enqueueOperation:
 */
-(void) enqueueOperation:(MKNetworkOperation*) operation forceReload:(BOOL) forceReload;

/*!
 *  @abstract HostName of the engine
 *  @property readonlyHostName
 *  
 *  @discussion
 *	Returns the host name of the engine
 *  This property is readonly cannot be updated. 
 *  You normally initialize an engine with its hostname using the initWithHostName:customHeaders: method
 */
@property (readonly, copy, nonatomic) NSString *readonlyHostName;

/*!
 *  @abstract Port Number that should be used by URL creating factory methods
 *  @property portNumber
 *  
 *  @discussion
 *	Set a port number for your engine if your remote URL mandates it.
 *  This property is optional and you DON'T have to specify the default HTTP port 80
 */
@property (assign, nonatomic) int portNumber;

/*!
 *  @abstract WiFi only mode
 *  @property wifiOnlyMode
 *
 *  @discussion
 *	When you set this property to YES, MKNetworkEngine will not run operations on mobile data network.
 */
@property (assign, nonatomic) BOOL wifiOnlyMode;

/*!
 *  @abstract Sets an api path if it is different from root URL
 *  @property apiPath
 *  
 *  @discussion
 *	You can use this method to set a custom path to the API location if your server's API path is different from root (/) 
 *  This property is optional
 */
@property (copy, nonatomic) NSString* apiPath;

/*!
 *  @abstract Handler that you implement to monitor reachability changes
 *  @property reachabilityChangedHandler
 *  
 *  @discussion
 *	The framework calls this handler whenever the reachability of the host changes.
 *  The default implementation freezes the queued operations and stops network activity
 *  You normally don't have to implement this unless you need to show a HUD notifying the user of connectivity loss
 */
@property (copy, nonatomic) void (^reachabilityChangedHandler)(NetworkStatus ns);

/*!
 *  @abstract Registers an associated operation subclass
 *  
 *  @discussion
 *	When you override both MKNetworkEngine and MKNetworkOperation, you might want the engine's factory method
 *  to prepare operations of your MKNetworkOperation subclass. To create your own MKNetworkOperation subclasses from the factory method, you can register your MKNetworkOperation subclass using this method.
 *  This method is optional. If you don't use, factory methods in MKNetworkEngine creates MKNetworkOperation objects.
 */
-(void) registerOperationSubclass:(Class) aClass;

/*!
 *  @abstract Cache Directory Name
 *  
 *  @discussion
 *	This method can be over-ridden by subclasses to provide an alternative cache directory
 *  The default directory (MKNetworkKitCache) within the NSCaches directory will be used otherwise
 *  Overriding this method is optional
 */
-(NSString*) cacheDirectoryName;

/*!
 *  @abstract Cache Directory In Memory Cost
 *  
 *  @discussion
 *	This method can be over-ridden by subclasses to provide an alternative in memory cache size.
 *  By default, MKNetworkKit caches 10 recent requests in memory
 *  The default size is 10
 *  Overriding this method is optional
 */
-(int) cacheMemoryCost;

/*!
 *  @abstract Enable Caching
 *  
 *  @discussion
 *	This method should be called explicitly to enable caching for this engine.
 *  By default, MKNetworkKit doens't cache your requests.
 *  The cacheMemoryCost and cacheDirectoryName will be used when you turn caching on using this method.
 */
-(void) useCache;

/*!
 *  @abstract Empties previously cached data
 *  
 *  @discussion
 *	This method is a handy helper that you can use to clear cached data.
 *  By default, MKNetworkKit doens't cache your requests. Use this only when you enabled caching
 *  @seealso
 *  useCache
 */
-(void) emptyCache;

/*!
 *  @abstract Checks current reachable status
 *  
 *  @discussion
 *	This method is a handy helper that you can use to check for network reachability.
 */
-(BOOL) isReachable;

@end
