//
//  ControlsViewController.m
//  TestView4
//
//  Created by Andriy Bas on 1/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController() <UITextFieldDelegate>

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
    
//    self.firstNameTextField.delegate = self;
//    self.lastNameTextField.delegate = self;
    
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - UITextFieldDelegate


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {      // return NO to disallow editing.
//    return [textField isEqual:self.firstNameTextField];
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField {           // became first responder
    // empty
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {         // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@" ,()"];
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    // accept only digits for input
    if([string componentsSeparatedByCharactersInSet:validationSet].count > 1) {
        return NO;
    }

    // +XX (XXX) XXX-XXXX
    NSString* str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    static const int localMaxLength = 7;
    static const int areaMaxLength = 3;
    static const int countryMaxLenght = 2;
    static const int maxPhoneLength = localMaxLength + areaMaxLength + countryMaxLenght;
    
    // XXXXXXXXXXXX
    NSString* newString = [[str componentsSeparatedByCharactersInSet:validationSet] componentsJoinedByString:@""];
    
    // length check
    if(newString.length > maxPhoneLength) {
        return NO;
    }
    
    NSMutableString* resultStr = [NSMutableString stringWithString:newString]; // @""
    
    if(newString.length == maxPhoneLength) {
        [resultStr insertString:@"+" atIndex:0];
    }
    
    if(newString.length > localMaxLength ) {
        NSInteger areaLength = MIN(3, newString.length - localMaxLength);
        [resultStr insertString:@" (" atIndex:resultStr.length - localMaxLength - areaLength];
        [resultStr insertString:@") " atIndex:resultStr.length - localMaxLength];
    }
    
    if(newString.length > 4) {
        [resultStr insertString:@"-" atIndex:resultStr.length - 4];
    }
//    
//    UITextRange* textRange = [textField selectedTextRange];
//    
//    UITextPosition* textStartPosition = [textField positionFromPosition:textRange.start offset:offset];
//    UITextPosition* textEndPosition = [textField positionFromPosition:textRange.end offset:offset];
//
//    textField.text = resultStr;
//    
//    textField.selectedTextRange = [textField textRangeFromPosition:textStartPosition toPosition:textEndPosition];
    
    
    return NO;
    
//    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {               // called when clear button pressed. return NO to ignore (no notifications)
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {              // called when 'return' key pressed. return NO to ignore.

    if([textField isEqual:self.firstNameTextField]) {
        [self.lastNameTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    
    return YES;
}

#pragma mark - Notifications
- (void) notificationTextDidChange:(NSNotification*) notification {
    
    NSLog(@"notification : %@", self.firstNameTextField.text);
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

- (void) logNames {
    NSString* firstName = self.firstNameTextField.text;
    NSString* lastName = self.lastNameTextField.text;
    NSLog(@"[%@ %@]", firstName, lastName);

}

- (IBAction)actionLogBtnPressed:(UIButton *)sender {
    [self logNames];
    
}

- (IBAction)actionTextEditChange:(UITextField *)sender {
    [self logNames];
    
}

@end
