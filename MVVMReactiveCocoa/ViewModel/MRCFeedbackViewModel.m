//
//  MRCFeedbackViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCFeedbackViewModel.h"

@interface MRCFeedbackViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *submitFeedbackCommand;

@end

@implementation MRCFeedbackViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Feedback";
    
    RACSignal *validSubmitSignal = [[[RACObserve(self, content)
        map:^(NSString *content) {
        	return [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }]
        map:^(NSString *content) {
            return @(content.length > 0);
        }]
        distinctUntilChanged];
    
    OCTRepository *mvvmReactiveCocoa = [OCTRepository modelWithDictionary:@{ @"ownerLogin": MVVM_REACTIVECOCOA_OWNER_LOGIN,
                                                                             @"name": MVVM_REACTIVECOCOA_NAME }
                                                                    error:NULL];
    
    @weakify(self)
    self.submitFeedbackCommand = [[RACCommand alloc] initWithEnabled:validSubmitSignal signalBlock:^(id input) {
        @strongify(self)
        return [[[[self.services
            client]
        	createIssueWithTitle:[NSString stringWithFormat:@"%@ from %@", self.title, [OCTUser mrc_currentUser].login] body:self.content assignee:nil milestone:0 labels:nil inRepository:mvvmReactiveCocoa]
            deliverOnMainThread]
            doNext:^(id x) {
                @strongify(self)
                [self.services popViewModelAnimated:YES];
            }];
    }];
    
    [self.submitFeedbackCommand.errors subscribe:self.errors];
}

@end
