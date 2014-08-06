//
//  CLGSelectUserViewModel.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGViewModel.h"

@class RACCommand;

@interface CLGSelectUserViewModel : CLGViewModel

//  inputs
@property (nonatomic, strong) NSString *name;

//  outputs
@property (nonatomic) BOOL validName;

@end
