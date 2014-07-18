//
//  GTDActionsTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTDActionsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) id parentEntity;

@end
