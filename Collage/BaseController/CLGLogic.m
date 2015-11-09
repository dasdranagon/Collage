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
   id<CLGSegue> sg = self.segues[segue.identifier];
   
    [sg prepareWithSourceLogic:self];
    CLGViewController *destinationController = [segue destinationViewController];
    
    [sg applyForDestinationLogic:destinationController.logic];
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"💀dealoc:%@",[self class]);
#endif
}

@end
