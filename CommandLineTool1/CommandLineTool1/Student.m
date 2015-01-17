//
//  Student.m
//  CommandLineTool1
//
//  Created by Andriy Bas on 1/4/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student

static int count = 0;

- (void) sayHello {
    NSLog(@"Hello");
}

- (void) setGlobalVar:(int) val {
    extern int globalVar;
    
    globalVar = val;
}

+ (instancetype) alloc {
    
    extern int count;
    
    count++;
    
    return [super alloc];
}

+ (int) getCount {
    return count;
}

@end
