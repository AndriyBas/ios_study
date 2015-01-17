//
//  TestChild.m
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "TestChild.h"

@implementation TestChild

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestChild initialized");
    }
    
    [self logGreeeting:@"self" withMessage:@"hello"];
    
    return self;
}
//- (void) logGreeeting: (NSString*) name withMessage:(NSString*) message {
//    NSLog(@"%@, greeting", name);
//}

@end
