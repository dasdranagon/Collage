//
//  CLGStandartPrintManager.h
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLGPrintManager.h"

@interface CLGStandartPrintManager : NSObject <CLGPrintManager>
@property (nonatomic, strong) NSString *lastMessage;

- (void)printImage:(UIImage *)image;

@end
