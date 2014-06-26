//
//  GTDCalendarPickerViewController.m
//  iGTD
//
//  Created by Jared McFarland on 6/24/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDCalendarPickerViewController.h"
#import "GTDStartTimeTableViewController.h"

@interface GTDCalendarPickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation GTDCalendarPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isAllDay)
    {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okBarButtonItemPressed:(UIBarButtonItem *)sender
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    GTDStartTimeTableViewController *startTimeVC = (GTDStartTimeTableViewController *)viewControllers[viewControllers.count - 2];
    if (self.isScheduledDate)
    {
        [startTimeVC.delegate didChangeStartTime:self.startTime withScheduledDate:self.datePicker.date];
    }
    
}

- (void)cancelBarButtonItemPressed:(id)sender
{
    [self.delegate didCancelDatePicker];
}

- (void)saveBarButtonItemPressed:(id)sender
{
    [self.delegate didPickDate:self.datePicker.date];
}

@end
