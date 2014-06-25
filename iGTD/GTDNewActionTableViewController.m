//
//  GTDNewActionTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDNewActionTableViewController.h"
#import "GTDStartTimeTableViewController.h"

@interface GTDNewActionTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIStepper *priorityStepper;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) NSArray *priorityStrings;
@property (strong, nonatomic) NSArray *startTimeStrings;

@end

@implementation GTDNewActionTableViewController

- (IBAction)isAllDaySwitch:(UISwitch *)sender
{
    self.isAllDay = !self.isAllDay;
}

- (IBAction)priorityStepperValueChanged:(UIStepper *)sender
{
    self.priority = @(sender.value);
    self.priorityLabel.text = self.priorityStrings[self.priority.integerValue];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization
        _priorityStrings = @[@"None", @"Low", @"Medium", @"High"];
        _startTimeStrings = @[@"Inbox", @"Today", @"Next", @"Tomorrow", @"Scheduled", @"Someday", @"Waiting"];
        _isAllDay = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSArray *sectionRows = @[@2, @1, @3, @5];
    NSInteger rowCount = [sectionRows[section] integerValue];
    return rowCount;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"startTime" sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"startTime"])
    {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
            NSArray *vcs = [nav viewControllers];
            GTDStartTimeTableViewController *startTimeVC = [vcs firstObject];
            startTimeVC.isAllDay = self.isAllDay;
            startTimeVC.delegate = self;
        }
    }
    
}

#pragma mark - Start Time Delegate

- (void)didChangeStartTime:(NSInteger)startTime
{
    [self didChangeStartTime:startTime withScheduledDate:nil];
}

- (void)didChangeStartTime:(NSInteger)startTime withScheduledDate:(NSDate *)date
{
    
    self.startTime = @(startTime);
    self.scheduledDate = date;
    
    [self formatStartTimeLabel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)dateStringFromDate:(NSDate *)date
{
    if (self.isAllDay)
    {
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    } else if (self.startTime.intValue == 1)
    {
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    } else
    {
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    }
}

- (void)formatStartTimeLabel
{
    if (self.isAllDay)
    {
        switch (self.startTime.intValue)
        {
            case 0:
            case 1:
            case 2:
            case 5:
            case 6:
                self.startTimeLabel.text = self.startTimeStrings[self.startTime.intValue];
                break;
            
            case 3:
                self.startTimeLabel.text = [self dateStringFromDate:[NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60]];
                break;
                
            case 4:
                self.startTimeLabel.text = [self dateStringFromDate:self.scheduledDate];
                break;
                
            default:
                break;
        }
    } else
    {
        switch (self.startTime.intValue)
        {
            case 0:
            case 2:
            case 5:
            case 6:
                self.startTimeLabel.text = self.startTimeStrings[self.startTime.intValue];
                break;
            
            case 1:
                self.startTimeLabel.text = [NSString stringWithFormat:@"Today %@", [self dateStringFromDate:self.scheduledDate]];
                break;
            
            case 3:
            case 4:
                self.startTimeLabel.text = [self dateStringFromDate:self.scheduledDate];
                break;
                
            default:
                break;
        }
    }
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
