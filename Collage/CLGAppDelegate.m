//
//  CLGAppDelegate.m
//  Collage
//
//  Created by Denis Skokov on 05.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGAppDelegate.h"

@implementation CLGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"collage" bundle:nil];
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
