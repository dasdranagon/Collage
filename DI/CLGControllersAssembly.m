//
//  CLGControllersAssembly.m
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGControllersAssembly.h"
#import "CLGLogicsAssembly.h"
#import "CLGUtilitiesAssembly.h"

#import "CLGViewController.h"
#import "CLGSelectUserController.h"
#import "CLGImagePickerController.h"
#import "CLGCollageController.h"

@interface CLGControllersAssembly()
@property (nonatomic, strong, readonly) CLGUtilitiesAssembly *utilities;
@property (nonatomic, strong, readonly) CLGLogicsAssembly *logics;
@end

@implementation CLGControllersAssembly

- (id)baseViewController
{
    return [TyphoonDefinition withClass:[CLGViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(alertManager) with:self.utilities.alertManager];
        [definition injectProperty:@selector(activityIndicator) with:self.utilities.activityIndicator];
    }];
}

- (id)selectUserController
{
    return [TyphoonDefinition withClass:[CLGSelectUserController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self baseViewController];
        
        [definition injectProperty:@selector(logic) with:self.logics.selectUserLogic];
    }];
}

- (id)imagePickerController
{
    return [TyphoonDefinition withClass:[CLGImagePickerController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self baseViewController];
        
        [definition injectProperty:@selector(logic) with:self.logics.imagePickerLogic];
    }];
}

- (id)сollageController
{
    return [TyphoonDefinition withClass:[CLGCollageController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self baseViewController];
        
        [definition injectProperty:@selector(logic) with:self.logics.collageLogic];
        [definition injectProperty:@selector(printManager) with:self.utilities.printManager];
    }];
}

@end
