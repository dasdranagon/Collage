//
//  OCMockObject+ReactiveCocoa.h
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import <OCMock/OCMock.h>

@interface OCMockObject (ReactiveCocoa)
- (void)observeProperty:(NSString *)property;
@end
