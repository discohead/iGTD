//
//  GTDContextPickerTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/25/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDContextPickerTableViewController.h"

@interface GTDContextPickerTableViewController ()

@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) UINavigationItem *navItem;

@end

@implementation GTDContextPickerTableViewController


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Unset";
        return cell;
    } else
    {
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.delegate didChangeContext:nil];
    } else
    {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        Context *context = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.delegate didChangeContext:context];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object description];
}
    
- (IBAction)cancelBarButtonItemPressed:(id)sender;
{
    [self.delegate didCancelContextPicker];
}

@end