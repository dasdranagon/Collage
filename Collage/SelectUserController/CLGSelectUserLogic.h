//
//  CLGSelectUserViewModel.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGLogic.h"

@class RACCommand;

@interface CLGSelectUserLogic : CLGLogic

@property (nonatomic, strong) NSString *name;

@property (nonatomic) BOOL nameIsValid;

@end
