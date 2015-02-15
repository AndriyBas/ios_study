//
//  ViewController.m
//  TestView9Popup
//
//  Created by Andriy Bas on 2/15/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController* myPopoverController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showModalViewController:(UIViewController*) vc {
    
    __weak ViewController* weakSelf = self;
    [self presentViewController:vc animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(weakSelf) {
                [vc dismissViewControllerAnimated:YES completion:nil];
            }
        });
    }];

}

- (void) showPopoverViewController:(UIViewController*) vc fromSender:(id) sender {
    
//    vc.preferredContentSize = CGSizeMake(300, 300);
    
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:navVC];
    
    if([sender isKindOfClass:[UIBarButtonItem class]]) {
    
        [popoverController
         presentPopoverFromBarButtonItem:sender
         permittedArrowDirections:UIPopoverArrowDirectionUp
         animated:YES
         ];
    } else if([sender isKindOfClass:[UIButton class]]) {
        
        [popoverController
         presentPopoverFromRect:[sender frame]
         inView:self.view
         permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight
         animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0F * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.myPopoverController && [self.myPopoverController isEqual:popoverController]) {
                [self.myPopoverController dismissPopoverAnimated:YES];
                self.myPopoverController = nil;
            }
        });
    }
    
    popoverController.delegate = self;
    self.myPopoverController = popoverController;
}


- (void) showDetailsViewController:(id) sender {
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    vc.preferredContentSize = CGSizeMake(300.0F, 300.0F);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { // iPad
        [self showPopoverViewController:vc fromSender:sender];
    } else { // iPhone
        [self showModalViewController:vc];
    }

}


#pragma mark - Actions
- (IBAction)actionAdd:(UIBarButtonItem*)sender {
    //[self showDetailsViewController:sender];
}


- (IBAction)actionPressMe:(UIButton*)sender {
    [self showDetailsViewController:sender];
}

#pragma mark - UIPopoverControllerDelegate 

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.myPopoverController = nil;
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepare for segue with identifier : %@", segue.identifier);
    
//    if([@"showDetailsSegueIdentifier" isEqual:segue.identifier]) {
//        [self showDetailsViewController:sender];
//    }
}

@end
