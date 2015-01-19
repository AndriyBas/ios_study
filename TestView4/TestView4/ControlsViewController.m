//
//  ControlsViewController.m
//  TestView4
//
//  Created by Andriy Bas on 1/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()

@property (assign, nonatomic) NSInteger sliderEventCount;
@property (assign, nonatomic) CGFloat redValue;
@property (assign, nonatomic) CGFloat greenValue;
@property (assign, nonatomic) CGFloat blueValue;

@end

typedef enum {
    ColorSchemeTypeRGB = 0,
    ColorSChemeTypeHSV = 1
} ColorSchemeType;



@implementation ControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateValues];
    [self refreshColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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



#pragma mark - Private Methods

- (void) refreshColor {

    CGFloat a, b, c, d;
    
    UIColor* color = nil;
    if(ColorSchemeTypeRGB == self.colorTypeSegmentedControl.selectedSegmentIndex) { color = [UIColor colorWithRed:self.redValue green:self.greenValue blue:self.blueValue alpha:1.0F];
        self.sliderLabel.text = [NSString stringWithFormat:@"RGB : {%1.2f, %1.2f, %1.2f}", self.redValue, self.greenValue, self.blueValue];
        
        BOOL res = [color getHue:&a saturation:&b brightness:&c alpha:&d];
        NSLog(@"convered = %d", res);
        self.sliderLabelHSV.text = [NSString stringWithFormat:@"HSV : {%1.2f, %1.2f, %1.2f}", a, b, c];
        
    } else {
        color = [UIColor colorWithHue:self.redValue saturation:self.greenValue brightness:self.blueValue alpha:1.0F];
        
        self.sliderLabelHSV.text = [NSString stringWithFormat:@"HSV : {%1.2f, %1.2f, %1.2f}", self.redValue, self.greenValue, self.blueValue];
    
        BOOL res = [color getRed:&a green:&b blue:&c alpha:&d];
        NSLog(@"convered = %d", res);
        self.sliderLabel.text = [NSString stringWithFormat:@"RGB : {%1.2f, %1.2f, %1.2f}", a, b, c];
        
    }
    
    self.testView.backgroundColor = color;
    self.enableSwitch.onTintColor = color;

//    self.sliderLabel.text = [NSString stringWithFormat:@"{%1.2f, %1.2f, %1.2f}", self.redValue, self.greenValue, self.blueValue];
}

- (void) updateValues {
    
    self.redValue = self.redSlider.value;
    self.greenValue = self.greenSlider.value;
    self.blueValue = self.blueSlider.value;
    
}

#pragma mark - Actions
- (IBAction)actionSliderChange:(UISlider *)sender {
    NSLog(@"value = %f", sender.value);
   
    [self updateValues];
    [self refreshColor];
    
}
- (IBAction)actionEnableSwitchStateChange:(UISwitch *)sender {
    
    NSLog(@"switch state : %d", sender.isOn);
    
    self.redSlider.enabled = sender.isOn;
    self.greenSlider.enabled = sender.isOn;
    self.blueSlider.enabled = sender.isOn;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4F * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });

    
}
- (IBAction)actionColorTypeChange:(UISegmentedControl *)sender {
    [self updateValues];
    [self refreshColor];
}
@end
