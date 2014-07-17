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


- (IBAction)saveBarButtonItemPressed:(id)sender
{
    if (self.isContext)
    {
        Context *context = [Context createEntity];
        context.title = self.titleTextField.text;
    } else
    {
        Tag *tag = [Tag createEntity];
        tag.title = self.titleTextField.text;
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
