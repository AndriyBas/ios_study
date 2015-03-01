//
//  ViewController.m
//  TestView10WebView
//
//  Created by Andriy Bas on 3/1/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* urlString = @"http://www.habrahabr.ru";
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    
    NSString* myHtml =
    @"<html>"
        "<body>"
            "<p  style=\"font-size: 500%%; text-align: center;\">Hello!</p>"
            "<div>"
                "<a href=\"cmd:show\">Test</a>"
            "</div>"
        "</body>"
    "</html>";
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    [self.webView loadRequest:request];
//    [self.webView loadHTMLString:myHtml baseURL:nil];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) updateUI {

    self.nextBatButton.enabled = self.webView.canGoForward;
    self.previousBarButton.enabled = self.webView.canGoBack;
    
}


#pragma mark - Actions
- (IBAction) actionNext:(UIBarButtonItem*) sender {
    NSLog(@"next");
    
    if([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
    
}

- (IBAction) actionBack:(UIBarButtonItem*) sender {
    NSLog(@"back");
    
    if([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction) actionRefresh:(UIBarButtonItem*) sender {
    NSLog(@"refresh");
    
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString* urlStr = [request.URL absoluteString];
    
    if([urlStr hasPrefix:@"cmd"]) {
        
        NSString* command = [urlStr substringFromIndex:4];
        if([@"show" isEqualToString:command]) {
            
            [[[UIAlertView alloc]
             initWithTitle:@"Title"
             message:@"Show command"
             delegate:nil
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil]
             show];
            
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.indicatorView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateUI];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.indicatorView stopAnimating];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateUI];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.indicatorView stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateUI];
    
}



@end
