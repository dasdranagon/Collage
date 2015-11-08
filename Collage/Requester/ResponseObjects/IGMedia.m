//
//  IGMedia.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "IGMedia.h"
#import "IGImage.h"

@implementation IGMedia

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _mediaId = dict[@"id"];
        _type = [self mediaTypeFromString:dict[@"type"]];
        
        NSDictionary *likes = dict[@"likes"];
        if (likes) {
            _likesCount = [likes[@"count"] intValue];
        }
        
        NSDictionary *images = dict[@"images"];
        if (images) {
            _thumbnail = [[IGImage alloc] initWithDictionary:images[@"thumbnail"]];
            _lowImage = [[IGImage alloc] initWithDictionary:images[@"low_resolution"]];
            _standardImage = [[IGImage alloc] initWithDictionary:images[@"standard_resolution"]];
        }
    }
    
    return self;
}

- (InstagrammMediaType)mediaTypeFromString:(NSString *)strType
{
    if ([strType isEqualToString:@"image"]) {
        return InstagrammMediaTypeImage;
    }
    
    if ([strType isEqualToString:@"video"]) {
        return InstagrammMediaTypeVideo;
    }
    
    return InstagrammMediaTypeUndefined;
}

@end
