//
//  Student.h
//  Test3
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Student : NSObject<Patient>

@property (strong, nonatomic) NSString* name;

@end
