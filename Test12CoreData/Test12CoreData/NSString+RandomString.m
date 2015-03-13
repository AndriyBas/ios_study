//
//  NSString+RandomString.m
//  Test12CoreData
//
//  Created by Andriy Bas on 3/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "NSString+RandomString.h"

@implementation NSString (RandomString)


+ (NSString*) randomAlphaNumericString {
        static const NSString* str = @"abcdefghigklmopqrstuvwxyz0123456789";
    
    int capacity = 5 + arc4random() % 10;
    NSMutableString* ms = [NSMutableString stringWithCapacity:capacity];
    
    for(int i = 0; i < capacity; i++) {
        [ms appendFormat:@"%C", [str characterAtIndex:arc4random() % str.length]];
    }
    
    return ms;
}

@end
