//
//  CLGViewController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGViewController.h"
#import "CLGViewModel.h"
#import <HTProgressHUD/HTProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface CLGViewController ()
@property (nonatomic, strong) HTProgressHUD *progressHUD;
@end

@implementation CLGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.viewModel) {
        self.viewModel.active = YES;
        [[RACObserve(self.viewModel, alert) filter:^BOOL(id value) {
            return value != nil;
        }] subscribeNext:^(NSString *alert) {
            [[[UIAlertView alloc] initWithTitle:nil message:alert delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }];
        
        @weakify(self);
        [RACObserve(self.viewModel, processing) subscribeNext:^(NSNumber *processing) {
            @strongify(self);
            if ([processing boolValue]) {
                if (!self.progressHUD) {
                    self.progressHUD = [[HTProgressHUD alloc] init];
                }
                [self.progressHUD showInView:self.view];
            }
            else {
                [self.progressHUD hide];
            }
        }];
    }
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"💀dealoc:%@",[self class]);
#endif
}

@end
