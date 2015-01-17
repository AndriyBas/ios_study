//
//  ViewController.m
//  TestView3
//
//  Created by Andriy Bas on 1/16/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView* testView;
@property (assign, nonatomic) CGPoint touchOffset;

@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end

@implementation ViewController

CGFloat animationDuration = 0.3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton* button =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[[UIButton alloc] initWithFrame:];
    [button addTarget:self action:@selector(onRefreshClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Refresh" forState:UIControlStateNormal];
    button.frame = CGRectMake(5.0F, 20.0F, 160.0F, 40.0F);
    
    [self.view addSubview:button];
    
//    self.draggingView = view;
    
//    self.view.multipleTouchEnabled = YES;
    
    [self onRefreshClick:button];
    
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    UITapGestureRecognizer* doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    
    UITapGestureRecognizer* doubleTapDoubleTouchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapDoubleTaouchGesture:)];
    doubleTapDoubleTouchRecognizer.numberOfTapsRequired = 2;
    doubleTapDoubleTouchRecognizer.numberOfTouchesRequired = 2;
    
    UIPinchGestureRecognizer* pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handlePinchGesture:)];
    
    UIRotationGestureRecognizer* rotationGestureRecognizer = [ [UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    
    
    // delegating gestures
    rotationGestureRecognizer.delegate = self;
    pinchGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view addGestureRecognizer:doubleTapRecognizer];
    [self.view addGestureRecognizer:doubleTapDoubleTouchRecognizer];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
}

- (void) onRefreshClick:(UIButton*) button {
    
    for(UIView* view in [self.view subviews]) {
        if(![view  isKindOfClass:[UIButton class]])
            [view removeFromSuperview];
    }
    
    for(int i = 0 ; i < 6; i++) {
        UIView* view = [[UIView alloc]  initWithFrame:[self randomRect]];
        
        view.backgroundColor = [self randomColor];
        
        [self.view addSubview:view];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (CGFloat) randomFloat {
    return (arc4random()  % 100000) / 100000.0F;
}

- (CGRect) randomRect {
    CGFloat x = self.view.frame.size.width * [self randomFloat];
    CGFloat y = self.view.frame.size.height * [self randomFloat];
    
    CGFloat width = (self.view.frame.size.width - x) * [self randomFloat];
    CGFloat height = width;//(self.view.frame.size.height - y) * [self randomFloat];
    
    return CGRectMake(x, y, width, height);
}

- (UIColor*) randomColor {
    
    CGFloat r = [self randomFloat];
    CGFloat g = [self randomFloat];
    CGFloat b = [self randomFloat];
    
    CGFloat alpha = [self randomFloat];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

- (void) logTouches:(NSSet*) touches withMethod:(NSString*) methodName {
    NSMutableString* str = [NSMutableString stringWithString:methodName];
    
    for(UITouch* touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [str appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"\n%@", str);
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];

    UITouch* touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    UIView* view = [self.view hitTest:point withEvent:event];
    
    if(![view isEqual:self.view]) {
        self.testView = view;
        
        [self.view bringSubviewToFront:self.testView];
        
        CGPoint touchPoint = [touch locationInView:self.testView];
        self.touchOffset =  CGPointMake(CGRectGetMidX(self.testView.bounds) - touchPoint.x,
                                        CGRectGetMidY(self.testView.bounds) - touchPoint.y);
     
        [self.testView.layer removeAllAnimations];
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             CGAffineTransform transform = CGAffineTransformMakeScale(1.2F, 1.2F);
                             self.testView.transform = transform;
                             self.testView.alpha = 0.3F;
                             
        }];
    } else {
        self.testView = nil;
    }
    
    NSLog(@"point inside %d", [self.testView pointInside:point withEvent:event]);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesMove"];
    
    if(self.testView) {
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        self.testView.center = CGPointMake(point.x + self.touchOffset.x, point.y + self.touchOffset.y);
    }
    
}

- (void) cancelAnimationOnTouchFinish {
    if(self.testView) {
        [self.testView.layer removeAllAnimations];
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             self.testView.transform = CGAffineTransformIdentity;
                             self.testView.alpha = 1.0F;
                         } completion:^(BOOL finished) {
                             self.testView = nil;
                         }];
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    
    [self cancelAnimationOnTouchFinish];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

    [self logTouches:touches withMethod:@"touchesCanceled"];
    
    [self cancelAnimationOnTouchFinish];
}

#pragma mark - Gesture

- (void) handleTapGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    
    
}

- (void) handleDoubleTapGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Double Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    if(!self.testView) return;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.testView.backgroundColor = [self randomColor];
                         self.testView.transform = CGAffineTransformScale(self.testView.transform, 1.2F, 1.2F);
                     }];
    
    self.testViewScale = 1.2F;
}

- (void) handleDoubleTapDoubleTaouchGesture:(UITapGestureRecognizer*) gestureRecognizer {
    NSLog(@"Double Tap : %@", NSStringFromCGPoint([gestureRecognizer locationInView:self.view]));
    
    if(!self.testView) return;
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.backgroundColor = [self randomColor];
        self.testView.transform = CGAffineTransformScale(self.testView.transform, 0.8F, 0.8F);
    }];
    
    self.testViewScale = 0.8F;
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer*) gestureRecognizer {
    NSLog(@"Pinch velocity = %1.3f, scale = %1.3f", gestureRecognizer.velocity, gestureRecognizer.scale);
    
    if(!self.testView) return;
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
    
    if(!self.testView) return;
    if(rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0.0F;
    }
    
    CGFloat newRotation = rotationGestureRecognizer.rotation - self.testViewRotation;
    
    CGAffineTransform newTransform = CGAffineTransformRotate(self.testView.transform, newRotation);
    self.testView.transform = newTransform;
    
    self.testViewRotation = rotationGestureRecognizer.rotation;
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
