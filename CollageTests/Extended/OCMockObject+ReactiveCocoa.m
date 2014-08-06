//
//  OCMockObject+ReactiveCocoa.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "OCMockObject+ReactiveCocoa.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OCMockObject (ReactiveCocoa)

- (void)observeProperty:(NSString *)property
{
    [[self expect] rac_valuesForKeyPath:property observer:[OCMArg any]];
}

@end
