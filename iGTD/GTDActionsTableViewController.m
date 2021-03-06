//
//  GTDActionsTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "GTDActionsTableViewController.h"
#import "GTDNewActionTableViewController.h"
#import "GTDNewContextOrTagTableViewController.h"
#import "GTDTableViewCell.h"
#import "GTDAppDelegate.h"
#import "Action.h"
#import "Project.h"
#import "Context.h"
#import "Contact.h"
#import "Tag.h"

@interface GTDActionsTableViewController () <ABPersonViewControllerDelegate>

@property (strong, nonatomic) NSArray *startTimes;

@end

@implementation GTDActionsTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _startTimes = @[@"Inbox", @"Today", @"Next", @"Tomorrow", @"Scheduled", @"Someday", @"Waiting"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.parentEntity)
    {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.navigationItem.title = [self.parentEntity description];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.parentEntity)
    {
        return [[self.fetchedResultsController sections] count] + 1;
    } else
    {
        return [[self.fetchedResultsController sections] count];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.parentEntity)
    {
        if (section == 0)
        {
            return 1;
        } else
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section - 1];
            return [sectionInfo numberOfObjects];
        }
    } else
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [sectionInfo numberOfObjects];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.parentEntity)
    {
        if (section == 0)
        {
            return NSStringFromClass([self.parentEntity class]);
        } else
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section - 1];
            
            if ([sectionInfo numberOfObjects])
            {
                Action *action = (Action *)[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section - 1]];
                NSString *title = self.startTimes[[action.startTime integerValue]];
                return title;
            } else
            {
                return @"Empty";
            }
        }
    } else
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        
        if ([sectionInfo numberOfObjects])
        {
            Action *action = (Action *)[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            NSString *title = self.startTimes[[action.startTime integerValue]];
            return title;
        } else
        {
            return @"Empty";
        }
        
    }
    
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (self.parentEntity)
    {
        sectionIndex = sectionIndex + 1;
    }
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    if (self.parentEntity)
    {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section + 1];
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:newIndexPath.section + 1];
    }
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (self.parentEntity)
    {
        if (indexPath.section == 0)
        {
            cell.textLabel.text = [self.parentEntity description];
        } else
        {
            NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
            cell.textLabel.text = [object description];
        }
    } else
    {
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [object description];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
        if (self.parentEntity) [moc deleteObject:[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]]];
        else [moc deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (!success)
            {
                NSLog(@"Error Deleting Action: %@", [error localizedDescription]);
            } else
            {
                NSLog(@"Action Deleted!");
            }
        }];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.parentEntity)
    {
        if (indexPath.section == 0)
        {
            NSString *parentClass = NSStringFromClass([self.parentEntity class]);
            if ([parentClass isEqualToString:@"Contact"])
            {
                GTDAppDelegate *appDelegate = (GTDAppDelegate *)[[UIApplication sharedApplication] delegate];
                Contact *contact = (Contact *)self.parentEntity;
                ABRecordRef person = ABAddressBookGetPersonWithRecordID(appDelegate.addressBook, [contact.abRecordID intValue]);
                ABPersonViewController *picker = [[ABPersonViewController alloc] init];
                picker.personViewDelegate = self;
                picker.displayedPerson = person;
                picker.allowsEditing = YES;
                [self.navigationController pushViewController:picker animated:YES];
            } else
            {
                [self performSegueWithIdentifier:parentClass sender:self.parentEntity];
            }
        } else
        {
            Action *action = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
            [self performSegueWithIdentifier:@"Action" sender:action];
        }
    } else
    {
        Action *action = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"Action" sender:action];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newAction"])
    {
        if (self.parentEntity)
        {
            NSString *parentType = NSStringFromClass([self.parentEntity class]);
            parentType = [parentType lowercaseString];
            GTDNewActionTableViewController *newActionVC = (GTDNewActionTableViewController *)segue.destinationViewController;
            
            if ([parentType isEqualToString:@"contact"] || [parentType isEqualToString:@"tag"])
            {
                parentType = [parentType stringByAppendingString:@"s"];
                NSSet *entitySet = [NSSet setWithObject:self.parentEntity];
                [newActionVC setValue:entitySet forKey:parentType];
            } else
            {
                [newActionVC setValue:self.parentEntity forKey:parentType];
            }
            
        }
    } else if ([segue.identifier isEqualToString:@"Action"])
    {
        Action *action = (Action *)sender;
        GTDNewActionTableViewController *editActionVC = (GTDNewActionTableViewController *)segue.destinationViewController;
        editActionVC.action = action;
        editActionVC.titleText = action.title;
        editActionVC.descriptionText = action.textDescription;
        editActionVC.priority = action.priority;
        editActionVC.project = action.project;
        editActionVC.context = action.context;
        editActionVC.contacts = action.contacts;
        editActionVC.tags = action.tags;
        editActionVC.startTime = action.startTime;
        editActionVC.scheduledDate = action.scheduledDate;
        editActionVC.deadline = action.deadline;
        editActionVC.isAllDay = [action.isAllDay boolValue];
        editActionVC.navigationItem.title = @"Edit Action";
    } else if ([segue.identifier isEqualToString:@"Project"])
    {
        Project *project = (Project *)sender;
        GTDNewProjectTableViewController *editProjectVC = (GTDNewProjectTableViewController *)segue.destinationViewController;
        editProjectVC.project = project;
        editProjectVC.titleText = project.title;
        editProjectVC.descriptionText = project.textDescription;
        editProjectVC.startTime = project.startTime;
        editProjectVC.scheduledDate = project.scheduledDate;
        editProjectVC.deadline = project.deadline;
        editProjectVC.context = project.context;
        editProjectVC.contacts = project.contacts;
        editProjectVC.tags = project.tags;
        editProjectVC.navigationItem.title = @"Edit Project";
    } else if ([segue.identifier isEqualToString:@"Context"])
    {
        Context *context = (Context *)sender;
        GTDNewContextOrTagTableViewController *editContextVC = (GTDNewContextOrTagTableViewController *)segue.destinationViewController;
        editContextVC.context = context;
        editContextVC.titleText = context.title;
        editContextVC.isContext = YES;
        editContextVC.navigationItem.title = @"Edit Context";
    } else if ([segue.identifier isEqualToString:@"Tag"])
    {
        Tag *tag = (Tag *)sender;
        GTDNewContextOrTagTableViewController *editTagVC = (GTDNewContextOrTagTableViewController *)segue.destinationViewController;
        editTagVC.tag = tag;
        editTagVC.titleText = tag.title;
        editTagVC.navigationItem.title = @"Edit Tag";
    }
}

#pragma mark - Person View Controller Delegate

- (BOOL)personViewController:(ABPersonViewController *)personViewController
shouldPerformDefaultActionForPerson:(ABRecordRef)person
                    property:(ABPropertyID)property
                  identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

@end
