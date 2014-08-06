//
//  CLGViewModel.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@interface CLGViewModel : RVMViewModel
@property (nonatomic) BOOL processing;
@property (nonatomic, strong) NSString *alert;
@end
