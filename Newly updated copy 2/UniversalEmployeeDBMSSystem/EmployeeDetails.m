//
//  EmployeeDetails.m
//  EmployeeDBMS
//
//  Created by Yokesh on 9/30/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EmployeeDetails.h"
#import "EmployeeList.h"
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "FBSession.h"
#import "FacebookSDK.h"

@implementation EmployeeDetails

@synthesize empIdText;
@synthesize empNameText;
@synthesize empDojText;
@synthesize empDobText;
@synthesize empContactText;
@synthesize cancelButton;
@synthesize saveButton;
@synthesize editButton;
@synthesize empEmailText;
@synthesize tabController;
@synthesize scrollViewController;
@synthesize empAddressText;
@synthesize selectedEmployeeId;
@synthesize logoutButton;
@synthesize selectedEmpId;
@synthesize regularEmpViewFlag;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = selectedEmpId;
        
    }
    return self;
}


    
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self pickEmpRecord ];
    
    [scrollViewController setScrollEnabled:YES];
    [scrollViewController setContentSize: CGSizeMake(320, 600)];
    
}




-(void)viewWillAppear:(BOOL)animated
{
    if (regularEmpViewFlag == YES)
    {// to hiding the save,cancel,edit button for non-admin user
        logoutButton.hidden = NO;
        saveButton.hidden = YES;
        cancelButton.hidden = YES;
        editButton.hidden = YES;
    }
    else
    {// to hide the logout button for admin user
        logoutButton.hidden = YES;
        saveButton.hidden = NO;
        cancelButton.hidden = NO;
        editButton.hidden = NO;
    }
    //[self pickEmpRecord ];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //[scrollViewController setScrollEnabled:YES];
    //[scrollViewController setContentSize: CGSizeMake(320, 600)];
    NSArray *viewControllers = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers);

}



- (void)viewDidUnload
{
    [self setEmpIdText:nil];
    [self setEmpNameText:nil];
    [self setEmpDojText:nil];
    [self setEmpDobText:nil];
    [self setEmpContactText:nil];
    [self setEmpEmailText:nil];
    [self setEmpAddressText:nil];
    [self setSaveButton:nil];
    [self setEditButton:nil];
    [self setCancelButton:nil];
    [self setScrollViewController:nil];
    [self setLogoutButton:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}




//action to update the existing record....
- (IBAction)onClickSave:(id)sender {
    BOOL status;
    NSString *empId,*empName,*empDOJ,*empDOB,*empEmailId,*empContactNo,*empAddress;
    empId = empIdText.text;
    empName =empNameText.text;
    empDOJ = empDojText.text;
    empDOB = empDobText.text;
    empEmailId = empEmailText.text;
    empContactNo = empContactText.text;
    empAddress = empAddressText.text;
   // int empSyncFlag = 0;
    //status = [[DatabaseConnectivity sharedDatabaseConnectivity] updateEmployeeDatabase :(NSString*)empId:(NSString*)empName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress :(int)empSyncFlag];
    
    if (status == YES)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"UPDATE !" message:@"Succesfully updated ..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];           
                    [alertView show];    
        //load the updated value in linked list from employee database.
        //[[DatabaseConnectivity sharedDatabaseConnectivity] loadEmployeeDatabase];
    }
   
   

}


/*

-(void) pickEmpRecord 
{
    int i=0;
    myStructType *tempNode = [DatabaseConnectivity sharedDatabaseConnectivity].empInfoHead;
    for(;tempNode->next!=NULL;tempNode=tempNode->next)
    {
        NSString *tempString = [NSString stringWithFormat:@"%s", tempNode->eId];
        if(selectedEmployeeId == i)
        {
            tempString = [NSString stringWithFormat:@"%s", tempNode->eId];
            empIdText.text = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eName];
            empNameText.text = tempString;
            self.title = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eEmailId];
            empEmailText.text = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eDOJ];
            empDojText.text = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eDOB];
            empDobText.text = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eContactNo];
            empContactText.text = tempString;
            tempString = [NSString stringWithFormat:@"%s", tempNode->eAddress];
            empAddressText.text = tempString;
            empIdText.enabled = NO;
            empNameText.enabled = NO;
            empEmailText.enabled = NO;
            empDojText.enabled = NO;
            empDobText.enabled = NO;
            empContactText.enabled = NO;
            empEmailText.enabled = NO;
            empAddressText.enabled = NO;            
            cancelButton.enabled = NO;
            break;
        }
        else
            i=i+1;
        
    }
     
}*/

- (IBAction)onClickEdit:(id)sender {
    cancelButton.enabled = YES;
    empNameText.enabled = YES;
    empDojText.enabled = YES;
    empDobText.enabled = YES;
    empContactText.enabled = YES;
    empEmailText.enabled = YES;
    empAddressText.enabled = YES; 
}


- (IBAction)onClickCancel:(id)sender 
{
    [self pickEmpRecord];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.empNameText) {
        //[theTextField resignFirstResponder];
        [theTextField resignFirstResponder];
    }     
    else{
        
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void) popControllersNumber:(int)number
{
    if (number <= 1)
        [[self navigationController] popViewControllerAnimated:YES];
    else
    {
        NSArray* controller = [[self navigationController] viewControllers];
        int requiredIndex = [controller count] - number - 1;
        if (requiredIndex < 0) requiredIndex = 0;
        UIViewController* requireController = [[[self navigationController] viewControllers] objectAtIndex:requiredIndex];
        [[self navigationController] popToViewController:requireController animated:YES];
    }
}

- (IBAction)onClickLogoutButton:(id)sender {
    
    //Logout clears session and opens the loginview....
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *viewControllers4 = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers4);
    [[FBSession activeSession] closeAndClearTokenInformation];
    NSArray *viewControllers3 = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers3);
   
    LoginViewController *loginViewController =nil;
    
    UINavigationController *navigationController = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        loginViewController = [[LoginViewController alloc]  initWithNibName:
                               @"LoginViewController_iPhone"bundle:nil];
    } 
    
    else 
    {
        loginViewController = [[LoginViewController alloc]  initWithNibName:@"LoginViewController_iPad"bundle:nil];
               
    }
    
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    appDelegate.window.rootViewController = navigationController;   
    NSArray *viewControllers = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers);
    //[self.navigationController popViewControllerAnimated:NO];
    //[self popControllersNumber:[viewControllers count]-2];
    [self.navigationController dismissModalViewControllerAnimated:YES] ;
   // [self.navigationController dismissModalViewControllerAnimated:YES] ;
    [self performSelector:@selector(patchSelector) withObject:nil afterDelay:0.3];

//    NSArray *viewControllers1 = [[self navigationController] viewControllers];
//    NSLog(@" view Controllers : %@",viewControllers1);
//    [self.navigationController pushViewController:loginViewController animated:NO];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    //[self.navigationController pushViewController:loginViewController animated:NO];
}


-(void)patchSelector{
    [self.navigationController popToRootViewControllerAnimated:YES]; 
}
@end
