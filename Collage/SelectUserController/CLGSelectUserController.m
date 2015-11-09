//
//  CLGSelectUserController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGSelectUserController.h"
#import "CLGSelectUserLogic.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CLGRequester.h"


@interface CLGSelectUserController () <UITextFieldDelegate>
@property (nonatomic, strong) CLGSelectUserLogic *logic;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@end

@implementation CLGSelectUserController
@dynamic logic;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Select user", nil);
    self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Next", nil);
    
    RAC(self.logic, name) = self.userNameTextfield.rac_textSignal;
    RAC(self.navigationItem.rightBarButtonItem, enabled) = RACObserve(self.logic, nameIsValid);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
