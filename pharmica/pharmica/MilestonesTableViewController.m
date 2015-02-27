//
//  RegulatoryMilestonesTableViewController.m
//  pharmica
//
//  Created by Di Kong on 2/27/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "MilestonesTableViewController.h"

@interface MilestonesTableViewController ()

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSArray *regulatoryMilestones;

@end

@implementation MilestonesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.milestoneType = @"regulatory";
    self.regulatoryMilestones = @[@"IMPD",
                                  @"BLA Submission",
                                  @"BLA Approval",
                                  @"eIND Submission",
                                  @"eIND Approval",
                                  @"IND Submission",
                                  @"IND Approval",
                                  @"INDA Submission",
                                  @"INDa Approval",
                                  @"NDA Submission",
                                  @"NDA Approval",
                                  @"sNDA Submission",
                                  @"sNDA Approval",
                                  @"JNDA Submission",
                                  @"JNDA Approval",
                                  @"ANDA Submission",
                                  @"ANDA Approval",
                                  @"WMA Submission",
                                  @"WMA Approval",
                                  @"PIP Submission",
                                  @"PIP Approval",
                                  @"HDE Submission",
                                  @"HDE Approval"];
    self.title = [NSString stringWithFormat:@"%@ Milestone", self.milestoneType.capitalizedString];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.regulatoryMilestones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UITextField *nameField = (UITextField *)[cell viewWithTag:1];
    nameField.text = self.regulatoryMilestones[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UITableViewCell *sectionHeader = [tableView dequeueReusableCellWithIdentifier:@"SectionHeader"];
    return sectionHeader;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
