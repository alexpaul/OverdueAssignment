//
//  OverdueAssignmentDataController.h
//  OverdueAssignment
//
//  Created by Alex Paul on 11/9/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface OverdueAssignmentDataController : NSObject

+ (NSDateFormatter *)dateFormatter;
+ (NSDictionary *)tasksAsAPropertyList:(Task *)newTask;
+ (void)updateNSUserDefaultsAtIndex:(NSInteger)index withTask:(Task *)task;

@end
