//
//  University.h
//  Test12CoreData
//
//  Created by Andriy Bas on 3/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Parent.h"

@class Student;

@interface University : Parent

@property (nonatomic, retain) NSSet *students;
@end

@interface University (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
