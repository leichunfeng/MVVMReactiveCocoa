//
//  LCFInfiniteScrollView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/9.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFInfiniteScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LCFCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation LCFCollectionViewFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5;
    
    NSArray *layoutAttributesForElements = [self layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    UICollectionViewLayoutAttributes *layoutAttributes = layoutAttributesForElements.firstObject;
    
    for (UICollectionViewLayoutAttributes *layoutAttributesForElement in layoutAttributesForElements) {
        if (layoutAttributesForElement.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        
        CGFloat distance1 = layoutAttributesForElement.center.x - proposedContentOffsetCenterX;
        CGFloat distance2 = layoutAttributes.center.x - proposedContentOffsetCenterX;
        
        if (fabs(distance1) < fabs(distance2)) {
            layoutAttributes = layoutAttributesForElement;
        }
    }
    
    if (layoutAttributes != nil) {
        return CGPointMake(layoutAttributes.center.x - CGRectGetWidth(self.collectionView.bounds) * 0.5, proposedContentOffset.y);
    }
    
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}

@end

@interface LCFCollectionViewCell : UICollectionViewCell

@end

@interface LCFCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation LCFInfiniteScrollViewItem

@end

@implementation LCFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imageView": self.imageView }]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imageView": self.imageView }]];
    
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"label": self.label }]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0]];
}

@end

@interface LCFInfiniteScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LCFCollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LCFInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.collectionViewLayout = [[LCFCollectionViewFlowLayout alloc] init];
    
    self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    [self addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    [self.collectionView registerClass:[LCFCollectionViewCell class] forCellWithReuseIdentifier:@"LCFCollectionViewCell"];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{ @"collectionView": self.collectionView }]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{ @"collectionView": self.collectionView }]];

    [self setUpTimer];
}

- (void)setUpTimer {
    self.timer = [NSTimer timerWithTimeInterval:3
                                         target:self
                                       selector:@selector(timerFire:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)tearDownTimer {
    [self.timer invalidate];
}

- (void)timerFire:(NSTimer *)timer {
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat targetOffset  = currentOffset + self.itemSize.width + self.itemSpacing;
    [self.collectionView setContentOffset:CGPointMake(targetOffset, self.collectionView.contentOffset.y) animated:YES];
}

- (void)setItems:(NSArray<LCFInfiniteScrollViewItem *> *)items {
    if (items.count == 0) return;
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 3; i++) {
        [mutableItems addObjectsFromArray:items];
    }
    
    _items = mutableItems.copy;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:items.count inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:NO];
        });
    });
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    self.collectionViewLayout.itemSize = itemSize;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    self.collectionViewLayout.minimumLineSpacing = itemSpacing;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCFCollectionViewCell" forIndexPath:indexPath];
    
    LCFInfiniteScrollViewItem *item = self.items[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]
                      placeholderImage:[HexRGB(colorI6) color2ImageSized:cell.frame.size]];
    cell.label.text = item.text;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.itemSize.width + self.itemSpacing;
    CGFloat periodOffset = pageWidth * (self.items.count / 3);
    CGFloat offsetActivatingMoveToBeginning = pageWidth * ((self.items.count / 3) * 2);
    CGFloat offsetActivatingMoveToEnd = pageWidth * ((self.items.count / 3) * 1);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX > offsetActivatingMoveToBeginning) {
        scrollView.contentOffset = CGPointMake((offsetX - periodOffset), 0);
    } else if (offsetX < offsetActivatingMoveToEnd) {
        scrollView.contentOffset = CGPointMake((offsetX + periodOffset), 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self tearDownTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

@end
