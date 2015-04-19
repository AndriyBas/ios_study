//
//  ServerManager.m
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ServerManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "User.h"

@interface ServerManager()

@property(strong, nonatomic) AFHTTPRequestOperationManager* manager;

@end

@implementation ServerManager

+ (ServerManager*) sharedManager {
    
    static ServerManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServerManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.manager = [[AFHTTPRequestOperationManager manager] initWithBaseURL:url];
    }
    return self;
}

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friendsArray)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"18706959", @"user_id",
                            @"name", @"order",
                            @(count), @"count",
                            @(offset), @"offset",
                            @[@"photo_50", @"sex", @"online", @"city", @"domain"], @"fields",
                            @"ins", @"name_case",
                            nil];
    
    [self.manager GET:@"friends.get"
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"response: %@", responseObject);
                  NSMutableArray* users = [NSMutableArray array];
                  NSArray* array = [responseObject objectForKey:@"response"];
                  for(id obj in array) {
                      [users addObject:[[User alloc] initWithResponse:obj]];
                  }
                  if(success) {
                      success(users);
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"error: %@", error);
                  if(failure) {
                      failure(error, operation.response.statusCode);
                  }
              }];
}

@end
