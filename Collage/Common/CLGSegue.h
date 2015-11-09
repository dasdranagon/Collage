//
//  CLGSegue.h
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLGSegue : NSObject

+ (instancetype)segueWithIdentifier:(NSString *)identifier;

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSDictionary *initialInfo;

@end
