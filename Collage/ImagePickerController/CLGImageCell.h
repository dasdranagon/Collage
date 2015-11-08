//
//  CLGImageCell.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGImage;

@interface CLGImageCell : UICollectionViewCell
- (void)configWithImage:(IGImage *)image;
- (void)setChecked:(BOOL)checked;
@end
