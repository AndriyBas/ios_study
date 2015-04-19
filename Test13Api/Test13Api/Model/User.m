//
//  User.m
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString*) description {
    return [NSString stringWithFormat:@"User : %@ %@(%@), userId : %@", self.firstName, self.lastName, self.domain, self.userID];
}

- (instancetype) initWithResponse:(id) responseObject {

    self.userID =[responseObject objectForKey:@"uid"];
    self.firstName  = [responseObject objectForKey:@"first_name"];
    self.lastName = [responseObject objectForKey:@"last_name"];
    self.domain = [responseObject objectForKey:@"domain"];
    self.imageURL =  [NSURL URLWithString: [responseObject objectForKey:@"photo_50"]];
    self.online = [[responseObject objectForKey:@"online"] integerValue] == 1;
    
    return self;
}

@end
