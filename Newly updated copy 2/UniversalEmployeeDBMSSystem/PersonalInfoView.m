//
//  PersonalInfoView.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PersonalInfoView.h"

#import "TabBarController.h"

@implementation PersonalInfoView


@synthesize empDOBText;
@synthesize dobFlag;
@synthesize fnameFlag,lnameFlag;
@synthesize tabBar;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(PersonalInfoView);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
                //edit
               // self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
        
        }        // Custom initialization
    
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
    
    [self setEmpDOBText:nil];
    [self setEmpLastNameText:nil];
    [self setEmpFirstNameText:nil];
    [super viewDidUnload];
    
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    //self.title = @"Personal information";
    //[TabBarController sharedTabBarController].
   
    [self deployPersonalInfo];
    
    self.empDOBText.enabled = NO;
    self.empFirstNameText.enabled = NO;
    self.empLastNameText.enabled = NO;
    
//    NSMutableDictionary *Data =[[NSMutableDictionary alloc]initWithDictionary:[TabBarController sharedTabBarController].employeeRecord];
//    NSNumber *employeeId = [Data objectForKey:@"employeeId"];
//    [OfficialInfoVIew sharedOfficialInfoVIew].empEmpIdText.text = [NSString stringWithFormat:@"%@",employeeId];
//    [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.text = [Data objectForKey:@"employeeHireDate"];
//    
//    [OfficialInfoVIew sharedOfficialInfoVIew].empRoleText.text = [Data objectForKey:@"role"];
    
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)deployPersonalInfo
{
    NSMutableDictionary *Data =[[NSMutableDictionary alloc]initWithDictionary:[TabBarController sharedTabBarController].employeeRecord];
    self.empFirstNameText.text = [Data objectForKey:@"employeeFirstName"];
    self.empLastNameText.text = [Data objectForKey:@"employeeLastName"];
    self.empDOBText.text = [Data objectForKey:@"dob"];
   
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField == self.empDOBText)
    {
        [textField resignFirstResponder]; //the textField that you will set the selected date
        datePicker = [[UIDatePicker alloc] init]; //declared uidatepicker component
        
        pickerViewDate = [[UIActionSheet alloc] initWithTitle:@"Select the date!"
                                                     delegate:nil
                          
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
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
        [datePicker addTarget:self action:@selector(dateChanged1) forControlEvents:UIControlEventValueChanged]; //the function would be fired when user change the date in datePicker
        
        //now preparing the toolbar which will be displayed at the top of the datePicker
        pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 464)];
        pickerToolbar.barStyle=UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked1)];
        //barbutton item is "DONE" and doneButtonClicked action will be fired when user clicks the button.
        [barItems addObject:flexSpace]; // set the left of the bar
        
        [pickerToolbar setItems:barItems animated:YES];
        [pickerViewDate addSubview:pickerToolbar];
        [pickerViewDate addSubview:datePicker];
        [pickerViewDate showInView:self.view];
        [pickerViewDate setBounds:CGRectMake(0,0,320, 464)]; //you can change the position
        
    }
}
-(void)applicationDidFinishLaunching:(UIApplication *)application
{
   tabBar.delegate = self;
}

-(IBAction)dateChanged1
{
    empDOBText.text = @"";
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
    empDOBText.text = [FormatDate stringFromDate:[datePicker date]];
}

-(BOOL)closeDatePicker1
{
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    [empDOBText resignFirstResponder];
    return YES;
}


-(IBAction)doneButtonClicked1
{
    [self closeDatePicker1];
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.empFirstNameText)
    {
        self.fnameFlag = YES;
    }
    else if(textField == self.empLastNameText)
    {
        self.lnameFlag = YES;
    }
    else if(textField == empDOBText)
    {
        self.dobFlag = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    
    if(theTextField == self.empFirstNameText)
    {
        [theTextField resignFirstResponder];
        
    }
    else if(theTextField == self.empLastNameText)
    {
        [theTextField resignFirstResponder];
        
    }
    else if(theTextField == self.empDOBText)
    {
        [theTextField resignFirstResponder];
        
    }
    return YES;
}

- (void)textDidChange:(NSNotification *)aNotification
{
    
}



@end
