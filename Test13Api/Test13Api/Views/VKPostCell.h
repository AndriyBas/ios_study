//
//  VKPostCell.h
//  Test13Api
//
//  Created by Andriy Bas on 4/25/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* postTextLabel;

+ (CGFloat) heightForText:(NSString*) text;

@end
