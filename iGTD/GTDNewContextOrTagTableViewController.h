//
//  GTDNewContextOrTagTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 7/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTDNewContextOrTagTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) BOOL isContext;

@end
