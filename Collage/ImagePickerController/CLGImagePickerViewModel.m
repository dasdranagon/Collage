//
//  CLGImagePickerViewModel.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "CLGRequester.h"

@interface CLGImagePickerViewModel(){
    RACMulticastConnection *_umagesListMulticast;
    NSMutableIndexSet *_mutableIndexsList;
}
@end

@implementation CLGImagePickerViewModel

- (instancetype)initWidthRequester:(CLGRequester *)requester
{
    NSParameterAssert(requester);
    
    self = [super init];
    if (self) {
        _umagesListMulticast = [[[[RACObserve(self, userName) filter:^BOOL(id value) {
            return value != nil;
        }] flattenMap:^RACStream *(NSString *name) {
            return [requester bestPhotosForUesr:name];
        }] materialize] multicast:[RACReplaySubject subject]];
        [_umagesListMulticast connect];
        
        RAC(self, images) = [[[_umagesListMulticast.signal filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeNext;
        }] dematerialize] map:^id(RACSequence *sequance) {
            return sequance.array;
        }];
        
        RAC(self, alert) = [[[_umagesListMulticast.signal filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeError;
        }] map:^id(RACEvent *event) {
            return [RACEvent eventWithValue:event.error.localizedDescription];
        }] dematerialize];
        
        RAC(self, processing) = [[_umagesListMulticast.signal map:^id(RACEvent *event) {
            return @((event.value == nil) && (event.eventType == RACEventTypeNext));
        }] startWith:@(YES)];
        
        _mutableIndexsList = [[NSMutableIndexSet alloc] init];
    }
    
    return self;
}

- (void)toggleIndex:(NSInteger)index
{
    if ([_mutableIndexsList containsIndex:index]) {
        [_mutableIndexsList removeIndex:index];
    }
    else{
        [_mutableIndexsList addIndex:index];
    }
    
    self.canMakeCollage = (_mutableIndexsList.count > 1) && (_mutableIndexsList.count < 9);
}

- (NSIndexSet *)selectedIndexs
{
    return [_mutableIndexsList copy];
}

@end
