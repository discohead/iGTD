//
//  GTDNewProjectTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 7/12/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDNewProjectTableViewController.h"

@interface GTDNewProjectTableViewController () <UITextFieldDelegate>

@end

@implementation GTDNewProjectTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization
        _startTimeStrings = @[@"Inbox", @"Today", @"Next", @"Tomorrow", @"Scheduled", @"Someday", @"Waiting"];
        _organizationStrings = @[@"Context", @"Contacts", @"Tags", @"Color"];
        _isAllDay = YES;
        _startTime = @0;
        _startTimeLabel.text = @"Inbox";
    }
    return self;
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            [self performSegueWithIdentifier:@"startTime" sender:[tableView cellForRowAtIndexPath:indexPath]];
        } else if (indexPath.row == 1)
        {
            [self performSegueWithIdentifier:@"deadline" sender:[tableView cellForRowAtIndexPath:indexPath]];
        }
        
    } else if (indexPath.section == 2)
    {
        
        [self performSegueWithIdentifier:@"organizationPicker" sender:[tableView cellForRowAtIndexPath:indexPath]];
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
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
    } else if ([segue.identifier isEqualToString:@"deadline"])
    {
        if ([segue.destinationViewController isKindOfClass:[GTDCalendarPickerViewController class]])
        {
            GTDCalendarPickerViewController *calendarVC = (GTDCalendarPickerViewController *)segue.destinationViewController;
            calendarVC.delegate = self;
            calendarVC.isAllDay = self.isAllDay;
            calendarVC.isDeadlineDate = YES;
            calendarVC.isScheduledDate = NO;
            UINavigationBar *navBar = [[UINavigationBar alloc] init];
            navBar.frame = CGRectMake(0, 0, CGRectGetWidth(calendarVC.view.frame), 64);
            UINavigationItem *navItem = [[UINavigationItem alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:calendarVC action:@selector(cancelBarButtonItemPressed:)];
            UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:calendarVC action:@selector(saveBarButtonItemPressed:)];
#pragma clang diagnostic pop
            navItem.leftBarButtonItem = cancelButton;
            navItem.rightBarButtonItem = saveButton;
            navBar.items = @[navItem];
            [calendarVC.view addSubview:navBar];
            
        }
    } else if ([segue.identifier isEqualToString:@"organizationPicker"])
    {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
            NSArray *vcs = [nav viewControllers];
            GTDOrganizationPickerTableViewController *orgVC = [vcs firstObject];
            orgVC.delegate = self;
            NSString *entityName;
            NSString *sortKey = @"title";
            if ([sender isKindOfClass:[UITableViewCell class]])
            {
                UITableViewCell *cell = (UITableViewCell *)sender;
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                entityName = self.organizationStrings[indexPath.row];
                
                // Trim "s" from Contacts or Tags to get proper entity name
                if ([[entityName substringFromIndex:entityName.length-1] isEqualToString: @"s"]) entityName = [entityName substringToIndex:entityName.length-1];
                
                
                if ([entityName isEqualToString:@"Contact"])
                {
                    // Change sort key for Contact
                    sortKey = @"lastName";
                    orgVC.currentSetting = self.contacts;
                }
                else if ([entityName isEqualToString:@"Tag"])
                {
                    orgVC.currentSetting = self.tags;
                } else
                {
                    orgVC.currentSetting = [self valueForKey:[entityName lowercaseString]];
                }
                
            }
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
            [fetchRequest setSortDescriptors:@[sortDescriptor]];
            NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:entityName];
            orgVC.fetchedResultsController = fetchedResultsController;
            fetchedResultsController.delegate = orgVC;
            orgVC.entityName = entityName;
            orgVC.navigationItem.title = entityName;
            
            NSError *error = nil;
            if (![orgVC.fetchedResultsController performFetch:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            
        }
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.inputAccessoryView == nil)
    {
        textField.inputAccessoryView = self.accessoryView;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)dismissKeyboardButtonPressed:(UIButton *)sender
{
    [self.titleTextField resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
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

#pragma mark - Calendar Picker Delegate

- (void)didCancelDatePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didPickDate:(NSDate *)date
{
    self.deadline = date;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.deadlineLabel.text = [self dateStringFromDate:date];
}

#pragma mark - Organization Picker Delegate

- (void)didCancelOrganizationPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didChangeContext:(Context *)context
{
    self.context = context;
    self.contextLabel.text = [context description];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didChangeContacts:(NSSet *)contacts
{
    self.contacts = contacts;
    __block NSMutableArray *contactNames = [NSMutableArray array];
    [contacts enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        Contact *contact = (Contact *)obj;
        [contactNames addObject:[contact firstName]];
    }];
    self.contactsLabel.text = [contactNames componentsJoinedByString:@", "];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didChangeTags:(NSSet *)tags
{
    self.tags = tags;
    __block NSMutableArray *tagTitles = [NSMutableArray array];
    [tags enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        Tag *tag = (Tag *)obj;
        [tagTitles addObject:[tag title]];
    }];
    self.tagsLabel.text = [tagTitles componentsJoinedByString:@", "];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

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
- (IBAction)saveBarButtonItemPressed:(id)sender
{
    Project *project = [Project createEntity];
    project.title = self.titleTextField.text;
    project.textDescription = self.descriptionTextField.text;
    project.startTime = self.startTime;
    project.scheduledDate = self.scheduledDate;
    project.deadline = self.deadline;
    project.context = self.context;
    project.contacts = self.contacts;
    project.tags = self.tags;
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
    [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"Error saving New Project: %@", [error localizedDescription]);
        } else
        {
            NSLog(@"New Project Saved!");
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
