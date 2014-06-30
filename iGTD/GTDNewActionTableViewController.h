//
//  GTDNewActionTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"
#import "Project.h"
#import "Context.h"
#import "Contact.h"
#import "Tag.h"

#import "GTDStartTimeTableViewController.h"
#import "GTDCalendarPickerViewController.h"
#import "GTDOrganizationPickerTableViewController.h"

@interface GTDNewActionTableViewController : UITableViewController <GTDStartTimeTableViewControllerDelegate,
                                                                    GTDCalendarPickerViewControllerDelegate,
                                                                    GTDOrganizationPickerTableViewControllerDelegate>

@property (strong, nonatomic) Action *action;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) Context *context;
@property (strong, nonatomic) NSSet *contacts;
@property (strong, nonatomic) NSSet *tags;
@property (strong, nonatomic) NSNumber *priority;
@property (strong, nonatomic) NSNumber *startTime;
@property (strong, nonatomic) NSDate *scheduledDate;
@property (strong, nonatomic) NSDate *deadline;
@property (nonatomic) BOOL isAllDay;

@end
