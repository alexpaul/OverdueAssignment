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

@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

// EditTaskViewController Delegate
@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

// Task from Source View Controller
@property (nonatomic, strong) Task *task;

@end
