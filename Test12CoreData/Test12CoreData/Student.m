//
//  Student.m
//  Test12CoreData
//
//  Created by Andriy Bas on 3/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Student.h"


@implementation Student

@dynamic firstName;
@dynamic lastName;
@dynamic dateOfBirth;
@dynamic score;


- (void) setFirstName:(NSString *)firstName {
    
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
    
    NSLog(@"SET FIRST NAME !!!");
}

- (NSString*) getFirstName {
    
    NSLog(@"GET FIRST NAME !!!");
    
    NSString* s = nil;
    [self willAccessValueForKey:@"firstName"];
    s = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    
    return s;
}

@end
