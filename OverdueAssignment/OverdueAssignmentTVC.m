//
//  OverdueAssignmentTVC.m
//  OverdueAssignment
//
//  Created by Alex Paul on 11/8/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "OverdueAssignmentTVC.h"
#import "Task.h"
#import "DetailTaskViewController.h"
#import "OverdueAssignmentDataController.h"

@interface OverdueAssignmentTVC ()

// Format Date
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

// Tasks Array to be used for TableView
@property (nonatomic, strong) NSMutableArray *tasksArray;

@end

@implementation OverdueAssignmentTVC

#pragma mark - Lazy Instantiation
- (NSMutableArray *)tasksArray
{
    if (!_tasksArray)_tasksArray = [[NSMutableArray alloc] init];
    return _tasksArray;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Get an Array of Tasks from NSUserDefaults
    NSArray *taskAsAPropertyList = [[NSUserDefaults standardUserDefaults]objectForKey:TASKS_NSUSERDEFAULTS_KEY];
    
    if (!taskAsAPropertyList)NSLog(@"Array is Empty");
    else{
        // Use Fast Enumerationt to get the Dictionary Objects with the Task from the Array
        for (NSDictionary *dictionary in taskAsAPropertyList) {
            Task *task = [[Task alloc] initWithData:dictionary];
            [self.tasksArray addObject:task];
            NSLog(@"Title is %@", task.title);
            NSLog(@"%d", task.isComplete);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Doing this to update the table view relinquishes the ability to get the selected row animation after coming back to the table view
    [self.tableView reloadData];
}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasksArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Task *task = [self.tasksArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = task.description;
    
    // Set background color based on task being Complete, not Complete or Late
    // Late: Red
    // Current: Yellow
    // Complete: Green
    if (!task.isComplete) {
        if ([task.date compare:[NSDate date]] == NSOrderedAscending) {
            cell.backgroundColor = [UIColor redColor];
        }else{
            cell.backgroundColor = [UIColor yellowColor];
        }
    }else{ // isComplete
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tasksArray removeObjectAtIndex:indexPath.row];
        
        // Retrieve the Task Array from NSUserDefaults
        NSMutableArray *taskArrayToBeUpdated = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASKS_NSUSERDEFAULTS_KEY]mutableCopy];
        
        // Delete the Task from that Array
        [taskArrayToBeUpdated removeObjectAtIndex:indexPath.row];
        
        // Update NSUserDefaults
        [[NSUserDefaults standardUserDefaults]setObject:taskArrayToBeUpdated forKey:TASKS_NSUSERDEFAULTS_KEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Reorder Rows
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender
{
    self.tableView.editing = !self.tableView.isEditing;
}

#pragma mark - UITableView Methods
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // Save the Task to Be Moved
    Task *taskToBeMoved = [self.tasksArray objectAtIndex:fromIndexPath.row];
    
    // Remove the object from its current index
    [self.tasksArray removeObjectAtIndex:fromIndexPath.row];
    
    // Insert the Task in its new index
    [self.tasksArray insertObject:taskToBeMoved atIndex:toIndexPath.row];
    
    // Save Reordering to NSUserDefaults
    NSMutableArray *arrayNeedsToBeUpdatedInNSUserDefaults = [[NSMutableArray alloc] init];
    for (Task *task in self.tasksArray) {
        NSDictionary *dictionary = [OverdueAssignmentDataController tasksAsAPropertyList:task];
        [arrayNeedsToBeUpdatedInNSUserDefaults addObject:dictionary];
    }
    [[NSUserDefaults standardUserDefaults]setObject:arrayNeedsToBeUpdatedInNSUserDefaults forKey:TASKS_NSUSERDEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showTaskDetails" sender:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the current task
    Task *task = [self.tasksArray objectAtIndex:indexPath.row];
    
    // Toggle Task isComplete to mark cell "Green" or not to indicate completion or not respectively
    task.isComplete = !task.isComplete;
    
    // Update NSUserDefaults
    [OverdueAssignmentDataController updateNSUserDefaultsAtIndex:indexPath.row withTask:task];
    
    // Reload the table view in order for the selection to take effect
    [self.tableView reloadData];
}

#pragma mark - Prepare For Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to AddTaskViewController from "Add Task" UIBarButtonItem
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
            AddTaskViewController *addTaskVC = [segue destinationViewController];
            addTaskVC.delegate = self;
        }
    }
    // Segue to DetailTaskViewController from Accessory Button (IndexPath)
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]) {
            NSIndexPath *indexPath = sender;
            DetailTaskViewController *detailVC = [segue destinationViewController];
            detailVC.task = [self.tasksArray objectAtIndex:indexPath.row];
            detailVC.index = indexPath.row;
            detailVC.tasksArray = self.tasksArray;
        }
    }
}

#pragma mark - AddTaskViewController Delegate Methods
- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addNewTask:(Task *)newTask
{
    // Add to the TableView Array
    [self.tasksArray addObject:newTask];
    
    // Create an Array and retrieve data from NSUserDefaults
    NSMutableArray *taskAsAPropertyListArray = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASKS_NSUSERDEFAULTS_KEY] mutableCopy];
    
    // If Array is Empty Initialize it
    if (!taskAsAPropertyListArray)taskAsAPropertyListArray = [[NSMutableArray alloc] init];
    
    // Add New Task to the Array
    [taskAsAPropertyListArray addObject:[OverdueAssignmentDataController tasksAsAPropertyList:newTask]];
    
    // Save the Array to NSUserDefaults
    [[NSUserDefaults standardUserDefaults]setObject:taskAsAPropertyListArray forKey:TASKS_NSUSERDEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Reload the TableView
    [self.tableView reloadData];
}

#pragma mark -

@end
