//
//  ASStudent.h
//  Test12CoreData
//
//  Created by Andriy Bas on 4/16/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASCar, ASCourse, ASUniversity;

@interface ASStudent : ASObject

@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) ASCar *car;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) ASUniversity *university;
@end

@interface ASStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(ASCourse *)value;
- (void)removeCoursesObject:(ASCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
