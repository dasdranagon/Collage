//
//  CLGImageCell.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (nonatomic, strong) IBOutlet UIImageView *image;
- (void)setImageUrl:(NSString *)imageUrl;
- (void)setChecked:(BOOL)checked;
@end
