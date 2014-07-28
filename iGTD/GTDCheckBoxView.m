//
//  GTDCheckBoxView.m
//  iGTD
//
//  Created by Jared McFarland on 7/27/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDCheckBoxView.h"

@implementation GTDCheckBoxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor grayColor] setStroke];
    [[UIColor clearColor] setFill];
    UIBezierPath *square = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [square stroke];
    [square fill];
}


@end
