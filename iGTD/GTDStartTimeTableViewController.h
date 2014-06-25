//
//  GTDStartTimeTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GTDStartTimeTableViewControllerDelegate <NSObject>

- (void)didChangeStartTime:(NSInteger)startTime;
- (void)didChangeStartTime:(NSInteger)startTime withScheduledDate:(NSDate *)date;
- (void)didCancel;

@end

@interface GTDStartTimeTableViewController : UITableViewController

@property (nonatomic) BOOL isAllDay;
@property (weak, nonatomic) id <GTDStartTimeTableViewControllerDelegate> delegate;

@end
