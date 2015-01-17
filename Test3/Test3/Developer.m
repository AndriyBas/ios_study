//
//  Developer.m
//  Test3
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Developer.h"

@implementation Developer


- (void) code {
    NSLog(@"Developer %@ is coding!", self.name);
}

#pragma mark - Patient

- (BOOL) areYouOK {
    
    BOOL isOK = arc4random() % 2;
    
    NSLog(@"Is Developer %@ OK ? %@", self.name, isOK ? @"YES" : @"NO");
    
    return isOK;
}

- (void) makeShot {
    NSLog(@"Developer %@ makes a shot", self.name);
}

- (void) takePill {
    NSLog(@"Developer %@ takes a pill",  self.name);
}

- (void) howIsYourFamily {
    NSLog(@"Developer %@, how is your Family ? %@", self.name, (arc4random() % 2 == 0) ? @"Good" : @"Bad");
}


@end
