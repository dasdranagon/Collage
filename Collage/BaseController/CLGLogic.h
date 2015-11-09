//
//  CLGLogic.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class CLGSegue;

@interface CLGLogic : RVMViewModel
- (void)didLoad;
- (void)prepareForSegue:(UIStoryboardSegue *)segue;

@property (nonatomic, strong) NSArray *segues;
@property (nonatomic) BOOL processing;
@property (nonatomic, strong) NSString *alert;
@end
