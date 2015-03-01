//
//  ViewController.h
//  TestView10WebView
//
//  Created by Andriy Bas on 3/1/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIWebView* webView;

@property(weak, nonatomic) IBOutlet UIBarButtonItem* nextBatButton;
@property(weak, nonatomic) IBOutlet UIBarButtonItem* previousBarButton;

@property(weak, nonatomic) IBOutlet UIActivityIndicatorView* indicatorView;

- (IBAction) actionNext:(UIBarButtonItem*) sender;
- (IBAction) actionBack:(UIBarButtonItem*) sender;
- (IBAction) actionRefresh:(UIBarButtonItem*) sender;

@end

