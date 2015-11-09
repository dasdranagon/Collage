//
//  CLGRequester.h
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

extern NSString * const kCLGRequestErrorDomain;

@interface CLGRequester : NSObject
- (RACSignal *)bestPhotosForUesr:(NSString *)userName;
@end
