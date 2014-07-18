//
//  GTDActionsTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDActionsTableViewController.h"
#import "GTDNewActionTableViewController.h"
#import "Action.h"
#import "Project.h"
#import "Context.h"
#import "Contact.h"
#import "Tag.h"

@interface GTDActionsTableViewController ()

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
            Action *action = (Action *)[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section - 1]];
            NSString *title = self.startTimes[[action.startTime integerValue]];
            return title;
        }
    } else
    {
        Action *action = (Action *)[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        NSString *title = self.startTimes[[action.startTime integerValue]];
        return title;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.parentEntity)
    {
        if (indexPath.section == 0)
        {
            NSString *parentClass = NSStringFromClass([self.parentEntity class]);
            [self performSegueWithIdentifier:parentClass sender:self.parentEntity];
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
            if ([parentType isEqualToString:@"contact"] || [parentType isEqualToString:@"tag"])
            {
                parentType = [parentType stringByAppendingString:@"s"];
                self.parentEntity = [NSSet setWithObject:self.parentEntity];
            }

            GTDNewActionTableViewController *newActionVC = (GTDNewActionTableViewController *)segue.destinationViewController;
            [newActionVC setValue:self.parentEntity forKey:parentType];
        }
    }
}

@end
