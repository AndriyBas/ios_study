//
//  DrawingController.m
//  TestView3
//
//  Created by Andriy Bas on 1/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "DrawingController.h"
#import "DrawingView.h"

@interface DrawingController ()

@end

@implementation DrawingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
//    DrawingView* view = [[DrawingView alloc] initWithFrame:self.view.bounds];
  
//    self.drawingView.autoresizingMask = UIViewAutoresizingFlexibleHeight |  UIViewAutoresizingFlexibleWidth
//    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
//    self.drawingView.backgroundColor = [UIColor whiteColor];
    
//    self.drawingView = view;
    
//    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
//- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    
//    [self.drawingView setNeedsDisplay];
//}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
       [self.drawingView setNeedsDisplay];
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
