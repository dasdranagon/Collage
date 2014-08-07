//
//  CLGImagePickerViewModel.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGViewModel.h"

@class CLGRequester;

@interface CLGImagePickerViewModel : CLGViewModel
- (instancetype)initWidthRequester:(CLGRequester *)requester;

//  inputs
- (void)toggleIndex:(NSInteger)index;
@property (nonatomic, strong) NSString *userName;

//  outputs
@property (nonatomic, strong) NSArray *images;
@property (nonatomic) BOOL canMakeCollage;
- (NSIndexSet *)selectedIndexs;

@end

@interface CLGImagePickerViewModel(unavailiable)
- (id)init __AVAILABILITY_INTERNAL_UNAVAILABLE;
@end