//
//  CLGCollageViewModel.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGViewModel.h"

@interface CLGCollageViewModel : CLGViewModel
- (instancetype)initWidthImages:(NSArray *)images;
@property (nonatomic, strong) NSArray *images;
@end

@interface CLGCollageViewModel(unavailiable)
- (id)init __AVAILABILITY_INTERNAL_UNAVAILABLE;
@end