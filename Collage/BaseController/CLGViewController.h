//
//  CLGViewController.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLGLogic;

@interface CLGViewController : UIViewController
@property (nonatomic, strong) CLGLogic *logic;

@property (nonatomic, strong) id<CLGAlertManager> alertManager;
@property (nonatomic, strong) id<CLGActivityIndicator> activityIndicator;
@end
