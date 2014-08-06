//
//  CLGSelectUserController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGSelectUserController.h"
#import "CLGSelectUserViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CLGSelectUserController () <UITextFieldDelegate>
@property (nonatomic, strong) CLGSelectUserViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@end

@implementation CLGSelectUserController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.viewModel = [[CLGSelectUserViewModel alloc] init];
}

- (void)viewDidLoad
{
    NSAssert(self.viewModel, @"viewModel not seted");
    [super viewDidLoad];
    
    RAC(self.viewModel, name) = self.userNameTextfield.rac_textSignal;
    RAC(self.navigationItem.rightBarButtonItem, enabled) = RACObserve(self.viewModel, validName);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
