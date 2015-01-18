//
//  DrawingView.m
//  TestView3
//
//  Created by Andriy Bas on 1/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSLog(@"DrawingView drawRect");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat offset = 30.0F;
    CGFloat borderWidth = 2.0F;
    
    CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - offset * 2.0F - borderWidth * 2.0F,
                               CGRectGetHeight(rect) - offset * 2.0F - borderWidth * 2.0F);
    
    int cellSize = (int) maxBoardSize / 8;
    
    int boardSize = cellSize * 8;
    
    CGRect board = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2,
                              (CGRectGetHeight(rect) - boardSize) / 2,
                              boardSize,
                              boardSize);
    
    board = CGRectIntegral(board);
    
    for(int i = 0; i < 8; i++) {
        for(int j = 0; j < 8; j++) {
            if(i % 2 != j % 2) {
            CGRect cell = CGRectMake(CGRectGetMinX(board) + i * cellSize,
                                     CGRectGetMinY(board) + j * cellSize,
                                     cellSize,
                                     cellSize);
//            CGColorRef c = [UIColor blackColor].CGColor;
//            if(i % 2 != j % 2) {
//                c = [UIColor grayColor].CGColor;
//            }
//            
//            CGContextSetFillColorWithColor(context, c);
            CGContextAddRect(context, cell);
            }
            
        }
    }
    
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, board);
    CGContextSetLineWidth(context, borderWidth);
    CGContextStrokePath(context);
    
    
    
    
}



@end
