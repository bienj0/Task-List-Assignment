//
//  TaksObject.m
//  Overdue Task List Assignment
//
//  Created by Robin van 't Slot on 27-09-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "TaksObject.h"
#import "Constants.h"

@implementation TaksObject

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.title = data[TITLE];
    self.taskDescription = data[DESCRIPTION];
    self.date = data[DATE];
    self.completion = [data[COMPLETION] boolValue];
    
    return self;
}

@end
