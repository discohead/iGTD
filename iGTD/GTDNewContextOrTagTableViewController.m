//
//  GTDNewContextOrTagTableViewController.m
//  iGTD
//
//  Created by Jared McFarland on 7/17/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDNewContextOrTagTableViewController.h"
#import "Context.h"
#import "Tag.h"

@interface GTDNewContextOrTagTableViewController ()

@end

@implementation GTDNewContextOrTagTableViewController

- (Context *)context
{
    if (!_context)
    {
        _context = [Context createEntity];
    }
    return _context;
}

- (Tag *)tag
{
    if(!_tag)
    {
        _tag = [Tag createEntity];
    }
    return _tag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleTextField.text = self.titleText;
}

- (IBAction)saveBarButtonItemPressed:(id)sender
{
    if (self.isContext)
    {
        self.context.title = self.titleTextField.text;
    } else
    {
        self.tag.title = self.titleTextField.text;
    }
    
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
    [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"Error saving New Context or Tag: %@", [error localizedDescription]);
        } else
        {
            NSLog(@"New Context or Tag Saved!");
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
