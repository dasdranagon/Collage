//
//  CLGImageCell.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImageCell.h"
#import "IGImage.h"
#import "UIImageView+WebCache.h"

@interface CLGImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation CLGImageCell

- (void)configWithImage:(IGImage *)image
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:image.url]];
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
