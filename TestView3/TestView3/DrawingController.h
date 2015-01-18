//
//  DrawingController.h
//  TestView3
//
//  Created by Andriy Bas on 1/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawingView;

@interface DrawingController : UIViewController

@property (weak, nonatomic) IBOutlet DrawingView* drawingView;

@end
