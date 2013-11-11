//
//  OverdueAssignmentDataController.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/9/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "OverdueAssignmentDataController.h"

@implementation OverdueAssignmentDataController

#pragma mark - Date Formatter
+ (NSDateFormatter *)dateFormatter
{
    // Format date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return dateFormatter;
}

#pragma mark - Helper Methods for NSUserDefaults
+ (NSDictionary *)tasksAsAPropertyList:(Task *)newTask
{
    NSDictionary *dictionary = @{TITLE: newTask.title, DESCRIPTION : newTask.description, DATE : newTask.date, ISCOMPLETE : @(newTask.isComplete)};
    return dictionary;
}

+ (void)updateNSUserDefaultsAtIndex:(int)index withTask:(Task *)task
{
    // Retrieve Array from NSUserDefaults
    NSMutableArray *arrayToBeUpdatedInNSUserDefaults = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASKS_NSUSERDEFAULTS_KEY] mutableCopy];
    
    // If Array is not initialize do so
    if (!arrayToBeUpdatedInNSUserDefaults)arrayToBeUpdatedInNSUserDefaults = [[NSMutableArray alloc] init];
    
    // Update data in Array and make it a Property List
    [arrayToBeUpdatedInNSUserDefaults replaceObjectAtIndex:index withObject:[OverdueAssignmentDataController tasksAsAPropertyList:task]];
    
    // Set and Sync NSUserDefaults with changes
    [[NSUserDefaults standardUserDefaults]setObject:arrayToBeUpdatedInNSUserDefaults forKey:TASKS_NSUSERDEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
