//
//  IGMedia.h
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IGImage;

typedef NS_ENUM(NSInteger, InstagrammMediaType)
{
    InstagrammMediaTypeImage,
    InstagrammMediaTypeVideo,
    InstagrammMediaTypeUndefined
};

@interface IGMedia : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@property (nonatomic, strong) NSString *mediaId;
@property (nonatomic) InstagrammMediaType type;
@property (nonatomic) NSInteger likesCount;
@property (nonatomic, strong) IGImage *thumbnail;
@property (nonatomic, strong) IGImage *lowImage;
@property (nonatomic, strong) IGImage *standardImage;
@end
