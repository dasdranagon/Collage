//
//  CLGKVCSegue.m
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGKVCSegue.h"
#import "CLGLogic.h"

@interface CLGKVCSegue()
@property (nonatomic, strong) id src;
@end

@implementation CLGKVCSegue

+ (instancetype)segueWithMapDictionary:(NSDictionary *)dictionary
{
    CLGKVCSegue *segue = [self new];
    segue.mapDictionary = dictionary;
    return segue;
}


- (void)prepareWithSourceLogic:(CLGLogic *)logic
{
    self.src = logic;
}

- (void)applyForDestinationLogic:(CLGLogic *)logic
{
    @weakify(self);
    [self.mapDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *from, NSString *to, BOOL * _Nonnull stop) {
        @strongify(self);
        [logic setValue:[self.src valueForKey:from] forKey:to];
    }];
}

@end
