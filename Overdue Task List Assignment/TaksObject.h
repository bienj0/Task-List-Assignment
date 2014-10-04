//
//  TaksObject.h
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaksObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

- (id)initWithData:(NSDictionary *)data;


@end
