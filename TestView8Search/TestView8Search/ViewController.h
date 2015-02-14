//
//  ViewController.h
//  TestView8Search
//
//  Created by Andriy Bas on 2/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UISearchBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar* nameSearchBar;

@end

