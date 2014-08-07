//
//  CLGSimpleTileLayout.m
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGSimpleTileLayout.h"
#include <time.h>

static CGFloat const kPhotoSide = 120;
static CGFloat const kHorisontalCenterOffset = 50;

@interface CLGSimpleTileLayout()

@end

@implementation CLGSimpleTileLayout

- (void)prepareLayout
{
    [super prepareLayout];
    srand (time(0));
   
}

- (CGPoint)centerForItemAtIndex:(NSInteger)idx
{
    CGFloat stepY = (self.height - 2*kPhotoSide) / self.count;
    CGFloat centerX = self.width/2;
    
    CGFloat y =  stepY*idx + kPhotoSide;
    CGPoint point = CGPointMake(centerX + (1 - (idx%2)*2)*kHorisontalCenterOffset, y);
    
    return point;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)idx
{
    return CGSizeMake(kPhotoSide, kPhotoSide);
}

- (CATransform3D)transformItemAtIndex:(NSInteger)idx
{
    int maxRand = 100;
    CGFloat angle = (0.5 - rand()%maxRand/(float)maxRand) * M_PI;
    CATransform3D transform = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
    return transform;
}

@end
