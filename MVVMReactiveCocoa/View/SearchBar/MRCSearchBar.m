//
//  MRCSearchBar.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/15.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchBar.h"

@interface UIView (MRCAdditions)

@end

@implementation UIView (MRCAdditions)

- (UIView *)mrc_subviewPassingTest:(BOOL (^)(UIView *subview))predicate {
    if (predicate == NULL) {
        return nil;
    }
    
    UIView *result = nil;
    
    for (UIView *subview in self.subviews) {
        if (predicate(subview)) {
            result = subview;
            break;
        }
        
        result = [subview mrc_subviewPassingTest:predicate];
        
        if (result != nil) {
            break;
        }
    }
    
    return result;
}

@end

@implementation MRCSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
        self.searchBarStyle = UISearchBarStyleMinimal;
    }
    return self;
}

- (void)initialize {
    self.tintColor = HexRGB(colorI5);
    self.placeholder = @"Search";
    
    if (IOS11) {
        UITextField *textField = (UITextField *)[self mrc_subviewPassingTest:^(UIView *subview) {
            if ([NSStringFromClass(subview.class) hasSuffix:@"TextField"]) {
                return YES;
            }
            return NO;
        }];
        
        UILabel *label = (UILabel *)[self mrc_subviewPassingTest:^(UIView *subview) {
            if ([NSStringFromClass(subview.class) hasSuffix:@"TextFieldLabel"]) {
                return YES;
            }
            return NO;
        }];
        
        textField.font = [UIFont systemFontOfSize:15];
        label.font = [UIFont systemFontOfSize:15];
    }
}

- (UIImageView *)imageView {
    return (UIImageView *)[self mrc_subviewPassingTest:^(UIView *subview) {
        if ([subview isMemberOfClass:[UIImageView class]] &&
            [NSStringFromClass(subview.superview.class) hasSuffix:@"TextField"]) {
            return YES;
        }
        return NO;
    }];
}

@end
