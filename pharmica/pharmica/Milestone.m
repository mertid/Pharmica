//
//  Milestone.m
//  pharmica
//
//  Created by Di Kong on 3/4/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "Milestone.h"


@implementation Milestone

@dynamic actual;
@dynamic adjusted;
@dynamic associatedCategory;
@dynamic name;
@dynamic planned;
@dynamic type;
@dynamic associatedName;

- (NSString *)description {

    return [NSString stringWithFormat:@"name=%@  type=%@  planned=%@  actual=%@  adjusted=%@  associatedCategory=%@  associatedName=%@",
            self.name, self.type, self.planned, self.actual, self.adjusted, self.associatedCategory, self.associatedName];
}

@end
