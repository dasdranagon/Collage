//
//  CLGImageCell.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImageCell.h"
#import "UIImageView+WebCache.h"

@implementation CLGImageCell

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setChecked:(BOOL)checked
{
    [self.checkImage setHidden:!checked];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self.image setAlpha:highlighted ? 0.7 : 1.0];
}

@end
