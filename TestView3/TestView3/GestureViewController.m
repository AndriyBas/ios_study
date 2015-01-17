//
//  GestureViewController.m
//  TestView3
//
//  Created by Andriy Bas on 1/17/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView* testView;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init testView
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                           CGRectGetMidY(self.view.bounds) - 50,
                                                           100,
                                                           100)];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    view.backgroundColor = [self randomColor];
    [self.view addSubview:view];
    self.testView = view;
    
    // init GestureRecognizers
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    UITapGestureRecognizer* doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    
    [doubleTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    
    UITapGestureRecognizer* doubleTapDoubleTouchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapDoubleTaouchGesture:)];
    doubleTapDoubleTouchRecognizer.numberOfTapsRequired = 2;
    doubleTapDoubleTouchRecognizer.numberOfTouchesRequired = 2;
    
    UIPinchGestureRecognizer* pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handlePinchGesture:)];
    
    UIRotationGestureRecognizer* rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    
    
    // delegating gestures
    rotationGestureRecognizer.delegate = self;
    pinchGestureRecognizer.delegate = self;
    
    
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    // add recognizers
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view addGestureRecognizer:doubleTapRecognizer];
    [self.view addGestureRecognizer:doubleTapDoubleTouchRecognizer];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    [self.view addGestureRecognizer:panGestureRecognizer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods 

#define INT_MODULO 100000

- (CGFloat) randomFloat {
    return (CGFloat)(arc4random() % INT_MODULO) / INT_MODULO;
}

- (UIColor*) randomColor {
    CGFloat r = [self randomFloat];
    CGFloat g = [self randomFloat];
    CGFloat b = [self randomFloat];
    
    CGFloat alpha = [self randomFloat];
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

#pragma mark - Gesture

- (void) handleTapGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    self.testView.backgroundColor = [self randomColor];
    
}

- (void) handleDoubleTapGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Double Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    [UIView animateWithDuration:0.3
                     animations:^{
        self.testView.backgroundColor = [self randomColor];
        self.testView.transform = CGAffineTransformScale(self.testView.transform, 1.2F, 1.2F);
    }];
    
    self.testViewScale = 1.2F;
}

- (void) handleDoubleTapDoubleTaouchGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Double Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.backgroundColor = [self randomColor];
        self.testView.transform = CGAffineTransformScale(self.testView.transform, 0.8F, 0.8F);
    }];
    
    self.testViewScale = 0.8F;
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer*) gestureRecognizer {
    NSLog(@"Pinch velocity = %1.3f, scale = %1.3f", gestureRecognizer.velocity, gestureRecognizer.scale);
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.0F;
    }
    
    CGFloat newScale = 1.0F + gestureRecognizer.scale - self.testViewScale;
    
    CGAffineTransform transform = CGAffineTransformScale(self.testView.transform, newScale, newScale);
    self.testView.transform = transform;

    self.testViewScale = gestureRecognizer.scale;
}
                                                              
- (void) handleRotationGesture:(UIRotationGestureRecognizer*) rotationGestureRecognizer {
    NSLog(@"Rotation, angle : %f, velocity : %f", rotationGestureRecognizer.rotation, rotationGestureRecognizer.velocity);
    
    if(rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0.0F;
    }
    
    CGFloat newRotation = rotationGestureRecognizer.rotation - self.testViewRotation;
    
    CGAffineTransform newTransform = CGAffineTransformRotate(self.testView.transform, newRotation);
    self.testView.transform = newTransform;
    
    self.testViewRotation = rotationGestureRecognizer.rotation;
}

- (void) handlePan:(UIPanGestureRecognizer*) panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.view];
    
    NSLog(@"Pan, center = %@", NSStringFromCGPoint(point));
    
    self.testView.center = point;
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
