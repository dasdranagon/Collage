//
//  CLGUtilitiesAssembly.h
//  Collage
//
//  Created by Denis Skokov on 08.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "TyphoonAssembly.h"

@interface CLGUtilitiesAssembly : TyphoonAssembly

- (id<CLGActivityIndicator>)activityIndicator;
- (id<CLGAlertManager>)alertManager;
- (id<CLGPrintManager>)printManager;
- (id)requester;

@end
