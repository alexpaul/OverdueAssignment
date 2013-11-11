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

#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide the toolbar. Only make visible when the user is editing the UITextView
    self.toolbar.hidden = YES;
}


#pragma mark - UIButton Actions
- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

- (IBAction)saveButtonPressed:(UIButton *)sender
{
    // Create New Task
    Task *newTask = [[Task alloc] init];
    newTask.title = self.taskTitleTextField.text;
    newTask.description = self.taskDescriptionTextView.text;
    newTask.date = self.taskDatePicker.date;
    
    [self.delegate addNewTask:newTask];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // Make the toolbar visible so the user can dismiss the keyboard
    self.toolbar.hidden = NO; 
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // Hide the keyboard
    self.toolbar.hidden = YES; 
}

- (IBAction)toolbarDoneButtonPressed:(UIBarButtonItem *)sender
{
    // Resign the First Responder so the UITextView Keyboard can be dismissed
    [self.taskDescriptionTextView resignFirstResponder];
    
    // Hide toolbar
    self.toolbar.hidden = YES;
}

@end
