//
//  CLGCollageViewModel.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCollageViewModel.h"

@implementation CLGCollageViewModel

- (instancetype)initWidthImages:(NSArray *)images
{
    self = [super init];
    
    if (self) {
        self.images = images;
    }
    
    return self;
}

@end
