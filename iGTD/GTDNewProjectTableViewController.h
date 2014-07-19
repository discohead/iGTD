//
//  GTDNewProjectTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 7/12/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Context.h"
#import "Contact.h"
#import "Tag.h"

#import "GTDStartTimeTableViewController.h"
#import "GTDCalendarPickerViewController.h"
#import "GTDOrganizationPickerTableViewController.h"

@interface GTDNewProjectTableViewController : UITableViewController <GTDStartTimeTableViewControllerDelegate,
                                                                    GTDCalendarPickerViewControllerDelegate,
                                                                    GTDOrganizationPickerTableViewControllerDelegate>

@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) Context *context;
@property (strong, nonatomic) NSSet *contacts;
@property (strong, nonatomic) NSSet *tags;
@property (strong, nonatomic) NSNumber *startTime;
@property (strong, nonatomic) NSDate *deadline;
@property (strong, nonatomic) NSDate *scheduledDate;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *descriptionText;
@property (nonatomic) BOOL isAllDay;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) NSArray *startTimeStrings;
@property (strong, nonatomic) NSArray *organizationStrings;
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

@end
