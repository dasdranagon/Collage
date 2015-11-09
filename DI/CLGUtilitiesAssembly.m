//
//  CLGUtilitiesAssembly.m
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGUtilitiesAssembly.h"
#import "CLGAlertViewManager.h"
#import "HTProgressHUD+CLGActivityIndicator.h"
#import "CLGStandartPrintManager.h"
#import "CLGRequester.h"

@implementation CLGUtilitiesAssembly

- (id)activityIndicator
{
    return [TyphoonDefinition withClass:[HTProgressHUD class]];
}

- (id)alertManager
{
    return [TyphoonDefinition withClass:[CLGAlertViewManager class]];
}

- (id<CLGPrintManager>)printManager
{
    return [TyphoonDefinition withClass:[CLGStandartPrintManager class]];
}

- (id)requester
{
    return [TyphoonDefinition withClass:[CLGRequester class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

@end
