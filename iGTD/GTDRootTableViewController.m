//
//  GTDRootTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDRootTableViewController.h"
#import "GTDMasterViewController.h"
#import "GTDActionsTableViewController.h"
#import "GTDPrioritiesTableViewController.h"

@interface GTDRootTableViewController ()

@property (strong, nonatomic) NSArray *menuOptions;

@end

@implementation GTDRootTableViewController

- (NSArray *)menuOptions
{
    if (!_menuOptions)
    {
        _menuOptions = [NSArray arrayWithObjects:@"Inbox", @"Projects", @"Contexts", @"Contacts", @"Tags", @"Priorities", @"All Actions", nil];
    }
    return _menuOptions;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.menuOptions[indexPath.row]];
    
    // Configure the cell...
    cell.textLabel.text = self.menuOptions[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 1:
        case 2:
        case 3:
        case 4:
            [self performSegueWithIdentifier:@"Entity Segue" sender:[tableView cellForRowAtIndexPath:indexPath]];
            break;
            
        case 5:
            [self performSegueWithIdentifier:@"Priorities" sender:[tableView cellForRowAtIndexPath:indexPath]];
            break;
        
        case 6:
            [self performSegueWithIdentifier:@"All Actions" sender:[tableView cellForRowAtIndexPath:indexPath]];
            break;
            
        default:
            break;
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString:@"Entity Segue"])
    {
        NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
        GTDMasterViewController *masterVC = (GTDMasterViewController *)[segue destinationViewController];
        masterVC.managedObjectContext = moc;
        NSFetchRequest *fetchRequest;
        
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSString *cellText = cell.textLabel.text;
        NSString *entityName = [cellText substringToIndex:cellText.length-1];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
        fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSString *sortKey;
        if ([cellText isEqualToString:@"Contacts"])
        {
            sortKey = @"lastName";
        } else
        {
            sortKey = @"title";
        }
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
        NSArray *sortDescriptors = @[sortDescriptor];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSFetchedResultsController *projectsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:cellText];
        projectsController.delegate = masterVC;
        masterVC.fetchedResultsController = projectsController;
        masterVC.navigationItem.title = cellText;
        
        if ([cellText isEqualToString:@"Contexts"] || [cellText isEqualToString:@"Projects"])
        {
            NSString *predicateString = [[entityName lowercaseString] stringByAppendingString:@" == %@"];
            masterVC.predicateFormatString = predicateString;
            NSLog(@"%@", predicateString);
        } else if ([cellText isEqualToString:@"Contacts"] || [cellText isEqualToString:@"Tags"])
        {
            NSString *predicateString = @"%@ IN ";
            masterVC.predicateFormatString = [predicateString stringByAppendingString:[cellText lowercaseString]];
            NSLog(@"%@", predicateString);
        }
        
        
        NSError *error = nil;
        if (![masterVC.fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else if ([segue.identifier isEqualToString:@"All Actions"])
    {
        NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
        if ([segue.destinationViewController isKindOfClass:[GTDActionsTableViewController class]])
        {
            GTDActionsTableViewController *actionsVC = (GTDActionsTableViewController *)[segue destinationViewController];
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO];
            [fetchRequest setSortDescriptors:@[sortDescriptor]];
            
            NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                       managedObjectContext:moc
                                                                                                         sectionNameKeyPath:nil
                                                                                                                  cacheName:@"All Actions"];
            fetchedResultsController.delegate = actionsVC;
            actionsVC.fetchedResultsController = fetchedResultsController;
            actionsVC.navigationItem.title = @"All Actions";
            
            NSError *error = nil;
            if (![actionsVC.fetchedResultsController performFetch:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
    
}


@end
