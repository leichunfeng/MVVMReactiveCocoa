//
//  LCFInfiniteScrollView.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFInfiniteScrollView.h"
#import "LCFCollectionViewFlowLayout.h"
#import "LCFCollectionViewCell.h"
#import "UIColor+LCFImageAdditions.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    
    self.itemSize = self.frame.size;
    self.itemSpacing = 0;
    
    _autoscroll = YES;
    _timeInterval = 5;
    
    [self setUpTimer];
}

- (void)setItems:(NSArray *)items {
    if (items.count == 0) return;
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 3; i++) {
        [mutableItems addObjectsFromArray:items];
    }
    
    _items = mutableItems.copy;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (CGPointEqualToPoint(self.collectionView.contentOffset, CGPointZero)) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:items.count inSection:0]
                                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                    animated:NO];
            }
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

- (void)setAutoscroll:(BOOL)autoscroll {
    _autoscroll = autoscroll;
    [self setUpTimer];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self setUpTimer];
}

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        _placeholderImage = [color lcf_imageSized:self.itemSize];
    }
    return _placeholderImage;
}

#pragma mark - Timer

- (void)setUpTimer {
    [self tearDownTimer];

    if (!self.autoscroll) return;
    
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCFCollectionViewCell" forIndexPath:indexPath];
    
    LCFInfiniteScrollViewItem *item = self.items[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL] placeholderImage:self.placeholderImage];
    cell.label.text = item.text;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItemAtIndex) {
        self.didSelectItemAtIndex(indexPath.row % (self.items.count / 3));
    }
}

#pragma mark - UIScrollViewDelegate

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
