//
//  MyTableController.h
//  TestView4
//
//  Created by Andriy Bas on 1/21/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *levelSegmentedControll;

@property (weak, nonatomic) IBOutlet UISwitch *shadowSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl*detalizationSegmentedControll;

@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISlider *soundSlider;


- (IBAction)actionTextChanged:(UITextField*)sender;
- (IBAction)actionValueChanged:(id)sender;

@end
