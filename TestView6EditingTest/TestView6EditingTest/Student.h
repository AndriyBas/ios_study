//
//  Student.h
//  TestView6EditingTest
//
//  Created by Andriy Bas on 2/7/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+ (Student*) randomStudent;

@end
