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
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) UIDatePicker *plannedPicker;
@property (nonatomic) UIDatePicker *actualPicker;
@property (nonatomic) UIDatePicker *adjustedPicker;
@property (nonatomic) UITextField *editingTextField;

@end

@implementation MilestonesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // These three properties should be passed in from another view controller
    // Im simply setting them here for test purpose
    self.milestoneType = @"clinical";
    self.attribute = @"program";
    self.name = @"Test Program";
    // Core data access
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdel.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Milestone"];
    NSError *error;
    // Predicate to fetch with type and attribute
    [request setPredicate:[NSPredicate predicateWithFormat:@"(type = %@) AND (attribute = %@)", self.milestoneType, self.attribute]];
    self.milestoneList = [context executeFetchRequest:request error:&error];
    self.title = [NSString stringWithFormat:@"%@ Milestone", self.milestoneType.capitalizedString];
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateStyle:NSDateFormatterLongStyle];
    [self.formatter setTimeStyle:NSDateFormatterNoStyle];
    // Background tap dismisses date picker
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // Date picker for planned date
    self.plannedPicker = [[UIDatePicker alloc] init];
    self.plannedPicker.datePickerMode = UIDatePickerModeDate;
    [self.plannedPicker addTarget:self action:@selector(plannedPickerValueChanged:)
            forControlEvents:UIControlEventValueChanged];
    // Date picker for actual date
    self.actualPicker = [[UIDatePicker alloc] init];
    self.actualPicker.datePickerMode = UIDatePickerModeDate;
    [self.actualPicker addTarget:self action:@selector(actualPickerValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    // Date picker for adjusted date
    self.adjustedPicker = [[UIDatePicker alloc] init];
    self.adjustedPicker.datePickerMode = UIDatePickerModeDate;
    [self.adjustedPicker addTarget:self action:@selector(adjustedPickerValueChanged:)
             forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboard {

    [self.view endEditing:YES];
}

- (IBAction)plannedPickerValueChanged:(UIDatePicker *)sender {

    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    // Get the cell of which the text field is contained in
    // superview = container, superview.superview = cell
    UITableViewCell *editingCell = (UITableViewCell *)self.editingTextField.superview.superview;
    NSIndexPath *editingIndexPath = [self.tableView indexPathForCell:editingCell];
    // Change text field text display and managedObject attribute
    self.editingTextField.text = [self.formatter stringFromDate:sender.date];
    Milestone *milestone = self.milestoneList[editingIndexPath.row];
    milestone.planned = sender.date;
    [appdel saveContext];
}

- (IBAction)actualPickerValueChanged:(UIDatePicker *)sender {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    // Get the cell of which the text field is contained in
    // superview = container, superview.superview = cell
    UITableViewCell *editingCell = (UITableViewCell *)self.editingTextField.superview.superview;
    NSIndexPath *editingIndexPath = [self.tableView indexPathForCell:editingCell];
    // Change text field text display and managedObject attribute
    self.editingTextField.text = [self.formatter stringFromDate:sender.date];
    Milestone *milestone = self.milestoneList[editingIndexPath.row];
    milestone.actual = sender.date;
    [appdel saveContext];
}

- (IBAction)adjustedPickerValueChanged:(UIDatePicker *)sender {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    // Get the cell of which the text field is contained in
    // superview = container, superview.superview = cell
    UITableViewCell *editingCell = (UITableViewCell *)self.editingTextField.superview.superview;
    NSIndexPath *editingIndexPath = [self.tableView indexPathForCell:editingCell];
    // Change text field text display and managedObject attribute
    self.editingTextField.text = [self.formatter stringFromDate:sender.date];
    Milestone *milestone = self.milestoneList[editingIndexPath.row];
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
    
    // Pointer to cell label & text fields
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UITextField *plannedField = (UITextField *)[cell viewWithTag:2];
    UITextField *actualField = (UITextField *)[cell viewWithTag:3];
    UITextField *adjustedField = (UITextField *)[cell viewWithTag:4];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    // Set up cell text fields and date picker popups
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

    // Return "SectionHeader" cells as header
    UITableViewCell *sectionHeader = [tableView dequeueReusableCellWithIdentifier:@"SectionHeader"];
    sectionHeader.backgroundColor = [UIColor lightGrayColor];
    return sectionHeader;
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    // Selected textfield is assigned to be visible to whole interface
    // so that other method has access to it (xxxPickerValueChanged)
    self.editingTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    // Editing done, assign nil to the property
    self.editingTextField = nil;
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
