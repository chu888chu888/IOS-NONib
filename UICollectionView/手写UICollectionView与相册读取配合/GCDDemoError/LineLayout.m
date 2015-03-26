//
//  LineLayout.m
//  GCDDemoError
//
//  Created by chuguangming on 15/3/25.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "LineLayout.h"
#define ITEM_SIZE 100.0

@implementation LineLayout
#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3

-(id)init
{
    self=[super init];
    if (self) {
        self.itemSize=CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        self.scrollDirection=UICollectionViewScrollDirectionVertical;
        self.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
        self.minimumInteritemSpacing=10;
    }
    return self;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    CGRect newBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}
@end
