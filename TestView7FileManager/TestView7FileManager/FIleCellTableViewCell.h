//
//  FIleCellTableViewCell.h
//  TestView7FileManager
//
//  Created by Andriy Bas on 2/10/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FIleCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* sizeLablel;
@property (weak, nonatomic) IBOutlet UILabel* dataLabel;

@end
