//
//  Program.h
//  pharmica
//
//  Created by Masih Tabrizi on 3/3/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Program : NSManagedObject

@property (nonatomic, retain) NSNumber * adjustedBudget;
@property (nonatomic, retain) NSNumber * budgetRemaining;
@property (nonatomic, retain) NSNumber * budgetSpent;
@property (nonatomic, retain) NSString * compound;
@property (nonatomic, retain) NSString * corporatedObjective;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * indication;
@property (nonatomic, retain) NSNumber * investigatioonalDrugApplicationField;
@property (nonatomic, retain) NSString * planedEndDate;
@property (nonatomic, retain) NSNumber * plannedBaselineBudget;
@property (nonatomic, retain) NSString * plannedStartDate;
@property (nonatomic, retain) NSString * programAdminstration;
@property (nonatomic, retain) NSString * programDescription;
@property (nonatomic, retain) NSString * programLead;
@property (nonatomic, retain) NSString * programName;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * therapeuticArea;
@property (nonatomic, retain) NSString * typeOfInvestigationalDrugApplication;

@end
