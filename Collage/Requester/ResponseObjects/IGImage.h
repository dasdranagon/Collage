//
//  IGImage.h
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGImage : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *url;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@end
