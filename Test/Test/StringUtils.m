//
//  StringUtils.m
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"String Utils initialized");
    }
    return self;
}

- (void) log {
    NSLog(@"wow");
}

- (NSString*) getDate {
    return [NSString stringWithFormat:@"%@", [NSDate date]];
}

- (void) logGreeeting: (NSString*) name withMessage:(NSString*) message {
    NSLog(@"%@, %@", name, message);
}

+ (NSString* ) getPreffix {
    return @"I am :";
}

- (NSString*) whoAreYou {
    return [NSString stringWithFormat:@"%@ %@", [StringUtils getPreffix], self];
}

+ (NSString*) whoAreYou {
    return [NSString stringWithFormat:@"%@ %@", [StringUtils getPreffix], self];
}

@end
