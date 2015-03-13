//
//  Milestone.h
//  pharmica
//
//  Created by Di Kong on 3/4/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface Milestone : NSManagedObject

@property (nonatomic, retain) NSDate * actual;
@property (nonatomic, retain) NSDate * adjusted;
@property (nonatomic, retain) NSString * associatedCategory;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * planned;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * associatedName;

@end
