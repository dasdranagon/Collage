//
//  CLGKVCSegue.h
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLGSegue.h"

@interface CLGKVCSegue : NSObject <CLGSegue>


+ (instancetype)segueWithMapDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSDictionary *mapDictionary;

@end
