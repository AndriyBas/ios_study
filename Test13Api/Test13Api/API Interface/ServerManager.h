//
//  ServerManager.h
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (ServerManager*) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friendsArray)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end

