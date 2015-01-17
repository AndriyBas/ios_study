//
//  main.m
//  Console1
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <stdio.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int i = 11;
        NSString* s1 = @"wow";
        NSInteger nsi = 10;
        
        NSLog(@"i = %d, s1 = %@, nsi = %ld", i, s1, nsi);
        
        NSInteger a = 10;
        NSInteger b = 13;
        CGFloat c = a / b;

        printf("%f", c);
        
        Student* s = [[Student alloc] init];
        [s fuck:@"Maya" during:a withCondoms:YES];
        
        printf("\n");
        
        
//        Student* student = [[Student alloc] init];
//        [student setName:@"loser"];
        
//        NSLog(@"student name = %@", student.name);
        
    }
    return 0;
}
