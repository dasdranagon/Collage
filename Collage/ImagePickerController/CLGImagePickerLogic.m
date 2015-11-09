//
//  CLGImagePickerLogic.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerLogic.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "CLGRequester.h"

static NSInteger const kMinImageCount = 3;
static NSInteger const kMaxImageCount = 10;

@interface CLGImagePickerLogic()
@property (nonatomic, strong) RACMulticastConnection *imagesListMulticast;
@property (nonatomic, strong) NSMutableIndexSet *mutableIndexsList;
@end

@implementation CLGImagePickerLogic
@dynamic selectedIndexs, selectedImages;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imagesListMulticast = [[[[RACObserve(self, userName) filter:^BOOL(id value) {
            return value != nil;
        }] flattenMap:^RACStream *(NSString *name) {
            return [self.requester bestPhotosForUesr:name];
        }] materialize] multicast:[RACReplaySubject subject]];
        [self.imagesListMulticast connect];
        
        RAC(self, images) = [[[self.imagesListMulticast.signal filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeNext;
        }] dematerialize] map:^id(RACSequence *sequance) {
            return sequance.array;
        }];
        
        RAC(self, alert) = [[[self.imagesListMulticast.signal filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeError;
        }] map:^id(RACEvent *event) {
            return [RACEvent eventWithValue:event.error.localizedDescription];
        }] dematerialize];
        
        RAC(self, processing) = [[self.imagesListMulticast.signal map:^id(RACEvent *event) {
            return @((event.value == nil) && (event.eventType == RACEventTypeNext));
        }] startWith:@(YES)];
        
        self.mutableIndexsList = [[NSMutableIndexSet alloc] init];
    }
    
    return self;
}

- (void)toggleIndex:(NSInteger)index
{
    if ([self.mutableIndexsList containsIndex:index]) {
        [self.mutableIndexsList removeIndex:index];
    }
    else{
        [self.mutableIndexsList addIndex:index];
    }
    
    self.canMakeCollage = (self.mutableIndexsList.count >= kMinImageCount) && (self.mutableIndexsList.count <= kMaxImageCount);
}

- (NSIndexSet *)selectedIndexs
{
    return [self.mutableIndexsList copy];
}

- (NSArray *)selectedImages
{
    return [self.images objectsAtIndexes:self.mutableIndexsList];
}

@end
