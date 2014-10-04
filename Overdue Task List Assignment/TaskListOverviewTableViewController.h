//
//  TaskListOverviewTableViewController.h
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateTaskViewController.h"
#import "ViewController.h"

@interface TaskListOverviewTableViewController : UITableViewController <CreateTaskViewControllerDelegate, ViewControllerDelegate>

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSMutableArray *addedTaskObjects;

@end
