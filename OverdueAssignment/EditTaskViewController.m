//
//  EditTaskViewController.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

#pragma mark - View Life Cycle
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


@end
