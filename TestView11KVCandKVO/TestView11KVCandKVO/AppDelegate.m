//
//  AppDelegate.m
//  TestView11KVCandKVO
//
//  Created by Andriy Bas on 3/1/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Group.h"

@interface AppDelegate ()

@property(strong, nonatomic) Student* student;
@property(strong, nonatomic) Group* group;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    Student* s = [[Student alloc] init];
    
    
    [s addObserver:self
                   forKeyPath:@"name"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    

    s.name = @"Vasya";
    s.age = 20;
    
    [s setValue:@"Alex" forKey:@"name"];
    [s setValue:@25 forKey:@"age"];
    
    
    Student* s2 = [[Student alloc] init];
    s2.name = @"Vova";
    s2.age = 20;
    
    Student* s3 = [[Student alloc] init];
    s3.name = @"Mika";
    s3.age = 23;
    
    Student* s4 = [[Student alloc] init];
    s4.name = @"Lesya";
    s4.age = 16;
    
    Student* s5 = [[Student alloc] init];
    s5.name = @"Julia";
    s5.age = 21;
    
    NSArray* array = @[s2, s3, s4, s5];
    
    Group* g = [[Group alloc] init];
    g.students = array;
    
    [g addObserver:self
        forKeyPath:@"students"
           options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
           context:NULL];
    
    NSMutableArray* arr = [g mutableArrayValueForKey:@"students"];
    [arr removeLastObject];
    
    self.group = g;
    self.student = s;
    // ahahaahahahahhaha
//    self.self.self.self.self.self.self.self.self.student.self.self.self.self.self.name = @"Alex";
//    self.student.name = @"Wow";
    
    NSLog(@"student : %@", s);
    
    NSLog(@"%@", [g.students valueForKeyPath:@"@count"]);
    
    NSLog(@"%@", [g.students valueForKeyPath:@"@sum.age"]);
    
    NSLog(@"%@", [g.students valueForKeyPath:@"@avg.age"]);
    
    NSLog(@"%@", [g.students valueForKeyPath:@"@max.age"]);
    
    NSLog(@"%@", [g valueForKeyPath:@"students.@min.age"]);
    
//    NSLog(@"%@", [g.students valueForKeyPath:@"[collect].name"]);
    
    
    NSString* newName = @"Lol123";
    NSError* error = nil;
    
    if(![s validateValue:&newName forKey:@"name" error:&error]) {
        NSLog(@"%@", error);
    }
    
    return YES;
}

- (void) dealloc {
    [self.student removeObserver:self forKeyPath:@"name"];
    [self.group removeObserver:self forKeyPath:@"students"];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"\nobserveForKeyPath:%@,\n\tofObject:%@,\n\tchange:%@,\n\tcontext:%@\n", keyPath, object, change, context);
    
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
