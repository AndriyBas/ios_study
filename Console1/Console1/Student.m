//
//  Student.m
//  Console1
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void) fuck:(NSString*) person during:(NSInteger)time withCondoms:(BOOL)hasCondoms {
    NSLog(@"Fucking %@ during %ld sec %@ condoms", person, time, hasCondoms ? @"with" : @"withot");
}


@end
