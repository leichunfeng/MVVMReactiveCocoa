//
//  LCFCollectionViewFlowLayout.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFCollectionViewFlowLayout.h"

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
