//
//  CLGLogicsAssembly.m
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGLogicsAssembly.h"
#import "CLGUtilitiesAssembly.h"

#import "CLGSegue.h"

#import "CLGSelectUserLogic.h"
#import "CLGImagePickerLogic.h"
#import "CLGCollageLogic.h"

@interface CLGLogicsAssembly()
@property (nonatomic, strong, readonly) CLGUtilitiesAssembly *utilities;
@end


@implementation CLGLogicsAssembly

- (id)baseLogic
{
    return [TyphoonDefinition withClass:[CLGLogic class]];
}

- (id)selectUserLogic
{
    return [TyphoonDefinition withClass:[CLGSelectUserLogic class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = self.baseLogic;
        
        CLGSegue *segue = [CLGSegue segueWithIdentifier:@"goToImagePicker"];
        [segue setInitialInfo:@{@"name":@"userName"}];
        [definition injectProperty:@selector(segues) with:@[segue]];
    }];
}

- (id)imagePickerLogic
{
    return [TyphoonDefinition withClass:[CLGImagePickerLogic class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = self.baseLogic;
        [definition injectProperty:@selector(requester) with:self.utilities.requester];
        CLGSegue *segue = [CLGSegue segueWithIdentifier:@"goToCollageScreen"];
        [segue setInitialInfo:@{@"selectedImages":@"images"}];
        [definition injectProperty:@selector(segues) with:@[segue]];
    }];
}

- (id)collageLogic
{
    return [TyphoonDefinition withClass:[CLGCollageLogic class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = self.baseLogic;
    }];
}

@end
