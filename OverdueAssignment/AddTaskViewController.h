//
//  AddTaskViewController.h
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>
- (void)addNewTask:(Task *)newTask;
- (void)didCancel;
@end

@interface AddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@end
