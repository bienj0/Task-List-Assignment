//
//  ViewController.m
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.taskNameLabel.text = self.task.title;
    self.descriptionTaskLabel.text = self.task.taskDescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dueDateTaskLabel.text = stringFromDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]){
        EditTaskViewController *editVC = segue.destinationViewController;
        editVC.task = self.task;
        editVC.delegate = self;
    }
}

- (IBAction)editButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"editTaskSegue" sender:sender];
}

-(void)didSave
{
    NSLog(@"DidSave");
    self.taskNameLabel.text = self.task.title;
    self.descriptionTaskLabel.text = self.task.taskDescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dueDateTaskLabel.text = stringFromDate;
    [self.delegate updateTask];
    
}

@end
