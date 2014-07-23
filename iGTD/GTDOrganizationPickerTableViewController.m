//
//  GTDContextPickerTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/25/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "GTDOrganizationPickerTableViewController.h"
#import "Context.h"
#import "Contact.h"
#import "Project.h"

@interface GTDOrganizationPickerTableViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation GTDOrganizationPickerTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.entityName isEqualToString:@"Contact"] || [self.entityName isEqualToString:@"Tag"])
    {
        self.tableView.allowsMultipleSelection = YES;
        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleBordered target:self action:@selector(okBarButtonItemPressed:)];
        self.navigationItem.rightBarButtonItem = okButton;
        if (self.currentSetting)
        {
            NSSet *set = (NSSet *)self.currentSetting;
            [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:obj];
                indexPath = self.tableView.allowsMultipleSelection ? [NSIndexPath indexPathForRow:indexPath.row + 2 inSection:indexPath.section] : [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }];
        }
    }
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSLog(@"sectionInfo numberOfObjects = %lu",(unsigned long)[sectionInfo numberOfObjects]);
    return self.tableView.allowsMultipleSelection ? [sectionInfo numberOfObjects] + 2 : [sectionInfo numberOfObjects] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.tableView.allowsMultipleSelection)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"New %@", self.entityName];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            return cell;
        } else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"Unset";
            return cell;
        }
    } else
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Unset";
            
            return cell;
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        if ([self.entityName isEqualToString:@"Contact"])
        {
            [self showPeoplePickerController];
        } else if ([self.entityName isEqualToString:@"Tag"])
        {
            [self createNewTag];
        } else
        {
            [self unset];
        }
    } else if (indexPath.row == 1 && self.tableView.allowsMultipleSelection)
    {
        [self unset];
    } else
    {
        
        if ([self.tableView allowsMultipleSelection])
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            indexPath = [NSIndexPath indexPathForRow:indexPath.row - 2 inSection:indexPath.section];
        } else
        {
            indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        }
        
        id obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self setNewObject:obj];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
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
    if ([self.entityName isEqualToString:@"Contact"] || [self.entityName isEqualToString:@"Tag"])
    {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row + 2 inSection:indexPath.section];
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + 2 inSection:newIndexPath.section];
    } else
    {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + 1 inSection:newIndexPath.section];
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
    indexPath = self.tableView.allowsMultipleSelection ? [NSIndexPath indexPathForRow:indexPath.row - 2 inSection:indexPath.section] : [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object description];
}
    
- (IBAction)cancelBarButtonItemPressed:(id)sender;
{
    [self.delegate didCancelOrganizationPicker];
}

- (void)unset
{
    if ([self.entityName isEqualToString:@"Context"])
    {
        [self.delegate didChangeContext:nil];
    } else if ([self.entityName isEqualToString:@"Project"])
    {
        [self.delegate didChangeProject:nil];
    } else if ([self.entityName isEqualToString:@"Contact"])
    {
        [self.delegate didChangeContacts:nil];
    } else
    {
        [self.delegate didChangeTags:nil];
    }
}

- (void)setNewObject:(id)obj
{
    if ([obj isKindOfClass:[Context class]])
    {
        Context *context = (Context *)obj;
        [self.delegate didChangeContext:context];
    } else if ([obj isKindOfClass:[Project class]])
    {
        Project *project = (Project *)obj;
        [self.delegate didChangeProject:project];
    }
}

- (void)okBarButtonItemPressed:(id)sender
{
    NSMutableArray *setArray = [NSMutableArray array];
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in indexPaths)
    {
        // Adjust row by -1 to account for "Unset" row
        NSIndexPath *adjustedIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 2 inSection:indexPath.section];
        NSManagedObject *obj = [self.fetchedResultsController objectAtIndexPath:adjustedIndexPath];
        [setArray addObject:obj];
    }
    NSSet *set = [NSSet setWithArray:setArray];
    if ([self.entityName isEqualToString:@"Contact"])
    {
        [self.delegate didChangeContacts:set];
    } else
    {
        [self.delegate didChangeTags:set];
    }
    
}

- (void)createNewContactWithABRecordRef:(ABRecordRef)person
{
    Contact *newContact = [Contact createEntity];
    newContact.abRecordID = [NSNumber numberWithInt:ABRecordGetRecordID(person)];
    newContact.firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    newContact.lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    NSLog(@"abRecordID = %@", newContact.abRecordID);
    NSLog(@"firstName = %@", newContact.firstName);
    NSLog(@"lastName = %@", newContact.lastName);
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
    [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"Error saving new Contact: %@", [error localizedDescription]);
        } else
        {
            NSLog(@"New Contact Saved!");
            NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:newContact];
            indexPath = [NSIndexPath indexPathForRow:indexPath.row + 2 inSection:indexPath.section];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }];
    
    
}

- (void)createNewTag
{
    
}

-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self createNewContactWithABRecordRef:person];
    [self dismissViewControllerAnimated:YES completion:NULL];
	return NO;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
