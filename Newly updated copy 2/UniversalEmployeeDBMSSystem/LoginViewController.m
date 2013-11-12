//
//  MyLoginControl.m
//  MyLoginTest
//
//  Created by Yokesh on 9/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

#import "EmployeeDetails.h"
#import "ValidationClass.h"
#import "MenuViewController.h"
#import "LoadRemoteDataClass.h"
#import "FBSession.h"
#import "Reachability.h"
#import "SampleLoginDatabase.h"
#import "EmployeeList.h"
#import "FacebookSDK.h"
#import "Facebook.h"
#import "RemoteLoginCredential.h"
#import "DataAdapterEmployeeList.h"
#import "ResetPasswordViewController.h"

@implementation LoginViewController

@synthesize LoginButton;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize submitButton;
@synthesize successfulLoginMessage;
@synthesize spinner;
@synthesize window = _window;
@synthesize wifiReachability,internetReachability,hostReachability;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];     
        
        Reachability *reachability = [ Reachability reachabilityForInternetConnection];
        BOOL connectivity = [reachability startNotifier];
        if (connectivity == YES) 
        {
            
        }
        else
        {
            // Inform the user network is not available and allow him to work in offline.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable" 
                                                            message:@"Start working in off-line" 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        //[[DatabaseConnectivity sharedDatabaseConnectivity] loadEmployeeDatabase];

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
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setSubmitButton:nil];
    [self setSuccessfulLoginMessage:nil];
    [self setLoginButton:nil];
    [self setResetButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    // reset the fields, once we come back here again after a successful view.
    [self.navigationController setNavigationBarHidden:YES];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    
}   


- (IBAction)okButtonTouchUpInside:(id)sender 
{
    
    NSString *userName = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if([userName isEqualToString:@""]&&[password isEqualToString:@""])
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"Sorry, unable to login"                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        self.usernameTextField.text=@"";
        self.passwordTextField.text=@"";
        return;        
        
    }
    else if(([userName isEqualToString:@""])&&(![password isEqualToString:@""]))
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"Enter username"                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        self.usernameTextField.text=@"";
        self.passwordTextField.text=@"";
        return;        
        
    }
    else if((![userName isEqualToString:@""])&&([password isEqualToString:@""]))
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"Sorry, unable to login"                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
        
        self.usernameTextField.text=@"";
        self.passwordTextField.text=@"";
        return;               
                
    }
    
    else
    {
        int resultStatus= [[RemoteLoginCredential sharedRemoteLoginCredential] checkCredential:userName :password];
        
        if(resultStatus == 1)
        {
            //admin emp page view controller.....
            MenuViewController *menuViewController= nil;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
            {
                menuViewController = [[MenuViewController alloc]  initWithNibName:@"MenuViewController_iPhone"bundle:nil];
                [self.navigationController pushViewController:menuViewController animated:YES];       
            } 
            else 
            {
                menuViewController = [[MenuViewController alloc]  initWithNibName:@"MenuViewController_iPad"bundle:nil];
                [self.navigationController pushViewController:menuViewController animated:YES]; 
            }
                                                    
        }
       
        else if(resultStatus == 0)
        {
            //regular emp page view controller.......
       
         
            EmployeeList *employeeList = nil;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
            {
            
                employeeList = [[EmployeeList alloc]  initWithNibName:@"EmployeeList_iPhone"bundle:nil];
                  
            } 
            else 
            {
                employeeList = [[EmployeeList alloc]  initWithNibName:@"EmployeeList_iPad"bundle:nil];

            
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
            employeeList.regularEmpFlag=YES;
            employeeList.editButton.hidden = YES;
            employeeList.cancelButton.hidden = YES;
            employeeList.updateButton.hidden = YES;
        
            [self.navigationController pushViewController:employeeList animated:YES]; 
       
        }
        else
        {
            //login failed
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"Sorry, unable to login :"                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       
            [alertView show];
       
            //self.usernameTextField.text=@"";
            self.passwordTextField.text=@"";

        }
        
    }
    
}




- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


//opening the facebook session and utilize it for the option 'Login with facebook'.






- (IBAction)FbLoginButton:(id)sender
{
    
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray = [[NSMutableArray alloc]init];
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray = [[NSMutableArray alloc]init];
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray = [[NSMutableArray alloc]init];
    

     LoadRemoteDataClass *loadRemoteData = [[LoadRemoteDataClass alloc] init];
    NSNumber *maxSize = [[NSNumber alloc] initWithInt:10];
       NSNumber *newOffset = [[NSNumber alloc]initWithInt:0];
 
    [loadRemoteData getRemoteDataPrevious:maxSize  :newOffset];
    //
    maxSize = [[NSNumber alloc] initWithInt:10];
    //           
    newOffset = [[NSNumber alloc]initWithInt:10];
    [loadRemoteData getRemoteDataNext:maxSize  :newOffset];
    
    [self.spinner stopAnimating];
    [self openSession];
    
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    
    switch (state)
    {
        case FBSessionStateOpen:
        {
            
            EmployeeList *employeeList=nil;
            //  PersonalInfoView *personalInfoView = [[PersonalInfoView alloc]init];
            
                       
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                
                employeeList = [[EmployeeList alloc]initWithNibName:@"EmployeeList_iPhone" bundle:nil];
                
            }
            else
            {
                employeeList = [[EmployeeList alloc]initWithNibName:@"EmployeeList1_iPad" bundle:nil];
                
            }
            employeeList.regularEmpFlag = YES;
            
           
            
            
//            
          
            employeeList.regularEmpFlag=YES;
            employeeList.editButton.hidden = YES;
            employeeList.cancelButton.hidden = YES;
            employeeList.updateButton.hidden = YES;
            //[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset:1];
            [self.navigationController pushViewController:employeeList animated:YES];
            
        }
            break;
            
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}


- (void)openSession
{
    
    NSArray *array = [NSArray arrayWithObjects:@"email" , nil];
    
    [FBSession openActiveSessionWithReadPermissions:(NSArray*) array allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
     {
        
         
         NSLog(@"%d",state);
         [self sessionStateChanged:session state:state error:error];
         
     }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{  
    
    return [FBSession.activeSession handleOpenURL:url]; 
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [FBSession.activeSession handleDidBecomeActive];
}

//If login failed stop going to the next view controller......





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == usernameTextField)
        [passwordTextField becomeFirstResponder];
    else if(textField == passwordTextField)
        [textField resignFirstResponder];
    return YES;
    
}



@end
