//
//  ViewController.h
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaksObject.h"
#import "EditTaskViewController.h"

@protocol ViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface ViewController : UIViewController  <EditTaskViewControllerDelegate>

@property (strong, nonatomic) TaksObject *task;
@property (strong, nonatomic) id <ViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionTaskLabel;
@property (strong, nonatomic) IBOutlet UILabel *dueDateTaskLabel;

- (IBAction)editButtonPressed:(UIButton *)sender;

@end

