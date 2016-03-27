//
//  MRCExploreItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCExploreCollectionViewCellViewModel.h"

@interface MRCExploreItemViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSArray<MRCExploreCollectionViewCellViewModel *> *> *dataSource;
@property (nonatomic, strong) RACCommand *seeAllCommand;

@end
