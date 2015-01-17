//
//  ViewController.m
//  TestView2
//
//  Created by Andriy Bas on 1/15/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIImageView* testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor clearColor];
    
    UIImage* img1 = [UIImage imageNamed:@"Mario_MS.png"];
    UIImage* img2 = [UIImage imageNamed:@"Mario_MS1.png"];
    UIImage* img3 = [UIImage imageNamed:@"Mario_MS2.png"];
    UIImage* img4 = [UIImage imageNamed:@"Mario_MS3.png"];
    
    NSArray* images = [NSArray arrayWithObjects:img1, img2, img3, img4, nil];
    v.animationImages = images;
    v.animationDuration = 2;
    
    [v startAnimating];
    
    [self.view addSubview:v];
    
    self.testView = v;
}

- (void) viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
//    
//    [UIView animateWithDuration:5 animations:^{
//        
//        NSInteger x = self.testView.frame.origin.x + self.testView.frame.size.width;
//        NSInteger y = self.testView.frame.origin.y + self.testView.frame.size.height;
//        
//        CGPoint point = CGPointMake(x, y);
//        
//        self.testView.center = point;
//    }];
    
    [self moveView:self.testView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.testView.layer removeAllAnimations];
//        
//        
//        [UIView animateWithDuration:4
//                              delay:0
//                            options: UIViewAnimationOptionCurveEaseInOut| UIViewAnimationOptionBeginFromCurrentState
//                         animations:^{
//                             
//                             CGFloat width = self.testView.bounds.size.width / 2.0F;
//                             CGFloat height = self.testView.bounds.size.height / 2.0F;
//                             //
//                             //                CGSize size = CGSizeMake(width, height);
//                             //
//                             NSInteger x = width / 2;
//                             NSInteger y = self.view.frame.size.height - height / 2;
//                             
//                             CGPoint point = CGPointMake(x, y);
//                             
//                             self.testView.bounds = CGRectMake(0, self.view.frame.size.height - height, width, height);
//                             
//                             self.testView.center = point;
//                         }
//                         completion:^(BOOL finished) {
//                             NSLog(@"%@, finished == %d", @"hi there, animation completed", finished);
//                         }
//         ];
//
//    });
}

- (void) moveView:(UIView*) view {
    
    CGRect rect = self.view.bounds;
    
    rect = CGRectInset(rect, -CGRectGetWidth(view.bounds), -CGRectGetHeight(view.bounds));
    
    CGFloat x = arc4random() % ((int)CGRectGetWidth(rect)) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % ((int)CGRectGetHeight(rect)) + CGRectGetMinY(rect);

    CGPoint point = CGPointMake(x, y);
    
    CGFloat s = (CGFloat)(arc4random() % 151) / 100.0F + 0.5F;
    
    CGFloat r = (arc4random() % (int)(M_PI * 2.0 * 100000)) / 100000.0F - M_PI;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         view.center = point;
                         
                         view.backgroundColor = [self randomColor];
                         
                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
                         
                         view.transform = CGAffineTransformConcat(scale, rotation);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation completed, finished == %d", finished);
                         NSLog(@"/nview frame = %@\nbounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
                         
                         __weak UIView* v = view;
                         [self moveView:v];
                     }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) randomFloat {
    return (CGFloat)(arc4random() % 256) / 256.0F;
}

- (UIColor*) randomColor {
    CGFloat r = [self randomFloat];
    CGFloat g = [self randomFloat];
    CGFloat b = [self randomFloat];

    CGFloat alpha = [self randomFloat];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    for(UIView* v in self.testViewsCollection) {
        v.backgroundColor = [self randomColor];
    }
//    self.testView.backgroundColor = [self randomColor];
    
}

@end
