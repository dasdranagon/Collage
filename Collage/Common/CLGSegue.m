//
//  CLGSegue.m
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGSegue.h"

@implementation CLGSegue

+ (instancetype)segueWithIdentifier:(NSString *)identifier
{
    CLGSegue *segue = [self new];
    segue.identifier = identifier;
    return segue;
}

@end
