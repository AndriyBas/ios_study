//
//  StringUtils.h
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject



- (void) log;
- (NSString*) getDate;
- (void) logGreeeting: (NSString*) name withMessage:(NSString*) message;

- (NSString*) whoAreYou;
+ (NSString*) whoAreYou;

@end
