//
//  Student.m
//  TestView6EditingTest
//
//  Created by Andriy Bas on 2/7/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student

static NSString* names[] = {
                          @"Winston Kim",
                          @"Nichole Rose",
                          @"Freddie Goodwin",
                          @"Grady Howell",
                          @"Rex Stokes",
                          @"Sara Hodges",
                          @"Simon Lyons",
                          @"Cheryl Weaver",
                          @"Joseph Cunningham",
                          @"Karen Hart"
};

static int namesCount = 10;

+ (Student*) randomStudent {
    Student* student = [[Student alloc] init];
    
    NSString* fullName = names[arc4random() % namesCount];
    NSArray* aa = [fullName componentsSeparatedByString:@" "];
    
    student.firstName = [aa objectAtIndex:0];
    student.lastName = [aa objectAtIndex:1];
    
    student.averageGrade = ((CGFloat)(arc4random() % 3000 + 2001)) / 1000.0F;
    
    return student;
}

@end
