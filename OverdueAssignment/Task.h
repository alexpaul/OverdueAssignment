//
//  Task.h
//  OverdueAssignment
//
//  Created by Alex Paul on 11/9/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

//#define TITLE @"Title of Task"
//#define DESCRIPTION @"Description of Task"
//#define DATE @"Date of Task"

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) BOOL isComplete;

- (id)initWithData:(NSDictionary *)dictionary;

@end
