//
//  main.m
//  CommandLineTool1
//
//  Created by Andriy Bas on 1/4/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"


int globalVar = 10;

enum flag {up=1, down, right=7, left};

enum flag f1, f2;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        bool b1;
        _Bool b2;
        BOOL b3;
        
        unsigned int a = 0xA0A0A0A0;
        unsigned int b = 0xFFFF0000;
        unsigned int c = 0x00007777;
        
        int i1 = -300099990;
        
        int r = i1 >> 1;
        
        NSLog(@"%x, %x, %x, %x", a | b, a & b, a ^ b, ~a);
        NSLog(@"%x -> %x", i1, r);
        
        
        f1 = left;
        f2 = (enum flag)3;
        
         NSLog(@"globalVar = %d", globalVar);
        
        Student* s = [[Student alloc]init];
        [[Student alloc]init];
        [[Student alloc]init];
        
        [s setGlobalVar:15];
        
        NSLog(@"count = %d", [Student getCount]);
        
        NSLog(@"globalVar = %d", globalVar);
    }
    return 0;
}
