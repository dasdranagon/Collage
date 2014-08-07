//
//  CLGCollageCell.h
//  Collage
//
//  Created by Denis Skokov on 07.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGCollageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (void)setImageUrl:(NSString *)imageUrl;
@end
