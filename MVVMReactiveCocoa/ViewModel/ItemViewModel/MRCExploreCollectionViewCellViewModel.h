//
//  MRCExploreCollectionViewCellViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/27.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCExploreCollectionViewCellViewModel : NSObject

@property (nonatomic, strong) OCTObject *object;

@property (nonatomic, copy) NSURL *avatarURL;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) RACCommand *didSelectCommand;

@end
