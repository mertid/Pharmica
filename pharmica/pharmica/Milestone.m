//
//  Milestone.m
//  pharmica
//
//  Created by Di Kong on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "Milestone.h"


@implementation Milestone

@dynamic name;
@dynamic type;
@dynamic planned;
@dynamic actual;
@dynamic adjusted;

- (NSString *)description
{
    return [NSString stringWithFormat:@"name=%@  type=%@  planned=%@  actual=%@  adjusted=%@",
            self.name, self.type, self.planned, self.actual, self.adjusted];
}

- (void)setPlannedDate:(UIDatePicker *)sender {

    self.planned = sender.date;
}

- (void)setActualDate:(UIDatePicker *)sender {

    self.actual = sender.date;
}

- (void)setAdjustedDate:(UIDatePicker *)sender {

    self.adjusted = sender.date;
}

@end
