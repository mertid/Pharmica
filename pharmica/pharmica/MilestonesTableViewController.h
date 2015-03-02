//
//  RegulatoryMilestonesTableViewController.h
//  pharmica
//
//  Created by Di Kong on 2/27/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MilestonesTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *milestoneType;

@end
