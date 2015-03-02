//
//  pharmicaTests.m
//  pharmicaTests
//
//  Created by Merritt Tidwell on 2/27/15.
//  Copyright (c) 2015 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "Milestone.h"

@interface pharmicaTests : XCTestCase

@property AppDelegate *appdel;

@end

@implementation pharmicaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSArray *regList = @[@"IMPD",
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
    NSArray *cliList = @[@"Preclinical Data Available",
                         @"Program Start",
                         @"Program End",
                         @"First First In Man",
                         @"Clinical Investigator Brochure Available",
                         @"End of Phase I",
                         @"Go/No Go - Phase II",
                         @"Phase II Start",
                         @"Go/No Go - Phase III",
                         @"Phase III Start",
                         @"Last Patient Last Visit",
                         @"Last Data Available",
                         @"Combined Technical Document",
                         @"Phase IV Start"];
    
    
    NSArray * studyList = @[@"Draft Protocol Available",
                            @"Transfer of Obligation",
                            @"Study Start Date",
                            @"Study End Date",
                            @"Final Protocol Available",
                            @"Informed Consent Available",
                            @"Contract Template Available",
                            @"Drug Available",
                            @"Labels Available",
                            @"Other Clinical Supplies Available",
                            @"First Patient Enrolled",
                            @"Last Patient Enrolled",
                            @"First Patient Screened",
                            @"Last Patient Screened",
                            @"First Patient Randomized",
                            @"Last Patient Randomized",
                            @"Last Patient Last Visit",
                            @"Last Data Avaliable",
                            @"Data Base Lock",
                            @"Clinical Study Report",
                            @"Trial Master File Archived",
                            ];
    
    self.appdel = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = self.appdel.managedObjectContext;
    for (NSString *s in regList) {
        Milestone *ms = [NSEntityDescription insertNewObjectForEntityForName:@"Milestone"
                                                      inManagedObjectContext:context];
        [ms setName:s];
        [ms setType:@"regulatory"];
        [ms setAttribute:@"program"];
        [context insertObject:ms];
        [self.appdel saveContext];
    }
    for (NSString *s in cliList) {
        Milestone *ms = [NSEntityDescription insertNewObjectForEntityForName:@"Milestone"
                                                      inManagedObjectContext:context];
        [ms setName:s];
        [ms setType:@"clinical"];
        [ms setAttribute:@"program"];
        [context insertObject:ms];
        [self.appdel saveContext];
    }
    for (NSString *s in studyList) {
        Milestone *ms = [NSEntityDescription insertNewObjectForEntityForName:@"Milestone"
                                                      inManagedObjectContext:context];
        [ms setName:s];
        [ms setType:@"regulatory"];
        [ms setAttribute:@"study"];
        [context insertObject:ms];
        [self.appdel saveContext];


        
    }



}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCoreDataFetch {
    
    NSManagedObjectContext *context = self.appdel.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Milestone"];
    NSError *error;
    [request setPredicate:[NSPredicate predicateWithFormat:@"type = 'regulatory'"]];
    NSArray *milestoneList = [context executeFetchRequest:request error:&error];
    for (Milestone *ms in milestoneList) {
        NSLog(@"%@", ms);
    }
}

/*- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}*/

@end
