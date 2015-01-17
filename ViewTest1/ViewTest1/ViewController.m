//
//  ViewController.m
//  ViewTest1
//
//  Created by Andriy Bas on 1/13/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView* testView;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View

- (void) loadView {
    [super loadView];
    
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor greenColor];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
    } else {
        NSLog(@"iPad");
    }
    
    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    v1.backgroundColor = [UIColor cyanColor];
    
    UIView* v2 = [[UIView alloc] initWithFrame:CGRectMake(80, 130, 50, 250)];
    v2.backgroundColor = [UIColor magentaColor];
    v2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    
    self.testView = v2;
    [self.view addSubview:v1];
    [self.view addSubview:v2];
    
    [self.view bringSubviewToFront:v1];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews");
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

#pragma mark - Orientation

//
//- (BOOL) shouldAutorotate {
//    return YES;
//}
//
//- (NSUInteger) supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
//}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    NSLog(@"willRotateToInterfaceOrientation from %ld to %ld", self.interfaceOrientation, toInterfaceOrientation);
    
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"didRotateToInterfaceOrientation from %ld to %ld", fromInterfaceOrientation, self.interfaceOrientation);
    NSLog(@"\nframe == %@\nbounds == %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    
    CGPoint origin = CGPointZero;
    origin = [self.testView convertPoint:origin toView:self.view.window];
    
    NSLog(@"origin : %@", NSStringFromCGPoint(origin));
    
    CGRect rect = self.view.bounds;
    rect.origin.y = 0;
    rect.origin.x = CGRectGetWidth(rect) - 50;
    rect.size = CGSizeMake(50, 50);
    
    UIView* view = [[UIView alloc]  initWithFrame:rect];
    [view setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.3]];
    
    [self.view addSubview:view];
    
}





@end
