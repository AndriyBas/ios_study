//
//  ViewController.m
//  TestView4
//
//  Created by Andriy Bas on 1/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, AriphmeticOperation) {
    AriphmeticOperationNegative = -1,
    AriphmeticOperationPlus = 11,
    AriphmeticOperationMinus = 12,
    AriphmeticOperationMult = 13,
    AriphmeticOperationDivision = 14,
    AriphmeticOperationPerform = 15,
    AriphmeticOperationClear = 16,
    AriphmeticOperationNone = 17
};

@interface ViewController ()

@property (assign, nonatomic) CGFloat a;
@property (assign, nonatomic) CGFloat b;
@property (assign, nonatomic) AriphmeticOperation operation;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    button.frame = CGRectMake(50, 50, 200, 200);
//    [button setTitle:@"button" forState:UIControlStateNormal];
//    [button setTitle:@"button pressed" forState:UIControlStateHighlighted];
    
    
    NSDictionary* attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:30],
                            NSForegroundColorAttributeName: [UIColor greenColor]
                            };
    
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Button" attributes:attrs];
    
    [button setAttributedTitle:attrString forState:UIControlStateHighlighted];
    
//        UIKIT_EXTERN NSString *const NSParagraphStyleAttributeName NS_AVAILABLE_IOS(6_0);      // NSParagraphStyle, default defaultParagraphStyle
//        UIKIT_EXTERN NSString *const NSBackgroundColorAttributeName NS_AVAILABLE_IOS(6_0);     // UIColor, default nil: no background
//    UIKIT_EXTERN NSString *const NSLigatureAttributeName NS_AVAILABLE_IOS(6_0);
    
//    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    
    
    NSDictionary* attrsNormal = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                  NSForegroundColorAttributeName    : [UIColor cyanColor]
                                  };
    NSAttributedString* attrStringNormal = [[NSAttributedString alloc] initWithString:@"Button" attributes:attrsNormal];
    
    [button setAttributedTitle:attrStringNormal forState:UIControlStateNormal];
    
    [button setBackgroundColor:[UIColor lightGrayColor]];
    
    
    UIEdgeInsets insets = UIEdgeInsetsMake(100, 100, 0, 0);
    button.titleEdgeInsets = insets;
    
    
    [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.view addSubview:button];
    
    self.operation = AriphmeticOperationNone;
    
}

#pragma mark - Actions

- (void) actionButtonPressed:(UIButton*) button {
    NSLog(@"actionButtonPressed");
}

- (void) displayNumber:(CGFloat) num {
    self.label1.text = [NSString stringWithFormat:@"%1.2f", num];
}

- (IBAction)actionNumberPressed:(UIButton *)sender forEvent:(UIEvent *)event {
    NSLog(@"test action, tag = %ld", sender.tag);
    
//    self.label1.text = [NSString stringWithFormat:@" Tag = %ld", sender.tag];
    
    NSInteger tag = sender.tag;
    
    if(AriphmeticOperationNegative == tag) {
        if(AriphmeticOperationNone == self.operation) {
            self.a = -1.0F * self.a;
            [self displayNumber:self.a];
        } else {
            self.b = -1.0F * self.b;
            [self displayNumber:self.b];
        }
    } else if(tag < 10) {
        
        if(AriphmeticOperationNone == self.operation) {
            self.a = self.a * 10 + (CGFloat)tag;
            [self displayNumber:self.a];
        } else {
            self.b = self.b * 10 + (CGFloat)tag;
            [self displayNumber:self.b];
        }
        
    } else if(AriphmeticOperationClear == tag) {
        
        self.operation = AriphmeticOperationNone;
        self.a = 0.0F;
        self.b = 0.0F;
        
        self.label1.text = @"0";
        
    } else if(AriphmeticOperationPerform == tag) {
        
        if(AriphmeticOperationNone != self.operation) {
            
            CGFloat val = 0.0F;
            
            switch (self.operation) {
                case AriphmeticOperationPlus:
                    val = self.a + self.b;
                    break;
                case AriphmeticOperationMinus:
                    val = self.a - self.b;
                    break;
                case AriphmeticOperationMult:
                    val = self.a * self.b;
                    break;
                case AriphmeticOperationDivision:
                    val = self.a / self.b;
                    break;
                    
                default:
                    break;
            }
        
            self.operation = AriphmeticOperationNone;
            self.a = val;
            self.b = 0.0F;
            [self displayNumber:val];
            
        }
        
    } else {
        self.operation = (AriphmeticOperation)tag;
    }
}


//- (IBAction)actionTest3TouchDown:(UIButton*) sender {
//    NSLog(@"Test 3");
//}

@end
