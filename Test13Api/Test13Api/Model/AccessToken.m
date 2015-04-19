//
//  AccessToken.m
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken


- (instancetype) initWithUrl:(NSURL*) url {
    
    self = [super init];
    if(self) {
        NSString* query = [url description];
        NSArray* array = [query componentsSeparatedByString:@"#"];
        if([array count] > 0) {
            query = [array lastObject];
        } else {
            return nil;
        }
        array = [query componentsSeparatedByString:@"&"];
    
        for(NSString* pair in array) {
            NSArray* arg = [pair componentsSeparatedByString:@"="];
            if([arg count] == 2) {
                NSString* key = [arg objectAtIndex:0];
                id value = [arg objectAtIndex:1];
                if([@"access_token" isEqualToString:key]) {
                    self.token = value;
                } else if([@"expires_in" isEqualToString:key]) {
                    NSTimeInterval interval = [value doubleValue];
                    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                } else if([@"user_id" isEqualToString:key]) {
                    self.userID = value;
                }
            }
        }
    }
    return self;
}

@end
