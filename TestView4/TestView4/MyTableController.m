//
//  MyTableController.m
//  TestView4
//
//  Created by Andriy Bas on 1/21/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "MyTableController.h"

@interface MyTableController ()

@end

static NSString* kSettingsLogin           = @"login";
static NSString* kSettingsPassword        = @"password";
static NSString* kSettingsLevel           = @"level";
static NSString* kSettingsShadows         = @"shadow";
static NSString* kSettingsDetalization    = @"detalization";
static NSString* kSettingsSounds          = @"sounds";
static NSString* kSettingsSoundVal        = @"soundVal";

@implementation MyTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSettings];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificatoinKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}


#pragma mark - Notifications

- (void) notificatoinKeyboardWillShow:(NSNotification*) notification {
    NSLog(@"notificationKeyboardWillShow : %@", notification.userInfo);
}


- (void) notificationKeyboardDidHide:(NSNotification*) notification {
    NSLog(@"notificationKeyboardDidHide : %@", notification.userInfo);
}

- (void)dealloc {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (void) saveSettings {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.loginTextField.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordTextField.text forKey:kSettingsPassword];
    [userDefaults setInteger:self.levelSegmentedControll.selectedSegmentIndex forKey:kSettingsLevel];
    [userDefaults setBool:self.shadowSwitch.isOn forKey:kSettingsShadows];
    [userDefaults setFloat:self.detalizationSegmentedControll.selectedSegmentIndex forKey:kSettingsDetalization];
    [userDefaults setBool:self.soundSwitch.isOn forKey:kSettingsSounds];
    [userDefaults setFloat:self.soundSlider.value forKey:kSettingsSoundVal];
    
    [userDefaults synchronize];
}

- (void) loadSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [[self loginTextField] setText:[userDefaults stringForKey:kSettingsLogin]];
    self.passwordTextField.text = [userDefaults stringForKey:kSettingsPassword];
    
    self.levelSegmentedControll.selectedSegmentIndex = [userDefaults integerForKey:kSettingsLevel];
    self.shadowSwitch.on = [userDefaults boolForKey:kSettingsShadows];
    self.detalizationSegmentedControll.selectedSegmentIndex = [userDefaults integerForKey:kSettingsDetalization];
    self.soundSwitch.on = [userDefaults boolForKey:kSettingsSounds];
    self.soundSlider.value = [userDefaults floatForKey:kSettingsSoundVal];
    
    
}

- (IBAction)actionTextChanged:(id)sender {
    [self saveSettings];
}

- (IBAction)actionValueChanged:(id)sender {
    [self saveSettings];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField isEqual:self.loginTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
