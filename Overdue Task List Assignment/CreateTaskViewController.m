//
//  CreateTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "CreateTaskViewController.h"

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    TaksObject *newSpaceObject = [self returnTaskObject];
    [self.delegate createTask:newSpaceObject];
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

-(TaksObject *)returnTaskObject
{
    TaksObject *addedTaskObject = [[TaksObject alloc] init];
    addedTaskObject.title = self.addTaskNameTextField.text;
    addedTaskObject.taskDescription = self.descriptionTaskTextView.text;
    addedTaskObject.date = self.taskDueDatePicker.date;
    addedTaskObject.completion = NO;
    
    return addedTaskObject;
}

@end
