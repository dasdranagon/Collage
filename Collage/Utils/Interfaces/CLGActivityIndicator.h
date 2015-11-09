//
//  CLGActivityIndicator.h
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLGActivityIndicator <NSObject>
@property (nonatomic) BOOL progressing;
- (void)configWithView:(UIView *)view;
@end
