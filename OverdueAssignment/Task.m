//
//  Task.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/9/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)init
{
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData:(NSDictionary *)dictionary
{
    self = [super init];
    
    self.title = dictionary[TITLE];
    self.description = dictionary[DESCRIPTION];
    self.date = dictionary[DATE];
    self.isComplete = [dictionary[ISCOMPLETE] boolValue];
    
    return self;
}

@end
