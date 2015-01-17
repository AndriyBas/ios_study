//
//  QuizViewController.m
//  Quiz
//
//  Created by Andriy Bas on 12/28/14.
//  Copyright (c) 2014 Andriy Bas. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;
@property (nonatomic, weak) IBOutlet UIButton *b;
@end


@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.b addTarget:self action:@selector(act:) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)act:(id)sender {
    NSLog(@"click_manual");
}
- (IBAction)newact:(id)sender {
    NSLog(@"click_auto");
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
