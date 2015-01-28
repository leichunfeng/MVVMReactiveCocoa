//
//  NSDictionary+RequestEncoding.m
//  MKNetworkKitDemo
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

@implementation NSDictionary (RequestEncoding)

-(NSString*) urlEncodedKeyValueString {
  
  NSMutableString *string = [NSMutableString string];
  for (NSString *key in self) {
    
    NSObject *value = [self valueForKey:key];
    if([value isKindOfClass:[NSString class]])
      [string appendFormat:@"%@=%@&", [key urlEncodedString], [((NSString*)value) urlEncodedString]];
    else
      [string appendFormat:@"%@=%@&", [key urlEncodedString], value];
  }
  
  if([string length] > 0)
    [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
  
  return string;
}


-(NSString*) jsonEncodedKeyValueString {
  
  NSError *error = nil;
  NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                 options:0 // non-pretty printing
                                                   error:&error];
  if(error)
    DLog(@"JSON Parsing Error: %@", error);
  
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


-(NSString*) plistEncodedKeyValueString {
  
  NSError *error = nil;
  NSData *data = [NSPropertyListSerialization dataWithPropertyList:self
                                                            format:NSPropertyListXMLFormat_v1_0
                                                           options:0 error:&error];
  if(error)
    DLog(@"JSON Parsing Error: %@", error);
  
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
