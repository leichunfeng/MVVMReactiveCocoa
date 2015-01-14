//
//  MRCViewModelServices.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCNavigationProtocol.h"

@protocol MRCViewModelServices <NSObject, MRCNavigationProtocol>

@required

// A reference to OCTClient instance.
@property (strong, nonatomic) OCTClient *client;

@end
