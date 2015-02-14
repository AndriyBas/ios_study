//
//  NSString+Random.m
//  TestView8Search
//
//  Created by Andriy Bas on 2/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+(NSString*) randomString {
    NSInteger length = arc4random() % 11 + 5;
    return [self randomStringWithLength:length];
}

+(NSString*) randomStringWithLength:(NSInteger) length {
    static NSString* origin = @"abcdefghigklmnopqrstuvwxyz"; //ABCDEFGHIGKLMNOPQRSTUVWXYZ1234567890";
    NSMutableString* res = [NSMutableString stringWithCapacity:length];
    
    for(int i = 0; i < length; i++) {
        [res appendFormat:@"%C", [origin characterAtIndex:arc4random() % origin.length]];
    }
    
    return res;
}

@end
