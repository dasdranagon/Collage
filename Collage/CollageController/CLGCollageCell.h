//
//  CLGCollageCell.h
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGImage;

@interface CLGCollageCell : UICollectionViewCell
- (void)configureWithCLGImage:(IGImage *)image;
@end
