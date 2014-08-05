//
//  IGUser.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "IGUser.h"

@implementation IGUser

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _id = dict[@"id"];
        _name = [NSString stringWithFormat:@"%@ %@", dict[@"first_name"], dict[@"last_name"]];
        _picture = dict[@"profile_picture"];
    }
    return self;
}

@end
