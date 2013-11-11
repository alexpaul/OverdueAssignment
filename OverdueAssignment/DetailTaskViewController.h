//
//  DetailTaskViewController.h
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskViewController.h"

@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

// Task from Source View Controller (OverdueAssignmentTVC)
@property (nonatomic, strong) Task *task;

// Index of the Task Object
@property (nonatomic) int index;

// TableView Data Source Array
@property (nonatomic, strong) NSMutableArray *tasksArray;

// UIView Elements
@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;

@end
