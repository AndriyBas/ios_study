//
//  VKPostCell.m
//  Test13Api
//
//  Created by Andriy Bas on 4/25/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "VKPostCell.h"

@implementation VKPostCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat) heightForText:(NSString*) text {
    
    CGFloat offset = 5.0;
    UIFont* font = [UIFont systemFontOfSize:17.0F];
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5;
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            font, NSFontAttributeName,
                           paragraph, NSParagraphStyleAttributeName,
                           shadow, NSShadowAttributeName,
                            nil];
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attrs
                                     context:nil];
    
    [text sizeWithAttributes:attrs];
    
    return CGRectGetHeight(rect) + 2 * offset;
}

@end
