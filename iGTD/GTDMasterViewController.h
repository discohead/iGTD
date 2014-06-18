//
//  GTDMasterViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/8/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface GTDMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString *cellTextKey;
@property (strong, nonatomic) NSString *predicateFormatString;

@end
