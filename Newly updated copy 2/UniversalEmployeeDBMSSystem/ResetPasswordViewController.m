//
//  ResetPasswordViewController.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Sandeep Kumar Gupta on 24/10/13.
//
//
#define resetPasswordURL @"http://10.132.161.59:8080/EmployeeDetailsManagement/employee/reset"
#import "ResetPasswordViewController.h"
#import "LoadRemoteDataClass.h"

#import "Reachability.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
@implementation ResetPasswordViewController
@synthesize scrollViewController;
@synthesize emailIdField;
@synthesize oldPasswordText;
@synthesize passwordText;
@synthesize confPasswordText;
@synthesize loginPageButton;
@synthesize saveButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
//        
//        Reachability *reachability = [Reachability reachabilityForInternetConnection];
//        BOOL connectivity = [reachability startNotifier];
//        if (connectivity == YES)
//        {
//            // Prceed to work in both offline data, since network is available.
//            NSNumber *max = [[NSNumber alloc]initWithInt:3];
//            NSNumber *offset  = [[NSNumber alloc]initWithInt:1];
//            
//            LoadRemoteDataClass *loadRemoteDataClass =[[ LoadRemoteDataClass alloc]init] ;
//            [loadRemoteDataClass getRemoteData:max:offset];
//        }
//        else
//        {
//            // Inform the user network is not available and allow him to work in offline.
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable"
//                                                            message:@"Start working in off-line"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            
//        }
//        [[DatabaseConnectivity sharedDatabaseConnectivity] loadEmployeeDatabase];
//        
    
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scrollViewController setScrollEnabled:YES];
    [scrollViewController setContentSize:CGSizeMake(350,650) ];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmailIdField:nil];
    [self setPasswordText:nil];
    [self setConfPasswordText:nil];
    [self setSaveButton:nil];
    [self setOldPasswordText:nil];
    [self setLoginPageButton:nil];
    [super viewDidUnload];
}
- (IBAction)onClickSave:(id)sender
{
    NSString *userName = self.emailIdField.text;
    NSString *oldPassword = self.oldPasswordText.text;
    NSString *newPassword = self.passwordText.text;
    NSString *confPassword = self.confPasswordText.text;
    
    if ([newPassword isEqualToString:confPassword])
    {
        int result=[self resetPassword: userName : newPassword :oldPassword];
        if (result==1)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Saved" message:@"Password Successfully Changed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
           self.emailIdField.text = @"";
            self.oldPasswordText.text = @"";
            self.passwordText.text = @"";
            self.confPasswordText.text = @"";
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to change password" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            self.emailIdField.text = @"";
            self.oldPasswordText.text = @"";
            self.passwordText.text = @"";
            self.confPasswordText.text = @"";
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"new password and confirm password are not same" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        self.passwordText.text = @"";
        self.confPasswordText.text = @"";
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



-(int)resetPassword:(NSString *) userName :(NSString *) newPassword : (NSString *) oldPassWord
{
    
    
    NSURL *url = [NSURL URLWithString:resetPasswordURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    NSDictionary *empRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"email",newPassword,@"password" ,oldPassWord,@"oldPassword",nil];
    NSLog(@" **** empRecord %@",empRecord );
    //selectedEmailId = [empRecord objectForKey:@"email"];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:empRecord options:0 error:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    NSLog(@"jsonData : %@",jsonData);
    
    
    NSError *error;
    NSURLResponse * response = nil;
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (error == nil)
    {
        //responseData = [NSMutableData data];
            NSLog(@" ********Connection established ***** ");
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@" jsonString : %@",jsonString);
        NSError* error;
        NSMutableDictionary* json = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     
                                     options:kNilOptions
                                     error:&error];
        NSLog(@"json %@",json);
        if([[json objectForKey:@"message"] isEqualToString:@"password is changed"])
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}
- (IBAction)onClickLogin:(id)sender
{
    /*
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
      LoginViewController *loginViewController =nil;
    UINavigationController *navigationController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        //For iPhone redirection....
       loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    }
    else
    {
        //For iPad redirection....
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }

    NSArray *viewControllers = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers);
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    appDelegate.window.rootViewController = navigationController;
     
  */
   // [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    NSArray *viewControllers = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers);
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == emailIdField)
        [oldPasswordText becomeFirstResponder];
    else if(textField == oldPasswordText)
        [passwordText becomeFirstResponder];
    else if (textField ==passwordText)
        [confPasswordText becomeFirstResponder];
    else if (textField ==confPasswordText)
        [textField resignFirstResponder];
    return YES;
    
}
@end
