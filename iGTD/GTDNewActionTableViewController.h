//
//  GTDNewActionTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 6/23/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDNewProjectTableViewController.h"
#import "Action.h"

@interface GTDNewActionTableViewController : GTDNewProjectTableViewController

@property (strong, nonatomic) Action *action;
@property (strong, nonatomic) NSNumber *priority;

@end
