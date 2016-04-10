//
//  MRCExploreTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreTableViewCell.h"
#import "MRCExploreItemViewModel.h"
#import "MRCExploreCollectionViewCell.h"

@interface MRCExploreTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *seeAllButton;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) MRCExploreItemViewModel *viewModel;

@end

@implementation MRCExploreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MRCExploreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MRCExploreCollectionViewCell"];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
    
    [title appendAttributedString:[[NSAttributedString alloc] initWithString:@"See all "
                                                                  attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:13],
                                                                                NSForegroundColorAttributeName: HexRGB(0x4A4A4A) }]];
    
    [title appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString octicon_iconStringForEnum:OCTIconChevronRight]
                                                                  attributes:@{ NSFontAttributeName: [UIFont fontWithName:kOcticonsFamilyName size:13],
                                                                                NSForegroundColorAttributeName: [UIColor lightGrayColor] }]];
    
    [self.seeAllButton setAttributedTitle:title.copy forState:UIControlStateNormal];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindViewModel:(MRCExploreItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.titleLabel.text = viewModel.title;
    self.seeAllButton.rac_command = viewModel.seeAllCommand;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section >= self.viewModel.dataSource.count) return 0;
    return self.viewModel.dataSource[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MRCExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MRCExploreCollectionViewCell" forIndexPath:indexPath];
    [cell bindViewModel:self.viewModel.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MRCExploreCollectionViewCellViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [viewModel.didSelectCommand execute:viewModel];
}

@end
