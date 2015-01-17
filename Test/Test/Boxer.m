//
//  Boxer.m
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "Boxer.h"

@interface Boxer ()
@property (assign, nonatomic) int nameCount;
@end

@implementation Boxer

@synthesize name = _name;

-(instancetype)init {
    NSLog(@"Boxer created");
    self = [super init];
    if(self) {
        self.nameCount = 3;
        self.name = @"Default name";
        self.age = 1;
        self.height = 0.52F;
        self.weight = 5.0F;
    }
    return self;
}

- (void) setName:(NSString *)name1 {
    _name = name1;
//    _name = name1; // OMG, what an ugly code, ugly style
    NSLog(@"setter setName:name is called");
}

- (NSString*) name {
    
    self.nameCount++;
    
    NSLog(@"nameCoutn increased");
    
    NSLog(@"name getter is called");
    
    return _name;
}


- (int) age {
    NSLog(@"age getter is called");
    return _age;
    
}

- (int) howOldAreYou {
    return _age;
}

- (int) getNameCount {
    return _nameCount;
}


- (void)dealloc
{
    NSLog(@"Boxer dealloc");
}

- (id)copyWithZone:(NSZone *)zone {
    NSLog(@"Boxer copy with zone");
    return [[Boxer alloc] init];
}

@end
