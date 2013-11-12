//
//  OfficialInfoVIew.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "OfficialInfoVIew.h"
#import "TabBarController.h"
#import "RemoteDataUpdation.h"

@implementation OfficialInfoVIew


@synthesize empEmpIdText;
@synthesize empDOJText;
@synthesize empRoleText;
@synthesize updatedEmpRecord;
@synthesize datePicker;
@synthesize dateFormatter;
@synthesize pickerToolbar;
@synthesize pickerViewDate;
@synthesize dojFlag,roleFlag;


CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(OfficialInfoVIew);
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setEmpEmpIdText:nil];
    [self setEmpDOJText:nil];
    [self setEmpRoleText:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Official information";
    
    [self deployPersonalInfo];
   
    empEmpIdText.enabled = NO;
    empDOJText.enabled = NO;
    empRoleText.enabled = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)deployPersonalInfo
{
    NSMutableDictionary *Data =[[NSMutableDictionary alloc]initWithDictionary:[TabBarController sharedTabBarController].employeeRecord];
    
    NSNumber *employeeId = [Data objectForKey:@"employeeId"];
    self.empEmpIdText.text = [NSString stringWithFormat:@"%@",employeeId];
    self.empDOJText.text = [Data objectForKey:@"employeeHireDate"];
    
    self.empRoleText.text = [Data objectForKey:@"role"];
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField == self.empDOJText)
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


-(IBAction)dateChanged1
{
    empDOJText.text = @"";
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
    empDOJText.text = [FormatDate stringFromDate:[datePicker date]];
}

-(BOOL)closeDatePicker1
{
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    [empDOJText resignFirstResponder];
    return YES;
}


-(IBAction)doneButtonClicked1
{
    [self closeDatePicker1];
}





- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    
    if(theTextField == self.empDOJText)
    {
        [theTextField resignFirstResponder];
        
    }
    else if(theTextField == self.empRoleText)
    {
        [theTextField resignFirstResponder];
        
    }
    return YES;
}

- (IBAction)onClickSaveButton:(id)sender
{
   /*
    NSString *empId,*empName,*empDOJ,*empDOB,*empEmailId,*empContactNo,*empAddress,*empRole;
    int selectedEmpOffset;
    selectedEmpOffset = [TabBarController sharedTabBarController].selectedOffset;
    myStructType *tempNode = [DatabaseConnectivity sharedDatabaseConnectivity].empInfoHead;
    for(;tempNode->next!=NULL;tempNode=tempNode->next)
    {
        int currentEmpOffset = tempNode->eOffset;
        if(currentEmpOffset == selectedEmpOffset)
        {
            
            empId = [NSString stringWithFormat:@"%s", tempNode->eId];
            empName = [NSString stringWithFormat:@"%s", tempNode->eName];
            empDOJ = empDOJText.text;
            empDOB = [NSString stringWithFormat:@"%s", tempNode->eDOB];
            empEmailId = [NSString stringWithFormat:@"%s", tempNode->eEmailId];
            empContactNo = [NSString stringWithFormat:@"%s", tempNode->eContactNo];
            empAddress = [NSString stringWithFormat:@"%s", tempNode->eAddress];
            empRole = [NSString stringWithFormat:@"%s", tempNode->eRole];
            
            updatedEmpRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                empId,@"employeeId",
                                empName,@"employeeFirstName",
                                @"",@"employeeMiddleName",
                                @"",@"employeeLastName",
                                @"",@"status",
                                empDOB,@"dob",
                                @"",@"bloodGroup",
                                empEmailId,@"email",
                                empContactNo,@"phoneNumber",
                                @"",@"mobileNumber",
                                @"",@"emergencyContactNumber",
                                empDOJ,@"employeeHireDate",
                                @"",@"desigination",
                                @"",@"correspondenceAddress",
                                empAddress,@"permanentAddress",
                                empRole,@"role",
                                nil];
            RemoteDataUpdation *remoteDataUpdation = [[RemoteDataUpdation alloc]init];
            [remoteDataUpdation updateRecord:updatedEmpRecord ];
            
            
            
            
        }
    }
    
    */
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == empDOJText)
    {
        self.dojFlag = YES;
    }
    else if(textField == empRoleText)
    {
        self.roleFlag = YES;
    }
}
@end
