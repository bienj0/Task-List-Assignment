//
//  TaskListOverviewTableViewController.m
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "TaskListOverviewTableViewController.h"
#import "ViewController.h"
#import "Constants.h"

@interface TaskListOverviewTableViewController ()

@end

@implementation TaskListOverviewTableViewController

#pragma mark - Lazy Instantiation of Properties

- (NSMutableArray *)addedTaskObjects
{
  if (!_addedTaskObjects) {
        _addedTaskObjects = [[NSMutableArray alloc] init];
    }
    return _addedTaskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *myTasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY];
    for (NSDictionary *dictionary in myTasksAsPropertyLists){
        TaksObject *taskObject = [self taskObjectForDictionary:dictionary];
        [self.addedTaskObjects addObject:taskObject];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.addedTaskObjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TaksObject *taskObject = [self.addedTaskObjects objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = taskObject.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:taskObject.date];
    
    cell.detailTextLabel.text = stringFromDate;
    
    NSDate *date = [NSDate date];
    BOOL myBool = [self isDateGreaterThanDate:date and:taskObject.date];
    if (taskObject.completion == YES) cell.backgroundColor = [UIColor greenColor];
    else if (myBool == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaksObject *taskObject = self.addedTaskObjects[indexPath.row];
    [self updateCompletionOfTask:taskObject forIndexPath:indexPath];

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailViewSegue" sender:indexPath];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *newSaveTaskObjectData = [[NSMutableArray alloc] init];
        for (TaksObject *taskObject in self.addedTaskObjects){
            [newSaveTaskObjectData removeObject:[self taskObjectAsAPropertyList:taskObject]];
            [[NSUserDefaults standardUserDefaults] setObject:newSaveTaskObjectData forKey:ADDED_TASK_OBJECTS_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        // Delete the row from the data source
        [self.addedTaskObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[CreateTaskViewController class]]) {
        CreateTaskViewController *createTaskVC = segue.destinationViewController;
        createTaskVC.delegate = self;
    }
    else if([sender isKindOfClass:[NSIndexPath class]]){
        ViewController *detailVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        TaksObject *selectedObject = self.addedTaskObjects[path.row];
        detailVC.task = selectedObject;
        detailVC.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"createTaskSegue" sender:sender];
}

#pragma mark - CreateTaskViewController EditTaskViewController Delegate

-(void)didCancel
{
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)createTask:(TaksObject *)taskObject
{
    [self.addedTaskObjects addObject:taskObject];
    
    //Will save to NSUserDefaults here
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
    if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:taskObject]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

#pragma mark - ViewCOntroller delegate
-(void)updateTask
{
    [self.tableView reloadData];
    [self saveTasks];
    
}

#pragma mark = Helper methods

-(NSDictionary *)taskObjectAsAPropertyList:(TaksObject *)taskObject
{
    NSDictionary *dictionary = @{TITLE : taskObject.title, DESCRIPTION : taskObject.taskDescription, DATE : taskObject.date, COMPLETION : @(taskObject.completion)};
    
    return dictionary;
}

-(TaksObject *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    TaksObject *taskObject = [[TaksObject alloc] initWithData:dictionary];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    int firstDate = [date timeIntervalSince1970];
    int secondDate = [toDate timeIntervalSince1970];
    
    if (firstDate > secondDate){
        return YES;
    }
    else
    {
        
     return NO;
        
    }
}

-(void)updateCompletionOfTask:(TaksObject *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    if (task.completion == YES) task.completion = NO;
    else (task.completion = YES);
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];

}

-(void)saveTasks
{
    NSMutableArray *myTasksAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.addedTaskObjects count]; x++) {
        [myTasksAsPropertyLists addObject:[self taskObjectAsAPropertyList:self.addedTaskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:myTasksAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
