//
//  Milestone.h
//  pharmica
//
//  Created by Di Kong on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface Milestone : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * planned;
@property (nonatomic, retain) NSDate * actual;
@property (nonatomic, retain) NSDate * adjusted;

- (IBAction)setPlannedDate:(UIDatePicker *)sender;
- (IBAction)setActualDate:(UIDatePicker *)sender;
- (IBAction)setAdjustedDate:(UIDatePicker *)sender;


@end
