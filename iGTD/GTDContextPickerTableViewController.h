//
//  GTDContextPickerTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/25/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Context;

@protocol GTDContextPickerTableViewControllerDelegate <NSObject>

- (void)didCancelContextPicker;
- (void)didChangeContext:(Context *)context;

@end

@interface GTDContextPickerTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) id <GTDContextPickerTableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
