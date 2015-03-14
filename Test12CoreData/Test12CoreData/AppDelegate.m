//
//  AppDelegate.m
//  Test12CoreData
//
//  Created by Andriy Bas on 3/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+RandomString.h"
#import "Student.h"
#import "Car.h"
#import "University.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //NSLog(@"%@", [self.managedObjectModel entitiesByName]);
    
    
    /*
     NSManagedObject* student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                             inManagedObjectContext:self.managedObjectContext];
    
    [student setValue:@"Andriy" forKey:@"firstName"];
    [student setValue:@"Bas" forKey:@"lastName"];
    [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:110000] forKey:@"dateOfBirth"];
    [student setValue:@4.0 forKey:@"score"];
    
    NSError* error1;
    if(![self.managedObjectContext save:&error1]) {
        NSLog(@"not saved, error : %@", [error1 localizedDescription]);
    }
    */
    
    Student* s1 = [self addRandomStudent];
    Student* s2 = [self addRandomStudent];
    
    University* u = [self addUniversity];
    
    s1.university = u;
    s2.university = u;
//    [u addStudents:[NSSet setWithObjects:s1, s2, nil]];
    
    [self printAllObjects];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDescr = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entityDescr];
    
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:nil];
    for(NSManagedObject* s in arr) {
//        [self.managedObjectContext deleteObject:s];
    }
    
    [self.managedObjectContext save:nil];
    
    [self printAllObjects];
    
    [self deleteAllObjects];

    return YES;
}

- (Student*) addRandomStudent {
    
    Student* s = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    
    s.firstName = [NSString randomAlphaNumericString];
    s.lastName = [NSString randomAlphaNumericString];
    s.score = [NSNumber numberWithFloat:(float)(200 + arc4random() % 201) /100.0F];
    s.dateOfBirth = [NSDate dateWithTimeIntervalSinceReferenceDate:arc4random() % 10000];
    
    if(arc4random() % 2 == 0) {
        Car* car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
        car.model = [NSString randomAlphaNumericString];
        s.car = car;
    }
    
    NSError* error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"error saving student : %@", [error localizedDescription]);
        return nil;
    }
    
    return s;
}

- (University*) addUniversity {
    University* u = [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    
    u.name = [NSString randomAlphaNumericString];
    
    [self.managedObjectContext save:nil];
    
    return u;
}

- (NSArray*) fetchAllObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Parent" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* error = nil;
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(nil != error) {
        NSLog(@"error fatching all objects, error : %@", [error localizedDescription]);
    }
    
    return arr;
}

- (void) printAllObjects {
    NSArray* arr = [self fetchAllObjects];

    NSLog(@"All objects :::");
    for(NSManagedObject* obj in arr) {
        NSLog(@"%@", obj);
    }
}

- (void) deleteAllObjects {
    NSArray* arr = [self fetchAllObjects];
    
    for(NSManagedObject* obj in arr) {
        [self.managedObjectContext deleteObject:obj];
    }
    
    [self.managedObjectContext save:nil];
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
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Oyster.Test12CoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Test12CoreData" withExtension:@"momd"];
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
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Test12CoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
       
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
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
