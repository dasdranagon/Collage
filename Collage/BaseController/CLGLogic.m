//
//  CLGLogic.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGLogic.h"
#import "CLGSegue.h"
#import "CLGViewController.h"

@implementation CLGLogic

- (void)didLoad
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
{
    __block CLGSegue *sg = nil;
    [self.segues enumerateObjectsUsingBlock:^(CLGSegue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:segue.identifier]) {
            sg = obj;
            *stop = YES;
        }
    }];
    
    CLGViewController *destinationController = [segue destinationViewController];
    
    @weakify(self);
    [sg.initialInfo enumerateKeysAndObjectsUsingBlock:^(NSString *from, NSString *to, BOOL * _Nonnull stop) {
        @strongify(self);
        [destinationController.logic setValue:[self valueForKey:from] forKey:to];
    }];
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"💀dealoc:%@",[self class]);
#endif
}

@end
