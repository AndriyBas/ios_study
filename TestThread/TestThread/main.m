//
//  main.m
//  TestThread
//
//  Created by Andriy Bas on 1/2/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int func(int i) {
    int j = i + 1;
    NSLog(@"j = %d", j);
    return j;
}

void perform(int (*f)(int), int param) {
    f(param);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int (*fn) (int) = func;
        
        perform(fn, 10);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
