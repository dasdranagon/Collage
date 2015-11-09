//
//  HTProgressHUD+CLGActivityIndicator.m
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "HTProgressHUD+CLGActivityIndicator.h"
#import <objc/runtime.h>


static NSString * const kParentView = @"kParentView";

@implementation HTProgressHUD (CLGActivityIndicator)
@dynamic progressing;

- (void)configWithView:(UIView *)view
{
    objc_setAssociatedObject(self, &kParentView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)parentView
{
    return objc_getAssociatedObject(self, &kParentView);
}

- (void)setProgressing:(BOOL)progressing
{
    if (progressing) {
        UIView *parentView = [self parentView];
        NSAssert(parentView, @"%@ is not configured with view", [self class]);
        [self showInView:parentView];
    }
    else {
        [self hide];
    }
}

- (BOOL)progressing
{
    return !self.hidden;
}
@end
