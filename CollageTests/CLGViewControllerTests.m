//
//  CLGViewControllerTests.m
//  
//
//  Created by Denis Skokov on 06.08.14.
//
//

#import "Specta.h"
#import <OCMock/OCMock.h>
#import "OCMockObject+ReactiveCocoa.h"

#import "CLGViewController.h"
#import "CLGViewModel.h"

SpecBegin(FGFBaseViewController)

__block CLGViewController *controller;
__block id viewModelMoc;

beforeEach(^{
    controller = [[CLGViewController alloc] init];
    viewModelMoc = [OCMockObject partialMockForObject:[[CLGViewModel alloc] init]];
    controller.viewModel = viewModelMoc;
});

describe(@"FGFBaseViewController", ^{
    it(@"should activate model in viewDoidLoad method", ^{
        [[viewModelMoc expect] setActive:YES];
        [controller viewDidLoad];
        [viewModelMoc verify];
    });
    
    it(@"should subscribe to changing alert property in viewDoidLoad method", ^{
        [viewModelMoc observeProperty:@"alert"];
        [controller viewDidLoad];
        [viewModelMoc verify];
    });
    
    it(@"should subscribe to changing processing property in viewDoidLoad method", ^{
        [viewModelMoc observeProperty:@"processing"];
        [controller viewDidLoad];
        [viewModelMoc verify];
    });
});

SpecEnd