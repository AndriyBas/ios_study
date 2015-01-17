//
//  Student.h
//  Test
//
//  Created by Andriy Bas on 12/28/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Male,
    Female,
    Unfdefined
} Gender;


typedef int Taburetka;

@interface Student : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) Gender gender;

@end
