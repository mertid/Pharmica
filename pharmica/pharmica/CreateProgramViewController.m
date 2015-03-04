//
//  CreateProgramViewController.m
//  pharmica
//
//  Created by Masih Tabrizi on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "CreateProgramViewController.h"
#import "AppDelegate.h"
#import "Program.h"

@interface CreateProgramViewController ()

@property (nonatomic) AppDelegate *app;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) UIDatePicker *plannedStartPicker;
@property (nonatomic) UIDatePicker *plannedEndPicker;
@property (nonatomic) UITextField *editingTextField;


@end

@implementation CreateProgramViewController {
        UITextField *textField;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // core data access
    self.app = [UIApplication sharedApplication].delegate;
    self.context = self.app.managedObjectContext;
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
    NSError *error;
    
    // set date formatter
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateStyle:NSDateFormatterLongStyle];
    [self.formatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Background tap dismisses date picker
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Date picker for Start planned date
    self.plannedStartPicker = [[UIDatePicker alloc] init];
    self.plannedStartPicker.datePickerMode = UIDatePickerModeDate;
    [self.plannedStartPicker addTarget:self action:@selector(plannedStartPickerValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    
    // Date picker for End planned date
    self.plannedEndPicker = [[UIDatePicker alloc] init];
    self.plannedEndPicker.datePickerMode = UIDatePickerModeDate;
    [self.plannedEndPicker addTarget:self action:@selector(plannedEndPickerValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    
    
    // set the date picker as the input
    textField = self.fields[6];
    textField.inputView = self.plannedStartPicker;
    
    textField = self.fields[7];
    textField.inputView = self.plannedEndPicker;

}

- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)plannedStartPickerValueChanged:(UIDatePicker *)sender {
    
    textField = self.fields[6];
    textField.text = [self.formatter stringFromDate:sender.date];
    textField.delegate = self;

}

-(IBAction)plannedEndPickerValueChanged:(UIDatePicker *)sender {
    
    textField = self.fields[7];
    textField.text = [self.formatter stringFromDate:sender.date];
    textField.delegate = self;
    
}


-(IBAction)save:(id)sender {
    
    textField = self.fields[0];
    
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Name for Program" message:@"Please enter a name for the program" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        
        Program *newProgram;
        self.context = self.app.managedObjectContext;
        newProgram = [NSEntityDescription insertNewObjectForEntityForName:@"Program" inManagedObjectContext:self.context];
        [newProgram setProgramName:textField.text];
        
        textField = self.fields[1];
        [newProgram setProgramDescription:textField.text];
        
        textField = self.fields[2];
        [newProgram setTherapeuticArea:textField.text];
        
        textField = self.fields[3];
        [newProgram setIndication:textField.text];
        
        textField = self.fields[4];
        [newProgram setCompound:textField.text];
        
        textField = self.fields[5];
        [newProgram setCorporatedObjective:textField.text];
        
        textField = self.fields[6];
        [newProgram setPlannedStartDate:[self.formatter dateFromString:textField.text]];
        
        textField = self.fields[7];
        [newProgram setPlannedStartDate:[self.formatter dateFromString:textField.text]];
        
        textField = self.fields[8];
        [newProgram setProgramLead:textField.text];
        
        textField = self.fields[9];
        [newProgram setProgramAdminstration:textField.text];
        
        textField = self.fields[10];
        [newProgram setPlannedBaselineBudget:@([textField.text doubleValue])];
        
        textField = self.fields[11];
        [newProgram setAdjustedBudget:@([textField.text doubleValue])];
        
        textField = self.fields[12];
        [newProgram setBudgetSpent:@([textField.text doubleValue])];
        
        textField = self.fields[13];
        [newProgram setCost:@([textField.text doubleValue])];
        
        textField = self.fields[14];
        [newProgram setBudgetRemaining:@([textField.text doubleValue])];

        textField = self.fields[15];
        [newProgram setStatus:textField.text];
        
        switch (self.segmentedControl.selectedSegmentIndex) {
            case 0:
                [newProgram setInvestigationalDrugApplicationField:[NSNumber numberWithBool:YES]];
                break;
            case 1:
                [newProgram setInvestigationalDrugApplicationField:[NSNumber numberWithBool:NO]];
            default:
                break;
        }
        
        textField = self.fields[16];
        [newProgram setTypeOfInvestigationalDrugApplication:textField.text];


        [self.context insertObject:newProgram];
        [self.app saveContext];
        


    }
    [self.navigationController popViewControllerAnimated:YES];
}
//
//#pragma mark - Text Field Delegate
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    // Selected textfield is assigned to be visible to whole interface
//    // so that other method has access to it (xxxPickerValueChanged)
//    self.editingTextField = textField;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    // Editing done, assign nil to the property
//    self.editingTextField = nil;
//}
    


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
