//
//  Patient.m
//  TestDelegate
//
//  Created by Andriy Bas on 12/31/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (BOOL) howAreYou {
    
    BOOL isOK = arc4random() % 2;
    
    if(!isOK) {
        [self.delegate patientFeelsBad:self];
    }
    
    return isOK;
}

- (void) takePills {
    NSLog(@"Patrient %@ is taking pills", self.name);
}

- (void) makeShot {
    NSLog(@"Patrient %@ is taking shot", self.name);
}


@end
