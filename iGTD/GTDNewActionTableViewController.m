//
//  GTDNewActionTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDNewActionTableViewController.h"

@interface GTDNewActionTableViewController ()

@property (weak, nonatomic) IBOutlet UIStepper *priorityStepper;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UISwitch *allDaySwitch;
@property (strong, nonatomic) NSArray *priorityStrings;

@end

@implementation GTDNewActionTableViewController

- (Action *)action
{
    if (!_action)
    {
        _action = [Action createEntity];
    }
    return _action;
}

- (NSNumber *)priority
{
    if (_priority == nil)
    {
        _priority = @0;
    }
    return _priority;
}

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
        self.organizationStrings = @[@"Context", @"Project", @"Contacts", @"Tags", @"Color"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.projectLabel.text = [self.project description];
    self.priorityStepper.value = [self.priority doubleValue];
    self.priorityLabel.text = self.priorityStrings[self.priority.integerValue];
    self.allDaySwitch.on = self.isAllDay;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        if (indexPath.row == 1)
        {
            [self performSegueWithIdentifier:@"startTime" sender:[tableView cellForRowAtIndexPath:indexPath]];
        } else if (indexPath.row == 2)
        {
            [self performSegueWithIdentifier:@"deadline" sender:[tableView cellForRowAtIndexPath:indexPath]];
        }
        
    } else if (indexPath.section == 3)
    {
        
        [self performSegueWithIdentifier:@"organizationPicker" sender:[tableView cellForRowAtIndexPath:indexPath]];

    }
}

#pragma mark - Organization Picker Delegate

- (void)didChangeProject:(Project *)project
{
    
    // Refactor using KVO?
    
    self.project = project;
    self.projectLabel.text = [project description];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBarButtonItemPressed:(id)sender
{

    self.action.title = self.titleTextField.text;
    self.action.textDescription = self.descriptionTextField.text;
    self.action.priority = self.priority;
    self.action.isAllDay = @(self.isAllDay);
    self.action.startTime = self.startTime;
    self.action.scheduledDate = self.scheduledDate;
    self.action.deadline = self.deadline;
    self.action.context = self.context;
    self.action.project = self.project;
    self.action.contacts = self.contacts;
    self.action.tags = self.tags;
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
    [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"Error saving Action: %@", [error localizedDescription]);
        } else
        {
            NSLog(@"Action Saved!");
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
