//
//  CLGViewControllerTests.m
//  
//
//  Created by Denis Skokov on 06.08.14.
//
//

#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#import "OCMockObject+ReactiveCocoa.h"

#import "CLGViewController.h"
#import "CLGLogic.h"

SpecBegin(CLGViewController)

__block CLGViewController *controller;
__block id logicMoc;
__block id activityIndicatorMoc;

beforeEach(^{
    controller = [[CLGViewController alloc] init];
    
    logicMoc = [OCMockObject partialMockForObject:[[CLGLogic alloc] init]];
    controller.logic = logicMoc;
});

describe(@"CLGViewController", ^{
    
    it(@"activity indicator should be configured after loading view", ^{
        activityIndicatorMoc = [OCMockObject mockForProtocol:@protocol(CLGActivityIndicator)];
        controller.activityIndicator = activityIndicatorMoc;
        [[activityIndicatorMoc expect] configWithView:OCMOCK_ANY];
        [controller viewDidLoad];
        [activityIndicatorMoc verify];
    });
    
    it(@"should activate model in viewDoidLoad method", ^{
        [[logicMoc expect] setActive:YES];
        [controller viewDidLoad];
        [logicMoc verify];
    });
    
    it(@"should call didLoad for viewModel in viewDoidLoad method", ^{
        [[logicMoc expect] didLoad];
        [controller viewDidLoad];
        [logicMoc verify];
    });

    it(@"should call prepareForSegue for viewModel", ^{
        
        OCMockObject *segue = [OCMockObject mockForClass:[UIStoryboardSegue class]];
        
        [[logicMoc expect] prepareForSegue:[OCMArg any]];
        [controller prepareForSegue:(UIStoryboardSegue *)segue sender:nil];
        [logicMoc verify];
    });
    
    it(@"should subscribe to changing alert property in viewDoidLoad method", ^{
        [logicMoc observeProperty:@"alert"];
        [controller viewDidLoad];
        [logicMoc verify];
    });
    
    it(@"should subscribe to changing processing property in viewDoidLoad method", ^{
        [logicMoc observeProperty:@"processing"];
        [controller viewDidLoad];
        [logicMoc verify];
    });
});

SpecEnd