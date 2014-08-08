//
//  CLGCircleLayout.m
//  Collage
//
//  Created by Denis Skokov on 08.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCircleLayout.h"
#import "math.h"

static CGFloat const kPhotoSide = 120;
static CGFloat const kCenterInset = 90;

@implementation CLGCircleLayout

- (CGSize)sizeForItemAtIndex:(NSInteger)idx
{
    return CGSizeMake(kPhotoSide, kPhotoSide);
}

- (CGPoint)centerForItemAtIndex:(NSInteger)idx
{
    CGFloat x = self.width/2;
    CGFloat y = (self.height - kPhotoSide)/2;
    
    CGFloat angle = [self angleForIndex:idx];
    
    x += kCenterInset*cos(angle);
    y += kCenterInset*sin(angle);
    
    return CGPointMake(x, y);
}

- (CATransform3D)transformItemAtIndex:(NSInteger)idx
{
    return CATransform3DMakeRotation([self angleForIndex:idx], 0, 0, 1);
}

- (CGFloat)angleForIndex:(NSInteger)idx
{
    CGFloat delta = 2*M_PI/self.count;
    return  M_PI/4 + idx*delta;
}

@end
