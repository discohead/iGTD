//
//  GTDPrioritiesTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/18/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDStartTimesTableViewController.h"
#import "GTDActionsTableViewController.h"

@interface GTDStartTimesTableViewController ()

@end

@implementation GTDStartTimesTableViewController

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
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    // Configure the cell...
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Inbox";
            break;
        case 1:
            cell.textLabel.text = @"Today";
            break;
        case 2:
            cell.textLabel.text = @"Next";
            break;
        case 3:
            cell.textLabel.text = @"Tomorrow";
            break;
        case 4:
            cell.textLabel.text = @"Scheduled";
            break;
        case 5:
            cell.textLabel.text = @"Someday";
            break;
        case 6:
            cell.textLabel.text = @"Waiting";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Actions" sender:[tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
        
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSNumber *startTime = @(indexPath.row);
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:NO];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startTime == %@", startTime];
        [fetchRequest setPredicate:predicate];
        
        NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                   managedObjectContext:moc
                                                                                                     sectionNameKeyPath:@"startTime"
                                                                                                              cacheName:cell.textLabel.text];
        
        if ([segue.destinationViewController isKindOfClass:[GTDActionsTableViewController class]])
        {
            GTDActionsTableViewController *actionsVC = (GTDActionsTableViewController *)[segue destinationViewController];
            fetchedResultsController.delegate = actionsVC;
            actionsVC.fetchedResultsController = fetchedResultsController;
            actionsVC.navigationItem.title = cell.textLabel.text;
            
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
