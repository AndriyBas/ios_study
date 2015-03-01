//
//  Student.h
//  TestView11KVCandKVO
//
//  Created by Andriy Bas on 3/1/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property(strong, nonatomic) NSString* name;
@property(assign, nonatomic) NSInteger age;

- (NSString*) description;

@end
