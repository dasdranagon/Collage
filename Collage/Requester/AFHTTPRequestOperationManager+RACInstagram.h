//
//  AFHTTPRequestOperationManager+RACInstagram.h
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@class RACSignal;

extern NSString * const kRequestMethodGET;
extern NSString * const kResponseErrorType;

@interface AFHTTPRequestOperationManager (RACInstagram)

- (RACSignal *)requestMethod:(NSString *)method
                      action:(NSString *)action
                      params:(NSDictionary *)parameters;

- (RACSignal *)searchUsers:(NSString *)q count:(NSInteger)count clientId:(NSString *)clientId;
- (RACSignal *)mediasForUserId:(NSString *)userId clientId:(NSString *)clientId;

@end
