//
//  EditTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "EditTaskViewController.h"
#import "ViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.editTaskNameTextField.text = self.task.title;
    self.editDescriptionTaskTextView.text = self.task.taskDescription;
    self.editDatePicker.date = self.task.date;
    
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



- (IBAction)saveButtonPressed:(UIButton *)sender
{
    [self didSaveTask];
    [self.delegate didSave];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

#pragma mark - Helper Methods

-(void)didSaveTask
{
    self.task.title = self.editTaskNameTextField.text;
    self.task.taskDescription = self.editDescriptionTaskTextView.text;
    self.task.date = self.editDatePicker.date;
    
}

@end
