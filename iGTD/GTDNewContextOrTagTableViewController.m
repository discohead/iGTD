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

@interface GTDNewContextOrTagTableViewController () <UITextFieldDelegate>

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
    self.titleTextField.delegate = self;
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
            if (self.isContext)
            {
                [self.delegate didSaveNewContextOrTag:self.context];
            } else
            {
                [self.delegate didSaveNewContextOrTag:self.tag];
            }
            
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.inputAccessoryView == nil)
    {
        textField.inputAccessoryView = self.accessoryView;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)dismissKeyboardButtonPressed:(UIButton *)sender
{
    [self.titleTextField resignFirstResponder];
}

@end
