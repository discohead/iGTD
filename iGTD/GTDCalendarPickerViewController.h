//
//  GTDCalendarPickerViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/24/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTDCalendarPickerViewController : UIViewController

@property (nonatomic) BOOL isScheduledDate;
@property (nonatomic) BOOL isDeadlineDate;
@property (nonatomic) NSInteger startTime;

@end
