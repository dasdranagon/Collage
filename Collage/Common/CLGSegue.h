//
//  CLGSegue.h
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLGLogic;
@protocol CLGSegue <NSObject>
- (void)prepareWithSourceLogic:(CLGLogic *)logic;
- (void)applyForDestinationLogic:(CLGLogic *)logic;
@end
