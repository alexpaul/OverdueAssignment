//
//  AddTaskViewController.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}


- (IBAction)saveButtonPressed:(UIButton *)sender
{
    // Format date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    // Create New Task
    Task *newTask = [[Task alloc] init];
    newTask.title = self.taskTitleTextField.text;
    newTask.description = self.taskDescriptionTextView.text;
    newTask.date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", self.taskDatePicker.date]];
    
    [self.delegate addNewTask:newTask];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
