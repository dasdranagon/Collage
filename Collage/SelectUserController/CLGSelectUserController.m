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
#import "CLGRequester.h"
#import "CLGImagePickerViewModel.h"

static NSString * const kGoToImagePickerSegueIdentifier = @"goToImagePicker";

@interface CLGSelectUserController () <UITextFieldDelegate>
@property (nonatomic, strong) CLGSelectUserViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@end

@implementation CLGSelectUserController
@dynamic viewModel;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:kGoToImagePickerSegueIdentifier]){
        CLGImagePickerViewModel *imgPickerViewModel = [[CLGImagePickerViewModel alloc] initWidthRequester:[CLGRequester sharedInstance]];
        imgPickerViewModel.userName = self.viewModel.name;
        ((CLGViewController *)[segue destinationViewController]).viewModel = imgPickerViewModel;
    }
}

@end
