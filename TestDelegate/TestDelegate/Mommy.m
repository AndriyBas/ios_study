//
//  Mommy.m
//  TestDelegate
//
//  Created by Andriy Bas on 1/2/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Mommy.h"
#import "Government.h"

@implementation Mommy

#pragma mark - Implementation
- (instancetype) init {
    self = [super init];
    
    if(self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(salaryChangedNotification:) name:GovernmentSalaryDidChangeNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(taxLevelChangedNotification:)
                   name:GovernmentTaxLevelDidChangeNotification
                 object:nil];
    
    }
    
    return self;
}

- (void) dealloc {
    NSLog(@"Mommy is deallocated");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) salaryChangedNotification:(NSNotification*) notification {
    NSNumber* number = [notification.userInfo objectForKey:GovernmentSalaryUserInfoKey];

    CGFloat s = [number floatValue];
    
    NSLog(@"Mommy %@ cries, salary changed, userInfo : %@", self.name, notification.userInfo);
}

- (void) taxLevelChangedNotification:(NSNotification*) notification {
    NSLog(@"Mommy %@ cries, taxLevelChanged, userInfo : %@", self.name, notification.userInfo);
}

- (NSString*) superSecretText {
    return @"I have stolen your candy";
}

@end
