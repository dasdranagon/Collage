//
//  CLGImagePickerViewModelTests.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <OCMock/OCMock.h>
#import "CLGRequester.h"
#import "CLGImagePickerViewModel.h"

SpecBegin(CLGImagePickerViewModel)

__block CLGImagePickerViewModel *viewModel;
__block OCMockObject *requesterMoc;

beforeEach(^{
    requesterMoc = [OCMockObject mockForClass:[CLGRequester class]];
    viewModel = [[CLGImagePickerViewModel alloc] initWidthRequester:(CLGRequester *)requesterMoc];
});

describe(@"CLGImagePickerViewModel", ^{
    
    it(@"call request if change userName", ^{
        [[[requesterMoc expect] andReturn:[RACSubject subject]] bestPhotosForUesr:[OCMArg any]];;
        viewModel.userName = @"nature";
        [requesterMoc verify];
    });
    
    it(@"change index set if toggle index", ^{
        [viewModel toggleIndex:0];
        id indexSetPointer = viewModel.selectedIndexs;
        [viewModel toggleIndex:0];
        expect(viewModel.selectedIndexs).toNot.equal(indexSetPointer);
    });
    
    it(@"don't change index set if don't toggle index", ^{
        [viewModel toggleIndex:0];
        id indexSetPointer = viewModel.selectedIndexs;
        [viewModel toggleIndex:0];
        [viewModel toggleIndex:0];
        expect(viewModel.selectedIndexs).to.equal(indexSetPointer);
    });
    
});

SpecEnd