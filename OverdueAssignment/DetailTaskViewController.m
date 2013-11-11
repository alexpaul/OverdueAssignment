//
//  DetailTaskViewController.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "DetailTaskViewController.h"
#import "OverdueAssignmentDataController.h"
#import "EditTaskViewController.h"
#import "Task.h"

@interface DetailTaskViewController ()

// Format Date
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DetailTaskViewController

#pragma mark - Lazy Instantiation
- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)_dateFormatter = [OverdueAssignmentDataController dateFormatter];
    return _dateFormatter;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set up UIView Elements with Task Information
    self.taskTitleLabel.text = self.task.title;
    self.taskDetailsTextView.text = self.task.description;
    
    // Format Date
    self.taskDateLabel.text = [self.dateFormatter stringFromDate:self.task.date];
}

#pragma mark - Prepare For Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to EditTaskViewController from UIBarButtonItem
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
            EditTaskViewController *editTaskVC = [segue destinationViewController];
            editTaskVC.task = self.task;
            editTaskVC.delegate = self;
        }
    }
}

#pragma mark - EditTaskViewController Delegate Methods
- (void)saveChangesMadeToTheTask:(Task *)task
{
    // Update NSUserDefaults (Array of Dictionaries of Task Objects)
    NSMutableArray *arrayToBeUpdated = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASKS_NSUSERDEFAULTS_KEY] mutableCopy];
    [arrayToBeUpdated replaceObjectAtIndex:self.index withObject:[OverdueAssignmentDataController tasksAsAPropertyList:task]];
    
    // Save changes to NSUserDefaults
    [[NSUserDefaults standardUserDefaults]setObject:arrayToBeUpdated forKey:TASKS_NSUSERDEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // Update UIView Elements with changes
    self.taskTitleLabel.text = task.title;
    self.taskDetailsTextView.text = task.description;
    self.taskDateLabel.text = [self.dateFormatter stringFromDate:task.date];
    
    // Update TableView Array
    [self.tasksArray replaceObjectAtIndex:self.index withObject:task];
    
    // Pop View from Stack
    [self.navigationController popViewControllerAnimated:YES];    
}

@end
