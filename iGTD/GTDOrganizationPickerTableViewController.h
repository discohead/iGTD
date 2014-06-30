//
//  GTDContextPickerTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/25/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Context, Project;

@protocol GTDOrganizationPickerTableViewControllerDelegate <NSObject>

- (void)didCancelOrganizationPicker;
@optional
- (void)didChangeContext:(Context *)context;
- (void)didChangeProject:(Project *)project;
- (void)didChangeContacts:(NSSet *)contacts;
- (void)didChangeTags:(NSSet *)tags;
- (void)didChangeColor:(UIColor *)color;

@end

@interface GTDOrganizationPickerTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) id <GTDOrganizationPickerTableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) id currentSetting;

@end