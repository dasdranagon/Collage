//
//  CLGImagePickerLogic.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGLogic.h"

@class CLGRequester;

@interface CLGImagePickerLogic : CLGLogic
@property (nonatomic, strong) CLGRequester *requester;

//  inputs
- (void)toggleIndex:(NSInteger)index;
@property (nonatomic, strong) NSString *userName;

//  outputs
@property (nonatomic, strong) NSArray *images;
@property (nonatomic) BOOL canMakeCollage;
@property (nonatomic, readonly) NSIndexSet *selectedIndexs;
@property (nonatomic, strong, readonly) NSArray *selectedImages;
@end