//
//  MRCViewProtocol.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRCViewModelProtocol;

@protocol MRCViewProtocol <NSObject>

@required

// Initialization method. This is the preferred way to create a new view.
//
// viewModel - corresponding view model
//
// Returns a new view.
- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel;

// The `viewModel` parameter in `-initWithViewModel:` method.
@property (nonatomic, strong, readonly) id<MRCViewModelProtocol> viewModel;

@optional

// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end
