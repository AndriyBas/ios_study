//
//  AppDelegate.m
//  TestDelegate
//
//  Created by Andriy Bas on 12/31/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreGraphics/CoreGraphics.h>
#import "Patient.h"
#import "Doctor.h"
#import "Government.h"
#import "Mommy.h"

typedef NSString* (^TestBlockType)(NSString*, NSInteger);

@interface AppDelegate ()

@property (strong, nonatomic) Government* government;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    SEL selector1 = @selector(test2:);
//    [self performSelector:selector1 withObject:[NSNumber numberWithFloat:15.5F]];
    
//    SEL selector2 = @selector(testMethod:param2:);
//    [self performSelector:selector2 withObject:@"o1" withObject:@"o2"];
//    [self test2];
    
//    [self test5];
   
    [self test6];
    
    return YES;
}



- (void) test6 {
    TestBlockType testBlock;
    
    __block NSInteger i = 0;
    
    testBlock = ^(NSString* strVal, NSInteger intVal) {
        NSString* str = [NSString stringWithFormat:@"test Block : %@, %ld", strVal, intVal];
        NSLog(str);
        i++;
        NSLog(@"%ld", i);
        
        void (^innerBlock)(void) = ^{
            NSLog(@"inner block");
        };
        
        innerBlock();
        
        return str;
    };
    
    testBlock(@"test", 1);
    testBlock(@"test", 4);
    testBlock(@"test", 7);
    
    NSComparisonResult (^bbb)(id, id) = ^(id onj1, id obj2) {
        return NSOrderedAscending;
    };
    
    [self methodWithBlock:testBlock];
}

- (void) methodWithBlock:(TestBlockType) myBlock {
    myBlock(@"qwerty", 47);
}

- (void) test5 {
    Mommy* m = [[Mommy alloc] init];
    
    SEL mommyHackSelector = @selector(superSecretText);
    NSString* text = [m performSelector:mommyHackSelector];
    NSLog(@"mommy says : %@", text);
    
    NSString* s = [self testMethodFuck:1 param2:12.3F param3:-9.3];
    NSLog(s);
    
    SEL selOMG = @selector(testMethodFuck:param2:param3:);
    
    NSMethodSignature* signature = [AppDelegate instanceMethodSignatureForSelector:selOMG];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selOMG];
    
    NSInteger iVal = 2;
    CGFloat fVal = 12.3F;
    double dVal = -9.3;
    
    [invocation setArgument:&iVal atIndex:2];
    [invocation setArgument:&fVal atIndex:3];
    [invocation setArgument:&dVal atIndex:4];
    
    [invocation invoke];
    
    NSLog(@"---------\n");
    __unsafe_unretained NSString* s1 = nil;
    [invocation getReturnValue:&s1];
    
    NSLog(s1);
}

- (void) testMethod:(NSString*) s1 param2:(NSString*) s2 {
    NSLog(@"testMethod: s1 = %@, s2 = %@", s1, s2);
}

- (NSString*) testMethodFuck:(NSInteger) intVal param2:(CGFloat) floatVal param3:(double) doubleVal {
    NSString* str = [NSString stringWithFormat:@"params : %ld %f %f", intVal, floatVal, doubleVal];
    
    return str;
}

- (void) test2:(NSNumber*) num {
    
    NSLog(@"%f", [num floatValue]);
    
    self.government = [[Government alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:GovernmentTaxLevelDidChangeNotification
                                                    object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name: GovernmentSalaryDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:GovernmentPensionDidChangeNotification
                                               object:nil];

    Mommy* mommy1 = [[Mommy alloc] init];
    Mommy* mommy2 = [[Mommy alloc] init];
    
    [mommy1 setName:@"Vira"];
    [mommy2 setName:@"Olya"];
    
    self.government.taxLevel = 5.5F;
    self.government.salary = 2100.1F;
    self.government.pension = 600.02F;

    
//    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
}

- (void) governmentNotification:(NSNotification*) notification {
    NSLog(@"governmentNotification userInfo= %@", notification.userInfo);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) test1 {
    Patient* patient1 = [Patient new];
    [patient1 setName:@"Vova"];
    [patient1 setTemperature:46.6];
    
    Patient* patient2 = [Patient new];
    [patient2 setName:@"Mykola"];
    [patient2 setTemperature:58.8];

    Doctor* doctor = [Doctor new];
    
    [patient1 setDelegate:doctor];
    [patient2 setDelegate:doctor];
    
    [patient1 howAreYou];
    [patient2 howAreYou];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
