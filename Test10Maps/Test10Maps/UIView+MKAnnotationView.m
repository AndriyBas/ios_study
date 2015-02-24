//
//  UIView+MKAnnotationView.m
//  Test10Maps
//
//  Created by Andriy Bas on 2/23/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)


- (MKAnnotationView*) superAnnotataionView {
    
    
    if([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    
    if(!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotataionView];
}

@end
