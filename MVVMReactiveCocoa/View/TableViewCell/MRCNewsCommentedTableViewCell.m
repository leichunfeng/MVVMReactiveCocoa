//
//  MRCNewsCommentedTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/12.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsCommentedTableViewCell.h"

@interface MRCNewsCommentedTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *commentedLabel;

@end

@implementation MRCNewsCommentedTableViewCell

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    [super bindViewModel:viewModel];

    OCTCommitCommentEvent *commitCommentEvent = (OCTCommitCommentEvent *)viewModel.event;
    self.commentedLabel.text = commitCommentEvent.comment.body;
}

+ (CGFloat)heightWithViewModel:(MRCNewsItemViewModel *)viewModel {
    DTAttributedLabel *attributedLabel = [self sharedAttributedLabel];
   
    attributedLabel.attributedString = viewModel.contentAttributedString;
    CGFloat height = 10 + ceilf([attributedLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height) + 2 + 15 + 10;
    
    OCTCommitCommentEvent *commitCommentEvent = (OCTCommitCommentEvent *)viewModel.event;
    
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15.0] };
    
    CGFloat width = SCREEN_WIDTH - 10 * 2 - 40 - 10;
    CGRect rect = [commitCommentEvent.comment.body boundingRectWithSize:CGSizeMake(width, 0)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:attributes
                                                                context:nil];
    CGFloat height1 = MIN(ceil(rect.size.height), 18 * 3);
    
    return MAX(height + height1, 10 + 40 + 10);
}

@end
