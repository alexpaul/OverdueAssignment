//
//  EditTaskViewController.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

// UIView Elements for Task Information
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

// UIToolbar to dismiss UITextView Keyboard
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation EditTaskViewController

#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide the toolbar. Only make visible when the user is editing the UITextView
    self.toolbar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.taskTitleTextField.text = self.task.title;
    self.taskDescriptionTextView.text = self.task.description;
    self.taskDatePicker.date = self.task.date;
}

#pragma mark - Save Action
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{    
    Task *task = [[Task alloc]init];
    
    task.title = self.taskTitleTextField.text;
    task.description = self.taskDescriptionTextView.text;
    task.date = self.taskDatePicker.date;
    
    [self.delegate saveChangesMadeToTheTask:task];
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate Methods
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

- (IBAction)toolbarButtonPressed:(UIBarButtonItem *)sender
{
    // Resign the First Responder so the UITextView Keyboard can be dismissed
    [self.taskDescriptionTextView resignFirstResponder];
    
    // Hide toolbar
    self.toolbar.hidden = YES;
}


@end
