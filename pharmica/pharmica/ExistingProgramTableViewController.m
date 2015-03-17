//
//  ExistingProgramTableViewController.m
//  pharmica
//
//  Created by Masih Tabrizi on 3/2/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import "ExistingProgramTableViewController.h"
#import "MilestonesTableViewController.h"
#import "Program.h"
#import "AppDelegate.h"

@interface ExistingProgramTableViewController ()

@property (nonatomic) AppDelegate *app;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSUInteger selectedRow;

@end

@implementation ExistingProgramTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.app = [UIApplication sharedApplication].delegate;
    self.context = self.app.managedObjectContext;
    self.selectedRow = NSNotFound;
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
    NSError *error;
    self.programList = [self.context executeFetchRequest:req error:&error];
    
    [self.tableView reloadData];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.programList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgramCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Program *program = [self.programList objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [program valueForKey:@"programName"]]];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Type of milestone"
                                                                         message:@"Which type of milestone would you like to view?"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *regulatoryAction = [UIAlertAction actionWithTitle:@"Regulatory"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"showProgramMilestones" sender:action];
    }];
    UIAlertAction *clinicalAction = [UIAlertAction actionWithTitle:@"Clinical"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"showProgramMilestones" sender:action];
    }];
    /*UIAlertAction *dismissAlert = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];*/
    [actionSheet addAction:regulatoryAction];
    [actionSheet addAction:clinicalAction];
    /*[actionSheet addAction:dismissAlert];*/
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    actionSheet.popoverPresentationController.sourceView = cell.contentView;
    actionSheet.popoverPresentationController.sourceRect = cell.contentView.frame;
    [self presentViewController:actionSheet animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showProgramMilestones"]) {
        MilestonesTableViewController *destination = (MilestonesTableViewController *)segue.destinationViewController;
        UIAlertAction *senderAction = sender;
        NSString *type = senderAction.title.lowercaseString;
        if (self.selectedRow == NSNotFound) {
            NSLog(@"No row selected!");
            return;
        }
        Program *currentProgram = self.programList[self.selectedRow];
        [destination setMilestoneType:type];
        [destination setAssociatedCategory:@"program"];
        [destination setAssociatedName:currentProgram.programName];
    }
}


@end
