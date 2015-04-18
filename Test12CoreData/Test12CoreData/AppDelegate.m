//
//  AppDelegate.m
//  Test12CoreData
//
//  Created by Andriy Bas on 3/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "UniversitiesViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    DataManager* dataManager = [DataManager sharedManager];
//    [dataManager deleteAll];
//    [dataManager generateUniversity:@"NTUU \"KPI\""];
//    [dataManager generateUniversity:@"NAU"];
//    [dataManager generateUniversity:@"ONPU"];
//    [dataManager generateUniversity:@"Tarasa Schevchenka"];
//    [dataManager generateUniversity:@"LNU \"Ivana Franka\""];
//    [dataManager generateUniversity:@"Lviv Politechnic Institute"];
    
    UniversitiesViewController* uvc = [[UniversitiesViewController alloc] init];
    
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:uvc];
    
    self.window.rootViewController = nc;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager sharedManager] saveContext];
}

@end