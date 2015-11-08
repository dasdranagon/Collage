//
//  CLGRequester.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGRequester.h"
#import "AFHTTPRequestOperationManager+RACInstagram.h"
#import "IGUser.h"
#import "IGMedia.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

static NSString * const kClientId = @"1a71a8c12a33447da52688850aac8538";

NSString * const kCLGRequestErrorDomain = @"CLGRequestErrorDomain";

@interface CLGRequester()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation CLGRequester

+ (CLGRequester *)sharedInstance
{
    static CLGRequester *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CLGRequester alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.instagram.com/v1/"]];
    }
    
    return self;
}

- (RACSignal *)bestPhotosForUesr:(NSString *)userName
{
    RACSignal *userId = [_manager searchUsers:userName
                                        count:1
                                     clientId:kClientId];
    
    
    

    @weakify(self);
    RACSignal *bestImages = [userId flattenMap:^RACStream *(RACSequence *users) {
        @strongify(self);
        IGUser *user = users.head;
        RACSignal *signal = nil;
        if (!user) {
            signal = [RACSignal error:[NSError errorWithDomain:kCLGRequestErrorDomain code:0 userInfo:nil]];
        }
        else {
            signal = [self.manager mediasForUserId:user.userId clientId:kClientId];
        }
        
        return signal;
    }];
    
    bestImages = [bestImages map:^id(RACSequence *medias) {
        RACSequence *images = [medias filter:^BOOL(IGMedia *media) {
            return (media.type == InstagrammMediaTypeImage) && (media.likesCount != 0);
        }];
        
        return images;
    }];
    
    return bestImages;
}

@end
