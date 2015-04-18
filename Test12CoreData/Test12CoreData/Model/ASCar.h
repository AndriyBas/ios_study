//
//  ASCar.h
//  Test12CoreData
//
//  Created by Andriy Bas on 4/16/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASStudent;

@interface ASCar : ASObject

@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) ASStudent *owner;

@end
