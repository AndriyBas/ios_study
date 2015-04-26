//
//  ServerManager.h
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface ServerManager : NSObject

@property(strong, nonatomic) User* user;

+ (ServerManager*) sharedManager;

- (void) authorizeUser:(void(^)(User* user)) completion;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friendsArray)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getGroupWall:(NSString*) groupID
           withOffset:(NSInteger) offset
                count:(NSInteger) count
            onSuccess: (void(^)(NSArray* posts)) success
            onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postText:(NSString*) text
      onGroupWall:(NSString* ) groupID
        onSuccess: (void(^)(id response)) success
        onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;
@end

