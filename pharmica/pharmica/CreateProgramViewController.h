//
//  CreateProgramViewController.h
//  pharmica
//
//  Created by Masih Tabrizi on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProgramViewController : UIViewController
    <UITextFieldDelegate>

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *fields;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;


-(IBAction)save:(id)sender;

@end
