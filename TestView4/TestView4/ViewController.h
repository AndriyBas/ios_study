//
//  ViewController.h
//  TestView4
//
//  Created by Andriy Bas on 1/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label1;

- (IBAction)actionNumberPressed:(UIButton *)sender forEvent:(UIEvent *)event;

//- (IBAction)actionTest3TouchDown:(UIButton*) sender;

@end

