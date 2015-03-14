//
//  Student.h
//  Test12CoreData
//
//  Created by Andriy Bas on 3/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Parent.h"

@class Car, University;

@interface Student : Parent

@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Car *car;
@property (nonatomic, retain) University *university;

@end
