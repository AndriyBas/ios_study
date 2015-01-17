//
//  Student.m
//  TestThread
//
//  Created by Andriy Bas on 1/12/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)init {
    self = [super init];
    if(self) {
        self.age = 47;
    }
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Student : %ld", self.age];
}

@end
