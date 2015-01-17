//
//  Student.h
//  CommandLineTool1
//
//  Created by Andriy Bas on 1/4/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

- (void) sayHello;
- (void) setGlobalVar:(int) val;

+ (int) getCount;

@end
