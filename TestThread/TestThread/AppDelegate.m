//
//  AppDelegate.m
//  TestThread
//
//  Created by Andriy Bas on 1/2/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "TestObject.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray* array;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
  
//    [self test47];
//    [self testString];
//    [self testString2];
//    [self test11];
//    [self test22];
//    [self testDate];
    [self testThatTimer];
    
    return YES;
}


- (void) testThatTimer {
    TestObject* testObject = [[TestObject alloc] init];
}



- (void) testDate {
    
    
    NSDate* date = [NSDate date];
    NSDate* d2 = [date dateByAddingTimeInterval:118664000];
    NSDate* d3 = [NSDate dateWithTimeIntervalSince1970:191734];
    
    NSComparisonResult comparisonResult = [date compare:d2];
    NSLog(@"%ld", comparisonResult);
    
    NSLog(@"%@", d2);
    NSLog(@"%@", d3);
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
//    [dateFormatter setDateFormat:@"yyyy/M MM MMM MMMM MMMMM/dd EEE EEEE EEEEE / HH:mm:ss:SSSS W w"];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSLog(@"%@", [dateFormatter stringFromDate:d2]);
    
    NSDate* d4 = [dateFormatter dateFromString:@"2014/02/28 12:16:03"];
    NSDate* d5 = [dateFormatter dateFromString:@"2015/07/3 14:47:55"];
    
    NSCalendar* callendar = [NSCalendar currentCalendar];
    
    NSDateComponents* dateComponents = [callendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:d4];
    
    NSDateComponents* dateComponentsInterval = [callendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                            fromDate:d4
                                                            toDate:d5
                                                            options:0];
    
    NSLog(@"%@", d4);
    NSLog(@"%@", dateComponents);
    NSLog(@"%@", dateComponentsInterval);
    
    
}



- (void) test22 {
    NSString* s = @"Tais is a test String";
    NSMutableString* ms = [NSMutableString stringWithString:s];
    
    [ms replaceOccurrencesOfString:@"i" withString:@"$" options:0 range:NSMakeRange(0, [s length])];
    
    NSRange range = [ms rangeOfString:@"$"];
    while(range.location != NSNotFound) {
        [ms replaceCharactersInRange:range withString:@"I"];
        range = [ms rangeOfString:@"$"];
    }
    
    unichar c = [s  characterAtIndex:1];
    NSLog(@"%c", c);
    
    
    NSLog(@"%@", ms);
    
    
}

// n - not enclusive
- (NSArray*) prime:(NSInteger) n {
    BOOL p[n];
    
    for(int i = 0; i < n; i++)
        p[i] = YES;
    
    for(int i = 2; i < n; i++) {
        for(int j = i * 2; j < n; j += i)
            p[j] = NO;
    }
    
    NSInteger primeCount = 0;
    for(int i = 2; i < n; i++)
        if(p[i]) primeCount++;
    
    NSNumber* res[primeCount];
    int j = 0;
    for(int i = 2; i < n; i++)
        if(p[i])
            res[j++] = [NSNumber numberWithInteger:i];
    
    NSArray* arr = [NSArray arrayWithObjects:res count:primeCount];
    
    return arr;
}

- (void) test11 {
    Student* s = [[Student alloc] init];
    NSLog(@"sizeof Student == %lu", sizeof (s));
    
    NSArray* arr = [self prime:100];
    NSLog(@"prime count = %ld", arr.count);
    
    for(int i = 0; i < arr.count; i++) {
        NSNumber* num = (NSNumber*)[arr objectAtIndex:i];
        NSLog(@"%ld", [num integerValue]);
    }
    
    NSNumber* num = [NSNumber numberWithDouble:12.4];
    NSLog(@"%f", [num doubleValue]);
    
    NSLog(@"%@", s);
    
    
}

- (void) copyStr:(const char*)from to: (char*) to {
    for(; *from != '\0'; ++from, ++to) {
        *to = *from;
    }
    *to = '\0';
}
struct  ss_struct {
    int a;
    BOOL b;
    BOOL b2;
    double d;
};

typedef  struct ss_struct ss;

- (void) testString2 {
    
    char* s1 = "Test string.";
    
    char* s2 = malloc(sizeof(char) * strlen(s1));
    [self copyStr:s1 to:s2];

    char* s3 = "hi super test";
    
    [self copyStr:s3 to:s2];
    
    [self copyStr:"wow string" to:s2];
    
    int arr[10];
    NSLog(@"s1 == %s\ns2 == %s", s1, s2);
    NSLog(@"size* == %lu", sizeof(*s1));
    
    ss x = (ss) {.a = 10};
    
    NSLog(@"size of ss == %lu", sizeof(x));
    
//    char s2[] = "Rest";
    
//    char s3[10];
//    s3 = "223";
    
    
}

- (void) testString {
    
//    NSRange searchRange = NSMakeRange(0, [text length]);
    NSRange searchRange = NSRangeFromString([NSString stringWithFormat:@"{%d, %ld}", 0, [text length]]);


    NSInteger counter = 0;
    while (YES) {
        
        NSRange range = [text rangeOfString:@"class" options:0 range:searchRange];
        
        if(range.location != NSNotFound) {
            
            NSInteger index = range.location + range.length;
            
            searchRange.location = index;
            searchRange.length = [text length] - index;
            
            NSLog(@"%@", NSStringFromRange(range));
            
            counter++;
        } else {
            break;
        }
    }
    
    NSString* rText = [text stringByReplacingOccurrencesOfString:@"class" withString:@"big cock" options:0 range:NSMakeRange(0, [text length])];
    
//    rText = [rText uppercaseString];
    
    NSArray* array = [rText componentsSeparatedByString:@" "];
    
//    for(NSString* s in array) {
//        NSLog(@"%@", s);
//    }
    
    NSString* s1 = @"fuck";
    NSString* s2 = @"you";
    NSString* s3 = [NSString stringWithFormat:@"%@ %@", s1, s2];
    
    NSLog(@"%@", s3);
    
    NSLog(@"%@", [array componentsJoinedByString:@"__"]);
    
    NSLog(@"counter = %ld", counter);
    
}




int t = 1;
extern int rr;

- (void) test47 {
    
    id t = [NSString stringWithFormat:@"wow"];
    
    BOOL b = [NSString isSubclassOfClass:[AppDelegate class]];
    NSLog(@"%d", b);
    
    NSArray* arrayVal = [arrayVal initWithContentsOfFile:@"wow.txt"];
    
    for(id x in arrayVal) {
        NSLog(@"%@", x);
    }
    
    id val = arrayVal;
    
    @try {
        [val characterAtIndex:1];
    }
    @catch (NSException* ex) {
        NSLog(@"exception cought : %@, with reason : %@", ex.name, ex.reason);
    }
    @finally {
        NSLog(@"finally");
    }
    
}

- (void) testMultiTh {
    NSLog(@"wow");
    //    [self performSelectorInBackground:@selector(testThread) withObject:nil];
    
    //    for(int i = 0; i < 10; i++) {
    //        NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
    //        [thread setName:[NSString stringWithFormat:@"Thread # %d", i]];
    //        [thread start];
    //    }
    
    self.array = [[NSMutableArray alloc] init];
    
    NSThread* threadX = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadXY:) object:@"x"];
    [threadX setName:[NSString stringWithFormat:@"Thread # X"]];
    //            [threadX start];
    
    NSThread* threadY = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadXY:) object:@"0"];
    [threadY setName:[NSString stringWithFormat:@"Thread # Y"]];
    //            [threadY start];
    
    id test = [NSString stringWithFormat:@"wow"];
    
    [test characterAtIndex:0];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^{
    //
    //        NSString* threadName = [[NSThread currentThread] name];
    //
    //        CFTimeInterval startTime = CACurrentMediaTime();
    //        NSLog(@"Thread %@ started at : %f", threadName, startTime);
    //
    //        for(int i = 0; i < 20000000; i++) {
    //            i++;
    //            i--;
    //            //            NSLog(@"%@ : %d", threadName , i);
    //        }
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            NSLog(@"Thread %@ finished in : %f", threadName, CACurrentMediaTime() - startTime);
    //        });
    //
    //    });
    
    dispatch_async(queue, ^{
        [self testThreadXY:@"x"];
    });
    
    dispatch_async(queue, ^{
        [self testThreadXY:@"o"];
    });
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:2];
    
}

- (void) testThread {
    
    @autoreleasepool {
        
        NSString* threadName = [[NSThread currentThread] name];
        
        CFTimeInterval startTime = CACurrentMediaTime();
        NSLog(@"Thread %@ started at : %f", threadName, startTime);

        for(int i = 0; i < 20000000; i++) {
            i++;
            i--;
//            NSLog(@"%@ : %d", threadName , i);
        }
        
        NSLog(@"Thread %@ finished in : %f", threadName, CACurrentMediaTime() - startTime);
    }
}

- (void) testThreadXY:(NSString*) strVal {
    
    @autoreleasepool {
        
        @synchronized(self) {
            NSString* threadName = [[NSThread currentThread] name];
        
            CFTimeInterval startTime = CACurrentMediaTime();
            NSLog(@"Thread %@ started at : %f", threadName, startTime);
        
            for(int i = 0; i < 200000; i++) {
                [self.array  addObject:strVal];
                //            NSLog(@"%@ : %d", threadName , i);
            }
            
        
            NSLog(@"Thread %@ finished in : %f", threadName, CACurrentMediaTime() - startTime);
        }
    }
}

- (void) printArray {
    NSLog(@"%@", self.array);
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

NSString* text = @"A class describes the behavior and properties common to any particular type of object. In the same way that multiple buildings constructed from the same blueprint are identical in structure, every instance of a class shares the same properties and behavior as all other instances of that class. You can write your own classes or use framework classes that have been defined for you. You make an object by creating an instance of a particular class. You do this by allocating the object and initializing it with acceptable default values. When you allocate an object, you set aside enough memory for the object and set all instance variables to zero. Initialization sets an object’s initial state—that is, its instance variables and properties—to reasonable values and then returns the object. The purpose of initialization is to return a usable object. You need to both allocate and initialize an object to be able to use it. A fundamental concept in Objective-C programming is class inheritance, the idea that a class inherits behaviors from a parent class. When one class inherits from another, the child—or subclass—inherits all the behavior and properties defined by the parent. The subclass can define its own additional behavior and properties or override the behavior of the parent. Thus you can extend the behaviors of a class without duplicating its existing behavior.";

@end
