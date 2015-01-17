//
//  Patient.h
//  TestDelegate
//
//  Created by Andriy Bas on 12/31/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientDelegate;
@class Doctor;

@interface Patient : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float temperature;
@property (weak, nonatomic) id<PatientDelegate>  delegate;


- (BOOL) howAreYou;
- (void) takePills;
- (void) makeShot;

@end


@protocol PatientDelegate <NSObject>

@required
- (void) patientFeelsBad:(Patient*) patient;
- (void) patient:(Patient*) patient iHaveQuestion:(NSString*) question;

@end