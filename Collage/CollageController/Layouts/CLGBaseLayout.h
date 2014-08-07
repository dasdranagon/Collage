//
//  CLGBaseLayout.h
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGBaseLayout : UICollectionViewLayout
@property (nonatomic, strong) NSArray *layoutInfo;
@property (nonatomic) NSInteger count;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (CGSize)sizeForItemAtIndex:(NSInteger)idx;
- (CGPoint)centerForItemAtIndex:(NSInteger)idx;
- (CGRect)frameForItemAtIndex:(NSInteger)idx;
- (CATransform3D)transformItemAtIndex:(NSInteger)idx;

@end
