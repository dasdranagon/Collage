//
//  CLGImagePickerController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerController.h"
#import "CLGImagePickerViewModel.h"

@interface CLGImagePickerController ()
@property (nonatomic, strong) CLGImagePickerViewModel *viewModel;
@end

@implementation CLGImagePickerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CLGViewModel *)createViewModel
{
    return [[CLGImagePickerViewModel alloc] init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
