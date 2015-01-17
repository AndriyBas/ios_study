//
//  Student.m
//  Test3
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student

#pragma mark - Patient

- (BOOL) areYouOK {
    
    BOOL isOK = arc4random() % 2;
    
    NSLog(@"Is Student %@ OK ? %@", self.name, isOK ? @"YES" : @"NO");
    
    return isOK;
}

- (void) makeShot {
    NSLog(@"Student %@ makes a shot", self.name);
}

- (void) takePill {
    NSLog(@"Student %@ takes a pill",  self.name);
}

@end
