//
//  ViewController.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "CreateViewController.h"
#import "EmployeeList.h"
#import "AppDelegate.h"
#import "NetworkConnectivity.h"
#import "SynchronizationViewController.h"
#import "FBSession.h"
#import "LoginViewController.h"
#import "ResetPasswordViewController.h"
#import "DataAdapterEmployeeList.h"
#import "LoadRemoteDataClass.h"

@implementation MenuViewController

@synthesize syncButton;
@synthesize logoutButton;
@synthesize EditButton;
@synthesize createButton;
@synthesize scrollViewController;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scrollViewController setScrollEnabled:YES];
    [scrollViewController setContentSize: CGSizeMake(320, 600)];
	
}

- (void)viewDidUnload
{
    [self setCreateButton:nil];
    [self setEditButton:nil];
    [self setSyncButton:nil];
    [self setLogoutButton:nil];
    [self setChangePasswordButton:nil];
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    Reachability *reachability = [ Reachability reachabilityForInternetConnection];
    BOOL connectivity = [reachability startNotifier];
    if (connectivity == NO) 
    {
        syncButton.enabled = NO; 
    }
    else
    {
        syncButton.enabled = YES;   
                
    }

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


//Auto rotation functionality enabled here....

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES ;
}



// action method definition for create , edit, sync....


//to redirect the create new employee module....

- (IBAction)onClickCreateButton:(id)sender 
{
    
    CreateViewController *createViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        createViewController = [[CreateViewController alloc] initWithNibName:@"CreateViewController_iPhone" bundle:nil];
    } 
    else 
    {
        createViewController = [[CreateViewController alloc] initWithNibName:@"CreateViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:createViewController animated:YES];
}

//to redirect the edit existing employee module...

- (IBAction)onClickEditButton:(id)sender 
{
    
    EmployeeList *employeeList = nil;      
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        employeeList = [[EmployeeList alloc]initWithNibName:@"EmployeeList_iPhone" bundle:nil];     
    } 
    else 
    {
       employeeList = [[EmployeeList alloc]initWithNibName:@"EmployeeList_iPad" bundle:nil];
        
    }
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray = [[NSMutableArray alloc]init];
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray = [[NSMutableArray alloc]init];
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray = [[NSMutableArray alloc]init];
    
    
    LoadRemoteDataClass *loadRemoteData = [[LoadRemoteDataClass alloc] init];
    
    
    
    NSNumber *maxSize = [[NSNumber alloc] initWithInt:10];
    //int temp= max+1;
    NSNumber *newOffset = [[NSNumber alloc]initWithInt:0];
    //[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset:-1];
    [loadRemoteData getRemoteDataPrevious:maxSize  :newOffset];

    maxSize = [[NSNumber alloc] initWithInt:10];
    //int temp= max+1;
    newOffset = [[NSNumber alloc]initWithInt:10];
    [loadRemoteData getRemoteDataNext:maxSize  :newOffset];
    //[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset:1];
    
    [self.navigationController pushViewController:employeeList animated:YES];
 
   
}

//to redirect the synchronize module...

- (IBAction)onClickSyncButton:(id)sender 
{
    
    NetworkConnectivity *networkConnectivity = [[NetworkConnectivity alloc]init];
    BOOL status= [networkConnectivity checkConnection];
    
    if (status == YES) 
    {
        SynchronizationViewController *syncViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        {
            syncViewController = [[SynchronizationViewController alloc]initWithNibName:@"SynchronizationViewController_iPhone" bundle:nil];
        } 
        else 
        {
            syncViewController = [[SynchronizationViewController alloc]initWithNibName:@"SynchronizationViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:syncViewController animated:YES];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to sync with server" 
                                                        message:@"Please Make sure your device connected with internet" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
}


//Logout option close the current user, and goes to the loginView...

- (IBAction)onClickLogoutButton:(id)sender 
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    LoginViewController *loginViewController =nil;
    UINavigationController *navController =nil;// [[UINavigationController alloc] initWithRootViewController:loginViewController];
    EmployeeList *emp =[[EmployeeList alloc]init];
    emp.regularEmpFlag = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        loginViewController = [[LoginViewController alloc]  initWithNibName:@"LoginViewController_iPhone"bundle:nil];
        
    }
    
    else
    {
        loginViewController = [[LoginViewController alloc]  initWithNibName:@"LoginViewController_iPad"bundle:nil];
        
    }
    navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    appDelegate.window.rootViewController = navController;
}

- (IBAction)onClickChangePass:(id)sender
{
    
   
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
        
        Reachability *reachability = [ Reachability reachabilityForInternetConnection];
        BOOL connectivity = [reachability startNotifier];
        ResetPasswordViewController *resetPassword;
        if (connectivity == YES)
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                //For iPhone redirection....
                resetPassword = [[ResetPasswordViewController alloc]initWithNibName:@"ResetPasswordViewController_iPhone" bundle:nil];
                
            }
            else
            {
                //For iPad redirection....
                resetPassword = [[ResetPasswordViewController alloc]initWithNibName:@"ResetPasswordView_iPad" bundle:nil];
                //[self.navigationController pushViewController:resetPassword animated:YES];
            }
            [self.navigationController pushViewController:resetPassword animated:YES];
            
        }
        else
        {
            // Inform the user network is not available and allow him to work in offline.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable"
                                                            message:@"Password can't be changed"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
        
   
}
@end
