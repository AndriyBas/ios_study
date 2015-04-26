//
//  VKPost.m
//  Test13Api
//
//  Created by Andriy Bas on 4/25/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "VKPost.h"

@implementation VKPost


- (id) initWithResponse:(NSDictionary*) response {
    
    self = [super init];
    if(self) {
        self.text = [response objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    }
    return self;
}

@end
