//
//  Patient.h
//  Test3
//
//  Created by Andriy Bas on 12/29/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Patient <NSObject>

@required

@property (strong, nonatomic) NSString* name;
- (BOOL) areYouOK;
- (void) takePill;
- (void) makeShot;

@optional
- (void) howIsYourFamily;

@end
