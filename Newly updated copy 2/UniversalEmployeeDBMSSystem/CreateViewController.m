//
//  CreateViewController.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CreateViewController.h"
#import "MenuViewController.h"
#import "ValidationClass.h"
#import "LocalDatabaseOperations.h"
#import <CommonCrypto/CommonDigest.h>


@implementation CreateViewController

@synthesize cancelButton;
@synthesize empAddressText;
@synthesize empEmailIdText;
@synthesize empContactNoText;
@synthesize empDOBText;
@synthesize empDOJText;
@synthesize empLNameText;
@synthesize empFNameText;
@synthesize saveButton;
@synthesize contentInset;
@synthesize scrollIndicatorInsets;
@synthesize empRoleText;
@synthesize empPasswordText;
@synthesize scrollViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title =@"New employee info";
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    // Release any cached data, images, etc that aren't in use.
    [super didReceiveMemoryWarning];
    
}


#pragma mark - View lifecycle

//Enable the auto rotation functionality through this method...
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
        
    [super viewDidLoad];
    
    [scrollViewController setScrollEnabled:YES];
    [scrollViewController setContentSize: CGSizeMake(320, 600)];

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
   
    [self setEmpAddressText:nil];
    [self setEmpEmailIdText:nil];
    [self setEmpContactNoText:nil];
    [self setEmpDOBText:nil];
    [self setEmpDOJText:nil];
    [self setEmpLNameText:nil];
    [self setEmpFNameText:nil];
    [self setSaveButton:nil];
    [self setCancelButton:nil];
    [self setScrollViewController:nil];
 
    [self setEmpRoleText:nil];
    
    [self setEmpPasswordText:nil];
    [super viewDidUnload];

    
}


//action to save the new employee record into local database.     
- (IBAction)onClickSaveButton:(id)sender 
{
    NSString *empFirstName,*empLastName,*empDOJ,*empDOB,*empEmailId,*empContactNo,*empAddress,*empPassword,*empRole;
    empFirstName = self.empFNameText.text;
    empLastName =self.empLNameText.text;
    empDOJ = self.empDOJText.text;
    empDOB = self.empDOBText.text;
    empEmailId = self.empEmailIdText.text;
    empContactNo = self.empContactNoText.text;
    empAddress = self.empAddressText.text;
    empPassword = self.empPasswordText.text;
    empRole = self.empRoleText.text;
    
    BOOL result = [ValidationClass validateFields:empFirstName :empLastName :empDOJ :empDOB :empEmailId :empContactNo :empAddress :empRole];
    if (result == FALSE)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Incomplete Entry" message:@"Fields (EmailId,Name,Role) are compulsary" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];           
        [alertView show];  
        
    }
     else
     {
         //NSString *encryptedPassword = [self md5:empPassword];

//         int empSyncFlag = 0;
//         NSString *type = @"local";
//         int offset =0;
         BOOL resultStatus = [[LocalDatabaseOperations sharedLocalDatabaseOperations] insertEmployeeDatabase :empFirstName:empLastName :empDOJ :empDOB :empEmailId :empContactNo :empAddress :empPassword :empRole ];
        if (resultStatus == YES)
         {
         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Saved temporarily!" message:@"Please post the data from sync option" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];           
        [alertView show];    
        [self emptyTheFields];
             //Add the new database entry to the linked list ....
           //  [[DatabaseConnectivity sharedDatabaseConnectivity] loadEmployeeDatabase];
         }
         else
         {
         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Duplicate Entry !" message:@"This EmpId is already exists" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];           
         [alertView show];    
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


- (IBAction)onClickCancelButton:(id)sender {
    
    [self emptyTheFields];    
}


-(void) emptyTheFields
{
    self.empFNameText.text =@"";
    self.empLNameText.text =@"";
    self.empDOBText.text =@"";
    self.empDOJText.text =@"";
    self.empContactNoText.text=@"";
    self.empEmailIdText.text =@"";
    self.empAddressText.text =@"";
    self.empRoleText.text =@"";
    self.empPasswordText.text=@"";
}

//first of all, you have to declare the datePicker and then use the following code; 

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == empDOJText)// || textField == empDOBText)
    {
    [textField resignFirstResponder]; //the textField that you will set the selected date
    datePicker = [[UIDatePicker alloc] init]; //declared uidatepicker component
    
    pickerViewDate = [[UIActionSheet alloc] initWithTitle:@"Select the date!"
                                                 delegate:self
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 300.0)];
    datePicker.datePickerMode = UIDatePickerModeDate; //set your spesific mode
    
    
    
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged]; //the function would be fired when user change the 
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle=UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)]; //
    [barItems addObject:flexSpace]; // set the left of the bar
    
    [pickerToolbar setItems:barItems animated:YES];
    [pickerViewDate addSubview:pickerToolbar];
    [pickerViewDate addSubview:datePicker];
    [pickerViewDate showInView:self.view];
    [pickerViewDate setBounds:CGRectMake(0,0,320, 464)]; //you can change the position
}
    else if( textField == empDOBText)
    {
        
        [textField resignFirstResponder]; //the textField that you will set the selected date
        datePicker = [[UIDatePicker alloc] init]; //declared uidatepicker component
        
        pickerViewDate = [[UIActionSheet alloc] initWithTitle:@"Select the date!"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 300.0)];
        }
        else
        {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0,320.0, 300.0)];
        }
        datePicker.datePickerMode =  UIDatePickerModeDate; //set your spesific mode
       
        
        [datePicker addTarget:self action:@selector(dateChanged1) forControlEvents:UIControlEventValueChanged]; //the function would be fired when user change the date in datePicker
        
        //now preparing the toolbar which will be displayed at the top of the datePicker
        pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 464)];
        pickerToolbar.barStyle=UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)]; 
        //barbutton item is "DONE" and doneButtonClicked action will be fired when user clicks the button.
        [barItems addObject:flexSpace]; // set the left of the bar
        
        [pickerToolbar setItems:barItems animated:YES];
        [pickerViewDate addSubview:pickerToolbar];
        [pickerViewDate addSubview:datePicker];
        [pickerViewDate showInView:self.view];
        [pickerViewDate setBounds:CGRectMake(0,0,320, 464)]; //you can change the position
    }
    

}
-(IBAction)dateChanged1{ 
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [FormatDate setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
    empDOBText.text = [FormatDate stringFromDate:[datePicker date]];
}

-(BOOL)closeDatePicker1:(id)sender{
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    [empDOJText resignFirstResponder];
    return YES;
}


-(IBAction)doneButtonClicked1{
    [self closeDatePicker1:self];
}


-(IBAction)dateChanged{ 
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    FormatDate = [[NSDateFormatter alloc] init];
     [FormatDate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [FormatDate setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
    empDOJText.text = [FormatDate stringFromDate:[datePicker date]];
}

-(BOOL)closeDatePicker:(id)sender{
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    [empDOJText resignFirstResponder];
    return YES;
}

-(IBAction)doneButtonClicked{
    [self closeDatePicker:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.empFNameText) {
        [self.empFNameText becomeFirstResponder];
    }    
    else if(theTextField == self.empLNameText) {
        [self.empDOJText becomeFirstResponder];
    } 
    else if(theTextField == self.empDOJText) {
        [self.empDOBText becomeFirstResponder];
        //[theTextField resignFirstResponder];
    }    
    else if(theTextField == self.empDOBText) {
        [self.empContactNoText becomeFirstResponder];
        //[theTextField resignFirstResponder];
    }    
    else if(theTextField == self.empContactNoText) {
        [self.empEmailIdText becomeFirstResponder];
    }    
    else if(theTextField == self.empEmailIdText) {
        [self.empAddressText becomeFirstResponder];
    }    
    else if(theTextField == self.empAddressText)
    {
        [self.empPasswordText becomeFirstResponder];
    }
    else if(theTextField == self.empPasswordText)
    {
        [self.empRoleText becomeFirstResponder];
    }
    else if(theTextField == self.empRoleText)
    {
        [theTextField resignFirstResponder];
        
    }
    
    return YES;
}


@end
