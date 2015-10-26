//
//  JPExtension.h
//  JSPatch
//
//  Created by bang on 15/8/27.
//  Copyright (c) 2015年 bang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JPExtension : NSObject
+ (void)main:(JSContext *)context;

+ (void *)formatPointerJSToOC:(JSValue *)val;
+ (id)formatPointerOCToJS:(void *)pointer;
+ (id)formatJSToOC:(JSValue *)val;
+ (id)formatOCToJS:(id)obj;

+ (int)sizeOfStructTypes:(NSString *)structTypes;
+ (void)getStructDataWidthDict:(void *)structData dict:(NSDictionary *)dict structDefine:(NSDictionary *)structDefine;
+ (NSDictionary *)getDictOfStruct:(void *)structData structDefine:(NSDictionary *)structDefine;
@end

