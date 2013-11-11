//
//  EditTaskViewController.h
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol EditTaskViewControllerDelegate <NSObject>
- (void)saveChangesMadeToTheTask:(Task *)task; // Save changes made in the EditTaskViewController
@end

@interface EditTaskViewController : UIViewController

// EditTaskViewController Delegate
@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

// Task from Source View Controller
@property (nonatomic, strong) Task *task;

// UIView Elements for Task Information
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

@end
