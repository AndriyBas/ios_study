//
//  DirectoryTableViewController.h
//  TestView7FileManager
//
//  Created by Andriy Bas on 2/8/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryTableViewController : UITableViewController

- (instancetype) initWithFolderPath:(NSString*) path;


- (IBAction) actionInfoCell:(id)sender;


@end
