//
//  EditTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaksObject.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required

-(void)didSave;

@end

@interface EditTaskViewController : UIViewController

@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) TaksObject *task;

@property (strong, nonatomic) IBOutlet UITextField *editTaskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *editDescriptionTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editDatePicker;

- (IBAction)saveButtonPressed:(UIButton *)sender;

@end
