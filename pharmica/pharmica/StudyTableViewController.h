//
//  StudyTableViewController.h
//  pharmica
//
//  Created by Merritt Tidwell on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface StudyTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, copy) NSString *milestoneType;  // Regulatory or Clinical
@property (nonatomic, copy) NSString *associatedCategory;  // Study or Program
@property (nonatomic, copy) NSString *associatedName;       // Name of the study/program



@end
