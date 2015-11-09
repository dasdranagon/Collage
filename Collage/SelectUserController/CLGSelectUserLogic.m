//
//  CLGSelectUserViewModel.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGSelectUserLogic.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation CLGSelectUserLogic

- (id)init
{
    self = [super init];
    if (self) {
        NSRegularExpression *regExt = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z0-9_]*$" options:0 error:nil];

        RAC(self, nameIsValid) = [RACObserve(self, name) map:^id(NSString *value) {
            return @( (value.length > 3) && (value.length < 40) &&
            ([regExt firstMatchInString:value options:0 range:NSMakeRange(0, [value length])].range.length == value.length)
            );
        }];
    }
    return self;
}

@end
