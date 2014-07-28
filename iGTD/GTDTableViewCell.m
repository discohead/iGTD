//
//  GTDTableViewCell.m
//  iGTD
//
//  Created by Jared McFarland on 7/27/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDTableViewCell.h"
#import "GTDCheckBoxView.h"

@implementation GTDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        GTDCheckBoxView *checkBox = [[GTDCheckBoxView alloc] initWithFrame:CGRectMake(self.frame.origin.x + 10, self.frame.origin.y + 10, self.frame.size.width / 10, self.frame.size.width / 10 )];
        [self addSubview:checkBox];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    GTDCheckBoxView *checkBox = [[GTDCheckBoxView alloc] initWithFrame:CGRectMake(self.frame.origin.x + 10, self.frame.origin.y + 10, self.frame.size.width / 10, self.frame.size.width / 10 )];
    [self addSubview:checkBox];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
