//
//  LoginViewController.m
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "LoginViewController.h"
#import "AccessToken.h"


@interface LoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) LoginCompletionBlock completionBlock;
@property (weak, nonatomic) UIWebView* webView;

@end

@implementation LoginViewController

- (instancetype)  initWithCompletionBlock:(LoginCompletionBlock) completion {
    self = [super init];
    if(self) {
        self.completionBlock = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Login";
    
    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:rect];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.delegate = self;
    
    self.webView = webView;
    [self.view addSubview:webView];
    
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(onBarButtonCancelClick:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
    NSString* urlSting = @"https://oauth.vk.com/authorize?"
        "client_id=4883725&"
        "scope=139286&"
        "redirect_uri=hello.there&"
        "display=popup&"
        "v=5.30&"
        "response_type=token&"
        "revoke=1";
    
    NSURL* url = [NSURL URLWithString:urlSting];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
}

- (void) dealloc {
    self.webView.delegate = nil;
}

- (void) onBarButtonCancelClick:(UIBarButtonItem*) sender {
    
    if(self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@", request.URL);
    
    if([@"hello.there" isEqualToString:request.URL.host]) {
        AccessToken* accessToken = [[AccessToken alloc] initWithUrl:request.URL];
        if(accessToken && self.completionBlock) {
            self.completionBlock(accessToken);
        }
        [self onBarButtonCancelClick:nil];
        return NO;
    }
    
    return YES;
}

@end
