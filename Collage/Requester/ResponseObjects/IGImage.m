//
//  IGImage.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "IGImage.h"

@implementation IGImage

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _width = [dict[@"width"] floatValue];
        _height = [dict[@"height"] floatValue];
        _url = dict[@"url"];
    }
    
    return self;
}

@end
