//
//  Doctor.m
//  TestDelegate
//
//  Created by Andriy Bas on 12/31/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor


# pragma mark - PatientDelegate

- (void) patientFeelsBad:(Patient*) patient {
    NSLog(@"Patient %@ feels bad",  patient.name);
    
    if(patient.temperature > 37.0 && patient.temperature < 39.0F) {
        [patient takePills];
    } else if(patient.temperature >= 39.0F) {
        [patient makeShot];
    } else {
        NSLog(@"Patient %@ is taking rest", patient.name);
    }
    
}


- (void) patient:(Patient*) patient iHaveQuestion:(NSString*) question {
    
}

@end
