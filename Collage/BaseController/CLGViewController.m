//
//  CLGViewController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGViewController.h"
#import "CLGLogic.h"
#import <HTProgressHUD/HTProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation CLGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(self.logic, @"logic is not initialized");
    
    [self.logic didLoad];
    self.logic.active = YES;
    
    [self.activityIndicator configWithView:self.view];
    RAC(self.alertManager, message) = [[RACObserve(self.logic, alert) skip:1] deliverOn:[RACScheduler mainThreadScheduler]];
    RAC(self.activityIndicator, progressing) = [RACObserve(self.logic, processing) deliverOn:[RACScheduler mainThreadScheduler]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.logic prepareForSegue:segue];
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"💀dealoc:%@",[self class]);
#endif
}

@end
