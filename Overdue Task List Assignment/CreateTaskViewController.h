//
//  CreateTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaksObject.h"

@protocol CreateTaskViewControllerDelegate <NSObject>


@required

-(void)didCancel;
-(void)createTask:(TaksObject *)taskObject;

@end

@interface CreateTaskViewController : UIViewController

@property (weak, nonatomic) id <CreateTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *addTaskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDatePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;

- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
