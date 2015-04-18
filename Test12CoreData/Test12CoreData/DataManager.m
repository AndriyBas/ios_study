//
//  DataManager.m
//  Test12CoreData
//
//  Created by Andriy Bas on 4/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "DataManager.h"
#import "NSString+RandomString.h"
#import "ASStudent.h"
#import "ASCar.h"
#import "ASUniversity.h"
#import "ASCourse.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static NSString* carModelNames[] = {
    @"Dodge", @"Toyota", @"BMW", @"Lada", @"Volga"
};

static NSString* courseNames[] = {
    @"Android", @"iOS", @"OOP",
    @"Javascript", @"PHP", @"HTML",
    @"Math", @"Philosophy", @"Economy",
    @"Culture", @"Literature", @"Misic"
};

@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataManager*) sharedManager {
    static DataManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    
    return instance;
}


- (ASStudent*) addRandomStudent {
    
    ASStudent* student =
    [NSEntityDescription insertNewObjectForEntityForName:@"ASStudent"
                                  inManagedObjectContext:self.managedObjectContext];
    
    student.score = @((float)arc4random_uniform(201) / 100.f + 2.f);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    
    return student;
}

- (ASCar*) addRandomCar {
    
    ASCar* car =
    [NSEntityDescription insertNewObjectForEntityForName:@"ASCar"
                                  inManagedObjectContext:self.managedObjectContext];
    car.model = carModelNames[arc4random_uniform(5)];
    
    return car;
}

- (ASUniversity*) addUniversity:(NSString*) name {
    
    ASUniversity* university =
    [NSEntityDescription insertNewObjectForEntityForName:@"ASUniversity"
                                  inManagedObjectContext:self.managedObjectContext];
    university.name = name;;
    
    return university;
}

- (ASCourse*) addCourseWithName:(NSString*) name {
    
    ASCourse* course =
    [NSEntityDescription insertNewObjectForEntityForName:@"ASCourse"
                                  inManagedObjectContext:self.managedObjectContext];
    
    course.name = name;
    
    return course;
}


- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ASObject"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
//    [request setFetchBatchSize:20];
    
//    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//    NSSortDescriptor* desc2 = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
//    
//    [request setSortDescriptors:@[descriptor, desc2]];
//    [request setRelationshipKeyPathsForPrefetching:@[@"courses"]];
//    
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"score > %f AND score <= %f && courses.@count >= %d", 3.0F, 4.5F, 3];
//    
//    [request setPredicate:predicate];
//    
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printArray:(NSArray*) array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[ASCar class]]) {
            
            ASCar* car = (ASCar*) object;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
            
        } else if ([object isKindOfClass:[ASStudent class]]) {
            
            ASStudent* student = (ASStudent*) object;
            NSLog(@"STUDENT: %@ %@, SCORE: %1.2f, COURSES: %lu",
                  student.firstName, student.lastName,
                  [student.score floatValue], [student.courses count]);
            
        } else if ([object isKindOfClass:[ASUniversity class]]) {
            
            ASUniversity* university = (ASUniversity*) object;
            NSLog(@"UNIVERSITY: %@ Students: %lu", university.name, [university.students count]);
            
        } else if ([object isKindOfClass:[ASCourse class]]) {
            
            ASCourse* course = (ASCourse*) object;
            NSLog(@"COURSE: %@ Students: %lu", course.name, [course.students count]);
        }
        
        //NSLog(@"%@", object);
    }
    
    NSLog(@"COUNT = %lu", [array count]);
}

- (void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    [self printArray:allObjects];
}

- (void) deleteAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}

- (void) deleteAll {
    [self deleteAllObjects];
}

- (void) generateUniversity:(NSString*) name {
     
    NSError* error = nil;
    
    NSMutableSet* newCourses = [NSMutableSet set];
    for(int i = 0; i < 5 + arc4random_uniform(6); i++) {
        [newCourses addObject:courseNames[arc4random_uniform(12)]];
    }
    
    NSMutableArray* courses = [NSMutableArray array];
    for(NSString* n in newCourses) {
        [courses addObject:[self addCourseWithName:n]];
    }
         
    ASUniversity* university = [self addUniversity:name];
     
     [university addCourses:[NSSet setWithArray:courses]];
    
     int studentsCount = 200 + arc4random_uniform(500);
     for (int i = 0; i < studentsCount; i++) {
     
         ASStudent* student = [self addRandomStudent];
     
         if (arc4random_uniform(1000) < 600) {
             ASCar* car = [self addRandomCar];
             student.car = car;
         }
     
         student.university = university;
     
         NSInteger number = arc4random_uniform((int)([courses count] - 1)) + 1;
     
         while ([student.courses count] < number) {
             ASCourse* course = [courses objectAtIndex:arc4random_uniform((int)[courses count])];
             if (![student.courses containsObject:course]) {
                 [student addCoursesObject:course];
             }
         }
     }
     
     if (![self.managedObjectContext save:&error]) {
         NSLog(@"%@", [error localizedDescription]);
     }
     
     //[self deleteAllObjects];
     
     //[self printAllObjects];
    
    
    /*
     NSFetchRequest* request = [[NSFetchRequest alloc] init];
     
     NSEntityDescription* description =
     [NSEntityDescription entityForName:@"ASCourse"
     inManagedObjectContext:self.managedObjectContext];
     
     [request setEntity:description];
     */
    //[request setRelationshipKeyPathsForPrefetching:@[@"courses"]];
    
    /*
     NSSortDescriptor* firstNameDescriptor =
     [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     
     NSSortDescriptor* lastNameDescriptor =
     [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
     */
    
    /*
     NSSortDescriptor* nameDescriptor =
     [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     
     [request setSortDescriptors:@[nameDescriptor]];
     */
    //NSArray* validNames = @[@"Clyde", @"Pam", @"Rosanna"];
    
    /*
     NSPredicate* predicate =
     [NSPredicate predicateWithFormat:
     @"score > %f AND score <= %f AND "
     "courses.@count >= %d AND "
     "firstName IN %@", 3.0, 3.5, 3, validNames];
     */
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:@"@max.students.score > %f", 3.9];
    
    /*
     NSPredicate* predicate =
     [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 6];
     
     [request setPredicate:predicate];
     */
    
    /*
     [request setFetchBatchSize:20];
     
     NSError* requestError = nil;
     NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
     
     [self printArray:resultArray];
     */
    
    /*
     NSFetchRequest* request = [[self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"] copy];
     
     NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:nil];
     
     NSSortDescriptor* firstNameDescriptor =
     [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     
     NSSortDescriptor* lastNameDescriptor =
     [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];z
     [self printArray:resultArray];
     */
    
    //    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    //
    //    NSEntityDescription* description =
    //    [NSEntityDescription entityForName:@"ASCourse"
    //                inManagedObjectContext:self.managedObjectContext];
    //
    //    [request setEntity:description];
    //
    //    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    //
    //    for (ASCourse* course in resultArray) {
    //        NSLog(@"COURSE NAME = %@", course.name);
    //        NSLog(@"BEST STUDENTS:");
    //        [self printArray:course.bestStudents];
    //        NSLog(@"BUZY STUDENTS:");
    //        [self printArray:course.studentsWithManyCourses];
    //    }
    //
//    [self testRequest];
    
}

- (void) testRequest {
    
    
    //    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    //    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASCourse" inManagedObjectContext:self.managedObjectContext];
    //    [request setEntity:description];
    
    //    [request setFetchBatchSize:20];
    
    //    [request setRelationshipKeyPathsForPrefetching:@[@"ASStudent"]];
    
    //    NSSortDescriptor* sort1 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    //    NSSortDescriptor* sort2 = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    //    [request setSortDescriptors:@[sort1, sort2]];
    
    
    
    //    NSArray* validNames = @[@"Brent", @"Sha", @"Norbert"];
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:
    //                              @"score > %f"
    //                               " AND score <= %f"
    //                               " AND courses.@count >= %d"
    //                               " AND firstName IN %@", 3.0, 3.5, 3, validNames];
    //
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"@avg.students.score >= %f", 3.1];
    
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 6];
    
    //    [request setPredicate:predicate];
    
    NSFetchRequest* templateRequest = [self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"];
    
    NSError* error = nil;
    NSArray* res = [self.managedObjectContext executeFetchRequest:templateRequest error:&error];
    if(error) {
        NSLog(@"%@",[error localizedDescription]);
    } else {
        [self printArray:res];
        [self printArray:res];
    }
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
