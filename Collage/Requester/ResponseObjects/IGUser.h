//
//  IGUser.h
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGUser : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;

@end
