//
//  DetailViewController.h
//  AAAAA
//
//  Created by Andriy Bas on 4/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
