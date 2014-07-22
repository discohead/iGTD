//
//  GTDContextPickerTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/25/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDOrganizationPickerTableViewController.h"
#import "Context.h"
#import "Contact.h"
#import "Project.h"

@interface GTDOrganizationPickerTableViewController ()

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
                indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
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
    return [sectionInfo numberOfObjects] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"New Tag";
        cell.textLabel.textColor = [UIColor lightTextColor];
    } else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Unset";
        return cell;
    }
    {
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if ([self.entityName isEqualToString:@"Contact"])
        {
            [self createNewContact];
        } else if ([self.entityName isEqualToString:@"Tag"])
        {
            [self createNewTag];
        }
    } else if (indexPath.row == 1)
    {
        [self unset];
    } else
    {
        if ([self.tableView allowsMultipleSelection])
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        indexPath = [NSIndexPath indexPathForRow:indexPath.row - 2 inSection:indexPath.section];
        id obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self setNewObject:obj];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 2 inSection:indexPath.section];
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

- (void)createNewContact
{
    
}

- (void)createNewTag
{
    
}

@end
