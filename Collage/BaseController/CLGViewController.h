//
//  CLGViewController.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLGViewModel;

@interface CLGViewController : UIViewController
@property (nonatomic, strong) CLGViewModel *viewModel;
- (CLGViewModel *)createViewModel;
@end
