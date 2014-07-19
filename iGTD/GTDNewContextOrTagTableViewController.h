//
//  GTDNewContextOrTagTableViewController.h
//  iGTD
//
//  Created by Jared McFarland on 7/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Context.h"
#import "Tag.h"

@interface GTDNewContextOrTagTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) BOOL isContext;
@property (strong, nonatomic) Context *context;
@property (strong, nonatomic) Tag *tag;
@property (strong, nonatomic) NSString *titleText;

@end
