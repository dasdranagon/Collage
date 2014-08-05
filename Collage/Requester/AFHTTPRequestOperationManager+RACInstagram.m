//
//  AFHTTPRequestOperationManager+RACInstagram.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "AFHTTPRequestOperationManager+RACInstagram.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "IGUser.h"
#import "IGImage.h"
#import "IGMedia.h"

NSString * const kRequestMethodGET = @"GET";

static NSString * const kResponseData = @"data";
static NSString * const kResponseMeta = @"meta";

NSString * const kResponseErrorType = @"error_type";
static NSString * const kResponseErrorCode = @"code";
static NSString * const kResponseErrorMessage = @"error_message";

static NSString * const kInstagramResponseErrorDomain = @"InstagramResponseErrorDomain";


@implementation AFHTTPRequestOperationManager (RACInstagram)

- (RACSignal *)requestMethod:(NSString *)method
                      action:(NSString *)action
                      params:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:action relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters error:nil];
    @weakify(self);
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
#ifdef DEBUG
        NSLog(@"▶️ %@", request.URL);
        NSLog(@"🔵 %@", request.allHTTPHeaderFields);
        NSLog(@"(%@) 🔷 %@", action, parameters);
#endif
        
        AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError *responseError = nil;
            NSDictionary *response = operation.responseObject;
            if ([response isKindOfClass:[NSDictionary class]]){
                NSDictionary *meta = response[kResponseMeta];
                if (meta){
                    if (meta[kResponseErrorType]) {
                        NSInteger code = [meta[kResponseErrorCode] integerValue];
                        NSString *type = meta[kResponseErrorType];
                        NSString *message = meta[kResponseErrorMessage];
                        
                        if (!message) {
                            message = @"undefined server error";
                        }
                        
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:message,
                                                   kResponseErrorType:type};
                        
                        responseError = [NSError errorWithDomain:kInstagramResponseErrorDomain
                                                            code:code
                                                        userInfo:userInfo];
                    }
                }
            }
            else{
                responseError = [NSError errorWithDomain:kInstagramResponseErrorDomain
                                                    code:0
                                                userInfo:@{NSLocalizedDescriptionKey:@"undefined response format"}];
            }
            
            if (responseError) {
                [subscriber sendError:responseError];
            } else {
                id data = response[kResponseData];
                if (data) {
                    [subscriber sendNext:data];
                }
                [subscriber sendCompleted];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        op.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        [self.operationQueue addOperation:op];
        
        return [RACDisposable disposableWithBlock:^{
            [op cancel];
        }];
    }];
    
#ifdef DEBUG
    requestSignal= [requestSignal doNext:^(id responseObject) {
        NSLog(@"(%@) ✅ %@", action, responseObject);
    }];
    
    requestSignal = [requestSignal doError:^(NSError *error) {
        NSLog(@"(%@) ❌ %@", action, error);
    }];
    
    requestSignal = [requestSignal doCompleted:^{
        NSLog(@"(%@) ❎ completed successful", action);
    }];
#endif
    
    return requestSignal;
}

#pragma mark -- requests

- (RACSignal *)searchUsers:(NSString *)q count:(NSInteger)count clientId:(NSString *)clientId
{
    NSParameterAssert(clientId);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@(count), @"count", clientId, @"client_id", nil];
    if (q) {
        params[@"q"] = q;
    }
    RACSignal *signal = [self requestMethod:kRequestMethodGET
                                     action:@"users/search"
                                     params:[params copy]];
    
    signal = [signal map:^id(NSArray *arr) {
        RACSequence *sequance = nil;
        if ([arr isKindOfClass:[NSArray class]]) {
            sequance = [arr.rac_sequence map:^id(id value) {
                return [[IGUser alloc] initWithDictionary:value];
            }];
        }
        return sequance;
    }];
    
    return [signal setNameWithFormat:@"%s q:%@", __func__, q];
}

- (RACSignal *)mediasForUserId:(NSString *)userId clientId:(NSString *)clientId
{
    NSParameterAssert(clientId);
    NSParameterAssert(userId);
    
    NSString *action = [NSString stringWithFormat:@"users/%@/media/recent", userId];
    RACSignal *signal = [self requestMethod:kRequestMethodGET
                                     action:action
                                     params:@{@"client_id":clientId}];
    
    signal = [signal map:^id(NSArray *arr) {
        RACSequence *sequance = nil;
        if ([arr isKindOfClass:[NSArray class]]) {
            sequance = [arr.rac_sequence map:^id(id value) {
                return [[IGMedia alloc] initWithDictionary:value];
            }];
        }
        return sequance;
    }];
    
    return [signal setNameWithFormat:@"%s %@", __func__, action];
}

@end
