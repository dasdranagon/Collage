//
//  CLGCollageCell.m
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCollageCell.h"
#import "IGImage.h"
#import "UIImageView+WebCache.h"

@interface CLGCollageCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation CLGCollageCell

- (void)configureWithCLGImage:(IGImage *)image
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:image.url]];
}

@end
