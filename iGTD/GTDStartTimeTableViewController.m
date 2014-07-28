//
//  GTDStartTimeTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDStartTimeTableViewController.h"
#import "GTDCalendarPickerViewController.h"

@interface GTDStartTimeTableViewController ()

@property (strong, nonatomic) NSArray *startTimes;

@end

@implementation GTDStartTimeTableViewController

- (NSArray *)startTimes
{
    if (!_startTimes)
    {
        _startTimes = @[@"Inbox", @"Today", @"Next", @"Tomorrow", @"Scheduled", @"Someday", @"Waiting"];
    }
    return _startTimes;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initilization
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    // Configure the cell...

    cell.textLabel.text = self.startTimes[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isProject)
    {
        if (indexPath.row == 0 || indexPath.row == 6)
        {
            return 0;
        } else
        {
            return tableView.rowHeight;
        }
    } else
    {
        return tableView.rowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCheckMarkForCellAtIndexPath:indexPath];
    
    if (self.isAllDay)
    {
        if (indexPath.row == 4)
        {
            [self performSegueWithIdentifier:@"calendarPicker" sender:[tableView cellForRowAtIndexPath:indexPath]];
        } else
        {
            [self.delegate didChangeStartTime:indexPath.row];
        }
    } else
    {
        switch (indexPath.row)
        {
            case 0:
            case 2:
                [self.delegate didChangeStartTime:indexPath.row];
                break;
            
            case 1:
            case 3:
            case 4:
                [self performSegueWithIdentifier:@"calendarPicker" sender:[tableView cellForRowAtIndexPath:indexPath]];
                break;
            
            case 5:
            case 6:
                self.isAllDay = NO;
                [self.delegate didChangeStartTime:indexPath.row];
                break;
                
            default:
                break;
        }
    }
    
}

- (void)setCheckMarkForCellAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else
    {
        for (int i = 0; i < self.startTimes.count; i++)
        {
            NSIndexPath *iPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:iPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *cell;
    NSIndexPath *indexPath;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) cell = (UITableViewCell *)sender;
    
    if (cell) indexPath = [self.tableView indexPathForCell:cell];
    
    if ([segue.identifier isEqualToString:@"calendarPicker"])
    {
        GTDCalendarPickerViewController *calendarVC = (GTDCalendarPickerViewController *)segue.destinationViewController;
        calendarVC.isScheduledDate = YES;
        calendarVC.isDeadlineDate = NO;
        calendarVC.isAllDay = self.isAllDay;
        calendarVC.startTime = indexPath.row;
    }
}


- (IBAction)cancelBarButtonPressed:(id)sender
{
    [self.delegate didCancel];
}

@end
