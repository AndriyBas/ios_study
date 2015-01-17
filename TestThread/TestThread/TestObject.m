//
//  TestObject.m
//  TestThread
//
//  Created by Andriy Bas on 1/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (instancetype)init {
    self = [super init];
    if(self) {
        NSLog(@"TestObject allocated");
        
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
        [timer setFireDate: [NSDate dateWithTimeIntervalSinceNow:1]];
    }
    return self;
}

- (void) timerTest:(NSTimer*) timer {
    
    NSDate* date = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSSS"];
    
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [timer invalidate];
}

- (void)dealloc {
    NSLog(@"TestObject deallocated");
}
@end
