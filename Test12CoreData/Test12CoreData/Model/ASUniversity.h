//
//  ASUniversity.h
//  Test12CoreData
//
//  Created by Andriy Bas on 4/16/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASCourse, ASStudent;

@interface ASUniversity : ASObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *students;
@end

@interface ASUniversity (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(ASCourse *)value;
- (void)removeCoursesObject:(ASCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addStudentsObject:(ASStudent *)value;
- (void)removeStudentsObject:(ASStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
