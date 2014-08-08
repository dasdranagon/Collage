//
//  CLGBaseLayout.m
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGBaseLayout.h"

@implementation CLGBaseLayout

- (void)prepareLayout
{
    self.count = [self.collectionView numberOfItemsInSection:0];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.width = screenBounds.size.width;
    self.height = screenBounds.size.height;
    
    NSMutableArray *newLayoutInfo = [[NSMutableArray alloc] initWithCapacity:_count];
    
    for (NSInteger i = 0; i < _count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGRect frm = [self frameForItemAtIndex:indexPath.row];
        if (CGRectIsEmpty(frm)) {
            frm.size = [self sizeForItemAtIndex:indexPath.row];
            itemAttributes.frame = frm;
            itemAttributes.center = [self centerForItemAtIndex:indexPath.row];
        }
        else {
            itemAttributes.frame = frm;
        }
        
        itemAttributes.transform3D = [self transformItemAtIndex:indexPath.row];
        newLayoutInfo[indexPath.row] = itemAttributes;
        
    }
    
    self.layoutInfo = [newLayoutInfo copy];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(_width, _height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[indexPath.row];
}


- (CGRect)frameForItemAtIndex:(NSInteger)idx
{
    return CGRectNull;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)idx
{
    return CGSizeZero;
}

- (CGPoint)centerForItemAtIndex:(NSInteger)idx
{
    return CGPointZero;
}

- (CATransform3D)transformItemAtIndex:(NSInteger)idx
{
    return CATransform3DIdentity;
}

@end
