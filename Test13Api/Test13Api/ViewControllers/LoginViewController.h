//
//  LoginViewController.h
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessToken;

typedef void(^LoginCompletionBlock)(AccessToken* accessToken);

@interface LoginViewController : UIViewController

- (instancetype)  initWithCompletionBlock:(LoginCompletionBlock) completion;

@end
