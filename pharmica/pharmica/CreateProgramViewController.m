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
//@property (nonatomic) NSDateFormatter *formatter;
//@property (nonatomic) UIDatePicker *PlannedStartPicker;
//@property (nonatomic) UIDatePicker *PlannedEndPicker;


@end

@implementation CreateProgramViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.app = [UIApplication sharedApplication].delegate;
//    self.context = self.app.managedObjectContext;
    
//    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
//    NSError *error;
    
//    self.formatter = [[NSDateFormatter alloc] init];
//    [self.formatter setDateStyle:NSDateFormatterFullStyle];
//    [self.formatter setTimeStyle:NSDateFormatterNoStyle];
//    
//    self.PlannedStartPicker = [[UIDatePicker alloc] init];
//    self.PlannedStartPicker.datePickerMode = UIDatePickerModeDate;
//    [self.PlannedStartPicker addTarget:self action:@selector(plannedStartPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//    
//    self.PlannedEndPicker = [[UIDatePicker alloc] init];
//    self.PlannedEndPicker.datePickerMode = UIDatePickerModeDate;
//    [self.PlannedEndPicker addTarget:self action:@selector(plannedEndPickerValueChanged:) forControlEvents:UIControlEventValueChanged];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)save:(id)sender {
    
    UITextField *textField;
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
        [newProgram setCorporatedObjective:textField.text];
        
        textField = self.fields[5];
        [newProgram setPlannedStartDate:textField.text];
        
        textField = self.fields[6];
        [newProgram setPlanedEndDate:textField.text];
        
        textField = self.fields[7];
        [newProgram setProgramLead:textField.text];
        
        textField = self.fields[8];
        [newProgram setProgramAdminstration:textField.text];
        
        textField = self.fields[9];
        [newProgram setPlannedBaselineBudget:@([textField.text doubleValue])];
        
        textField = self.fields[10];
        [newProgram setAdjustedBudget:@([textField.text doubleValue])];
        
        textField = self.fields[11];
        [newProgram setBudgetSpent:@([textField.text doubleValue])];
        
        textField = self.fields[12];
        [newProgram setCost:@([textField.text doubleValue])];
        
        textField = self.fields[13];
        [newProgram setBudgetRemaining:@([textField.text doubleValue])];

        textField = self.fields[14];
        [newProgram setStatus:textField.text];
        
//        textField = self.fields[15];
//        [newProgram setInvestigationalDrugApplicationField:[textField.text boolValue]];

        
        textField = self.fields[15];
        [newProgram setTypeOfInvestigationalDrugApplication:textField.text];


        [self.context insertObject:newProgram];
        [self.app saveContext];
        


    }
    [self.navigationController popViewControllerAnimated:YES];
}


    


//-(IBAction)plannedStartPickerValueChanged:(UIDatePicker *)sender {
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    
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
