 //
//  AppDelegate.m
//  Test
//
//  Created by Andriy Bas on 12/27/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import "TestChild.h"
#import "Boxer.h"
#import "MyObject.h"
#import "ChildObject.h"
#import "Student.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [self testObj];
    
//    NSLog(@"boxer.name = %@", [self.b name]);
    
    
//    [self test2];
    
//    [self test3];
    
//    [self test4];

//    [self test5];
  
    [self testPoints];
    return YES;
    
}

- (void) testPoints {
    
    CGPoint point1 = CGPointMake(10, 20);
    CGPoint point2 = CGPointMake(1, 5);
    CGPoint point3 = CGPointMake(4, 7);
    CGPoint point4 = CGPointMake(8, 3);
    CGPoint point5 = CGPointMake(5, 6);
    
    NSArray* arr = [NSArray arrayWithObjects:
                    [NSValue valueWithCGPoint:point1],
                    [NSValue valueWithCGPoint:point2],
                    [NSValue valueWithCGPoint:point3],
                    [NSValue valueWithCGPoint:point4],
                    nil];
    
    for(NSValue* value in arr) {
        CGPoint point = [value CGPointValue];
        NSLog(@"point = %@", NSStringFromCGPoint(point));
    }
    
}

- (void) test5 {
    
    Student*  studentA = [[Student alloc] init];
    
    studentA.name = @"Mother Fucker";
    
    Student* studentB = studentA;
    
    studentB.name = @"Father fucker";
    
    NSLog(@"%@", studentA.name);
    
    studentA.gender = Male;
    
    [studentA setGender:Female];
    
    int a = 10;
    int* c = &a;
    
    *c = 20;
    
    [self f:a intPointer:c];
    
    NSLog(@"%d", a);
    
    CGPoint point = CGPointMake(1.2F, 3.3F);
    CGSize size = CGSizeMake(4.4F, 7.7F);
    CGRect rect;
    
    rect.origin = point;
    rect.size = size;
    
//    BOOL fire = CGRectContainsPoint(rect, point);
    
    BOOL fire = CGRectContainsPoint(rect, CGPointMake(-100.F, -190.F));
    
    NSLog(@"fire == %d", fire);
}

- (int) f:(int) intVal intPointer:(int*) intPointer {
    
    *intPointer = 77;
    
    return intVal;
}

- (void) test4 {
    
    BOOL b = false;
    
    NSInteger i = -10;
    
    NSUInteger ui = 100;
    
    CGFloat f = 1.3F;
    
    double d = 3.1415926F;
    
    
    NSNumber* boolNumber = [NSNumber numberWithBool:b];
    NSNumber* intNumber = [NSNumber numberWithInteger:i];
    NSNumber* unsignedIntNumber = [NSNumber numberWithUnsignedInteger:ui];
    NSNumber* floatNumber = [NSNumber numberWithFloat:f];
    NSNumber* doubleNumber = [NSNumber numberWithDouble:d];
    
    NSArray* arr = [NSArray arrayWithObjects:boolNumber, intNumber, unsignedIntNumber, floatNumber, doubleNumber, nil];
    
     NSLog(@"b = %d, i = %ld, ui = %lu, f = %f, d = %f",
           [[arr objectAtIndex:0] boolValue],
           [[arr objectAtIndex:1] integerValue],
           [[arr objectAtIndex:2] unsignedIntegerValue],
           [[arr objectAtIndex:3] floatValue],
           [[arr objectAtIndex:4] doubleValue]
           );
    
    for(NSNumber* num in arr) {
        NSLog(@"%@", [num stringValue]);
    }
    
    f = i;
    i = f;
    
    NSLog(@"b = %d, i = %ld, ui = %lu, f = %f, d = %f", b, i, ui, f, d);
    NSLog(@"b = %ld, i = %ld, ui = %ld, f = %ld, d = %ld", sizeof(BOOL), sizeof(int), sizeof(unsigned int), sizeof(float), sizeof(double));

}

- (void) test3 {
    ChildObject* obj1 = [[ChildObject alloc] init];
    MyObject* obj2 = [[MyObject alloc] init];
    ChildObject* obj3 = [[ChildObject alloc] init];
    
    obj1.name = @"obj 1";
    obj2.name = @"obj 2";
    [obj3 setName:@"obj 3"];
    
    NSArray* arr = [NSArray arrayWithObjects:obj1, obj2, obj3, nil];
    
    for(MyObject* obj in arr) {
        NSLog(@"name == %@", obj.name);
        [obj action];
        
        if([obj isKindOfClass:[ChildObject class]]) {
            ChildObject* childObject = (ChildObject*)obj; // casting
            NSLog(@"%@", [childObject lastName]);
        }
    }
    
}

- (void) test2 {

    NSArray* arr = [[NSArray alloc] initWithObjects:@"String 1", @"String 2", @"String 3", nil];
    
    for(int i = 0 ; i < arr.count; i++) {
        NSLog(@"arr[%d] = %@", i, [arr objectAtIndex:i]);
    }
    
    for(NSString* str in arr) {
        NSLog(@"%@", str);
    }
    
      
}

- (void) testObj {
    TestChild* util = [[TestChild alloc] init];
    
    [util log];
    
    NSLog(@"%@", [util getDate]);
    
    [util logGreeeting:@"Max" withMessage:@"You are awesom"];
    
    NSLog(@"%@", [util whoAreYou]);
    
    NSLog(@"%@", [TestChild whoAreYou]);
    
    // Boxer
    
    Boxer* boxer = [[Boxer alloc] init];
    
    
    //    [boxer setName:@"Vasiliy"];
    //    [boxer setAge:25];
    //    [boxer setHeight:1.8F];
    //    [boxer setWeight:80.0F];
    
    boxer.name = @"Vasili";
    boxer.age = 25;
//    boxer.height = 1.8F;
    [boxer setOloloHeight:1.8F];
    boxer.weight = 80.0F;
    
    NSLog(@"name = %@", boxer.name);
    NSLog(@"age = %d", boxer.age);
    NSLog(@"weight = %f", boxer.weight);
    NSLog(@"height = %f", boxer.height);
    
    for (int i = 0; i < 2; i++) {
        [boxer name];
    }
    
    NSLog(@"howOldAreYou : %d", [boxer howOldAreYou]);
    
    NSLog(@"nameCount = %d", [boxer getNameCount]);
    
    self.b = boxer;
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Oyster.Test" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Test" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Test.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
