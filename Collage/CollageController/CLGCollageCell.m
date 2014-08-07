//
//  CLGCollageCell.m
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCollageCell.h"
#import "UIImageView+WebCache.h"

@implementation CLGCollageCell

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

@end
