//
//  ChildObject.m
//  Test
//
//  Created by Andriy Bas on 12/28/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "ChildObject.h"

@implementation ChildObject


- (instancetype)init
{
    self = [super init];
    if (self) {
        _lastName = @"Last Name";
    }
    return self;
}

- (void) action {
    NSLog(@"%@ - child action", [self name]);
}

@end
