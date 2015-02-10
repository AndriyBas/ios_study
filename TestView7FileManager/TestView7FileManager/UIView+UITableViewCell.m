//
//  UIView+UITableViewCell.m
//  TestView7FileManager
//
//  Created by Andriy Bas on 2/10/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell*) superCell {
    if(!self.superview) {
        return nil;
    }
    
    if([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*) self.superview;
    }
    
    return [self.superview superCell];
}

@end
