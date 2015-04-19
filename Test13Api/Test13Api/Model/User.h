//
//  User.h
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* domain;
@property (assign, nonatomic) BOOL online;

- (instancetype) initWithResponse:(id) responseObject;

@end
