//
//  CLGAlertViewManager.m
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGAlertViewManager.h"

@implementation CLGAlertViewManager
@dynamic message;

- (void)setMessage:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

- (NSString *)message
{
    return nil;
}

@end
