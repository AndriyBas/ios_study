//
//  Car.h
//  Test12CoreData
//
//  Created by Andriy Bas on 3/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Parent.h"

@class Student;

@interface Car : Parent

@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) Student *owner;

@end
