//
//  NSDate+RFC1123.h
//  MKNetworkKit
//
//  Created by Marcus Rohrmoser
//  http://blog.mro.name/2009/08/nsdateformatter-http-header/
//  http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1

//  No obvious license attached

@interface NSDate (RFC1123)
/**
 Convert a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 into NSDate.
 */
+(NSDate*)dateFromRFC1123:(NSString*)value_;

/**
 Convert NSDate into a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1).
 */
-(NSString*)rfc1123String;

@end
