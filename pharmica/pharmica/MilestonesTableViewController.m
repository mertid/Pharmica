//
//  RegulatoryMilestonesTableViewController.m
//  pharmica
//
//  Created by Di Kong on 2/27/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "MilestonesTableViewController.h"
#import "AppDelegate.h"
#import "Milestone.h"

@interface MilestonesTableViewController ()

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSArray *milestoneList;
@property (nonatomic) NSIndexPath *editingIndexPath;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) UIDatePicker *plannedPicker;
@property (nonatomic) UIDatePicker *actualPicker;
@property (nonatomic) UIDatePicker *adjustedPicker;

@end

@implementation MilestonesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdel.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Milestone"];
    NSError *error;
    self.milestoneType = @"clinical";
    [request setPredicate:[NSPredicate predicateWithFormat:@"type = %@", self.milestoneType]];
    self.milestoneList = [context executeFetchRequest:request error:&error];
    self.title = [NSString stringWithFormat:@"%@ Milestone", self.milestoneType.capitalizedString];
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateStyle:NSDateFormatterFullStyle];
    [self.formatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.plannedPicker = [[UIDatePicker alloc] init];
    self.plannedPicker.datePickerMode = UIDatePickerModeDate;
    [self.plannedPicker addTarget:self action:@selector(plannedPickerValueChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    self.actualPicker = [[UIDatePicker alloc] init];
    self.actualPicker.datePickerMode = UIDatePickerModeDate;
    [self.actualPicker addTarget:self action:@selector(actualPickerValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    
    self.adjustedPicker = [[UIDatePicker alloc] init];
    self.adjustedPicker.datePickerMode = UIDatePickerModeDate;
    [self.adjustedPicker addTarget:self action:@selector(adjustedPickerValueChanged:)
             forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)plannedPickerValueChanged:(UIDatePicker *)sender {

    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    UITableViewCell *editingCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
    UITextField *plannedField = (UITextField *)[editingCell viewWithTag:2];
    Milestone *milestone = self.milestoneList[self.editingIndexPath.row];
    plannedField.text = [self.formatter stringFromDate:sender.date];
    milestone.planned = sender.date;
    [appdel saveContext];
}

- (IBAction)actualPickerValueChanged:(UIDatePicker *)sender {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    UITableViewCell *editingCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
    UITextField *actualField = (UITextField *)[editingCell viewWithTag:3];
    Milestone *milestone = self.milestoneList[self.editingIndexPath.row];
    actualField.text = [self.formatter stringFromDate:sender.date];
    milestone.actual = sender.date;
    [appdel saveContext];
}

- (IBAction)adjustedPickerValueChanged:(UIDatePicker *)sender {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    UITableViewCell *editingCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
    UITextField *adjustedField = (UITextField *)[editingCell viewWithTag:4];
    Milestone *milestone = self.milestoneList[self.editingIndexPath.row];
    adjustedField.text = [self.formatter stringFromDate:sender.date];
    milestone.adjusted = sender.date;
    [appdel saveContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.milestoneList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.tag = indexPath.row * 10;
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UITextField *plannedField = (UITextField *)[cell viewWithTag:2];
    UITextField *actualField = (UITextField *)[cell viewWithTag:3];
    UITextField *adjustedField = (UITextField *)[cell viewWithTag:4];
    Milestone *milestone = self.milestoneList[indexPath.row];
    nameLabel.text = milestone.name;
    plannedField.text = [self.formatter stringFromDate:milestone.planned];
    plannedField.inputView = self.plannedPicker;
    plannedField.delegate = self;
    actualField.text = [self.formatter stringFromDate:milestone.actual];
    actualField.inputView = self.actualPicker;
    actualField.delegate = self;
    adjustedField.text = [self.formatter stringFromDate:milestone.adjusted];
    adjustedField.inputView = self.adjustedPicker;
    adjustedField.delegate = self;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UITableViewCell *sectionHeader = [tableView dequeueReusableCellWithIdentifier:@"SectionHeader"];
    return sectionHeader;
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    NSInteger editingTag = textField.superview.tag;
    UITableViewCell *editingCell = (UITableViewCell *)[self.tableView viewWithTag:editingTag];
    self.editingIndexPath = [self.tableView indexPathForCell:editingCell];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    self.editingIndexPath = nil;
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
