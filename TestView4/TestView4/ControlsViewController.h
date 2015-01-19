//
//  ControlsViewController.h
//  TestView4
//
//  Created by Andriy Bas on 1/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlsViewController : UIViewController
- (IBAction)actionSliderChange:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabelHSV;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;

@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UIView *testView;
- (IBAction)actionEnableSwitchStateChange:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl* colorTypeSegmentedControl;
- (IBAction)actionColorTypeChange:(UISegmentedControl *)sender;
@end
