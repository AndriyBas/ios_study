//
//  Boxer.h
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Boxer : NSObject<NSCopying>

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) int age;
@property (assign, nonatomic, getter=getHeight, setter=setOloloHeight:) float height;
@property (assign, nonatomic) float weight;

- (int) howOldAreYou;

- (int) getNameCount;

@end
