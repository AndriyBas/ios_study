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
#import "LoginViewController.h"
#import "AccessToken.h"

@interface ServerManager()

@property(strong, nonatomic) AFHTTPRequestOperationManager* manager;
@property(strong, nonatomic) AccessToken* accessToken;

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

// Application ID:	4883725


- (void) authorizeUser:(void(^)(User* user)) completion {
 
    LoginViewController* loginController = [[LoginViewController alloc] initWithCompletionBlock:^(AccessToken *accessToken) {
        if(completion) {
            if(accessToken) {
                self.accessToken = accessToken;
            
                [self getUser:accessToken.userID onSuccess:^(User *user) {
                        completion(user);
                } onFailure:^(NSError *error, NSInteger statusCode) {
                        completion(nil);
                }];
            } else {
                completion(nil);
            }
        }
    
        NSLog(@"AccessToken : %@, userID : %@, expiresIn : %@", self.accessToken.token, self.accessToken.userID, self.accessToken.expirationDate);
    
    }];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    UIViewController* rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    [rootViewController presentViewController:navigationController animated:YES completion:nil];
}

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(User* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @[userID], @"user_ids",
                            @[@"photo_50", @"sex", @"online", @"city", @"domain"], @"fields",
                            @"ins", @"name_case",
                            nil];
    [self.manager GET:@"users.get"
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"response : %@", responseObject);
                  NSArray* array = [responseObject objectForKey:@"response"];
                  User* user = [[User alloc] initWithResponse:[array firstObject]];
                  if(success) {
                      success(user);
                  }
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  if(failure) {
                      failure(error, operation.response.statusCode);
                  }
              }];
    
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
