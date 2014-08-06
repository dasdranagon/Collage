//
//  CLGSelectUserViewModelTests.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "CLGSelectUserViewModel.h"

SpecBegin(CLGSelectUserViewModel)

__block CLGSelectUserViewModel *viewModel;

beforeEach(^{
    viewModel = [[CLGSelectUserViewModel alloc] init];
});

describe(@"CLGSelectUserViewModel", ^{
    it(@"name is to short", ^{
        viewModel.name = @"ol";
        expect(viewModel.validName).to.equal(NO);
    });
    
    it(@"name is to long", ^{
        viewModel.name = @"olqwertyuiopansdfkrlartodnjfgtrmahetfgkddsdsdsfdfe";
        expect(viewModel.validName).to.equal(NO);
    });
    
    it(@"name contains unallowed sumbols", ^{
        viewModel.name = @"qwerty 123";
        expect(viewModel.validName).to.equal(NO);
    });
    
    it(@"name is correct", ^{
        viewModel.name = @"QweRty_123";
        expect(viewModel.validName).to.equal(YES);
    });

});


SpecEnd
