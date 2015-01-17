
//
//  Government.m
//  TestDelegate
//
//  Created by Andriy Bas on 1/2/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Government.h"

NSString* const GovernmentTaxLevelDidChangeNotification = @"GovernmentTaxLevelDidChangeNotification";
NSString* const GovernmentSalaryDidChangeNotification = @"GovernmentSalaryDidCangeNotification";
NSString* const GovernmentPensionDidChangeNotification = @"GovernmentPensionDidChangeNotification";

NSString* const GovernmentTaxLevelUserInfoKey = @"GovernmentTaxLevelUserInfoKey";
NSString* const GovernmentSalaryUserInfoKey = @"GovernmentSalaryUserInfoKey";
NSString* const GovernmentPensionUserInfoKey = @"GovernmentPensionUserInfoKey";

@implementation Government

- (instancetype) init {
    self = [super init];
    if(self) {
        self.taxLevel = 5.0F;
        self.salary = 2000.0F;
        self.pension = 700.0F;

    }
    return self;
}

- (void) setTaxLevel:(CGFloat) taxLevel {
    _taxLevel = taxLevel;
    
//    NSDictionary* userInfoDictionary = @{GovernmentTaxLevelUserInfoKey: [NSNumber numberWithFloat: _taxLevel]};
    NSDictionary* userInfoDictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:_taxLevel] forKey:GovernmentTaxLevelUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentTaxLevelDidChangeNotification object:nil userInfo:userInfoDictionary];
}

- (void) setSalary:(CGFloat) salary {
    _salary = salary;
    
    NSDictionary* userInfoDictionary = @{GovernmentSalaryUserInfoKey: [NSNumber numberWithFloat:_salary]};
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentSalaryDidChangeNotification object:nil userInfo:userInfoDictionary];
}

- (void) setPension:(CGFloat) pension {
    _pension = pension;
    
    NSDictionary* userInfoDictionary = @{GovernmentPensionUserInfoKey: [NSNumber numberWithFloat:_pension]};
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentPensionDidChangeNotification object:nil userInfo:userInfoDictionary];
    
}


@end
