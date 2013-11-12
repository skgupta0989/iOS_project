//
//  TabBarController.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"
#import "PersonalInfoView.h"
#import "OfficialInfoVIew.h"
#import "ContactInfoView.h"
#import "EmployeeList.h"
#import "RemoteDataUpdation.h"
#import "DeleteCurrentEmployee.h"
#import "DataAdapterEmployeeList.h"
#import "EmployeeList.h"
#define TAG_DELETE 1
@implementation TabBarController

@synthesize tabBarViewControl;
@synthesize regularEmpViewFlag;
@synthesize selectedOffset;
@synthesize employeeRecord;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(TabBarController);

- (id)init//WithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super init];//WithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        PersonalInfoView *personalInfoView=nil;
//        OfficialInfoVIew *officialInfoVIew=nil;
//        ContactInfoView *contactInfoView =nil;
        personalInfoView=nil;
        officialInfoVIew=nil;
        contactInfoView =nil;
        //  EmployeeList *employeeList = [[EmployeeList alloc]init];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            personalInfoView = [[PersonalInfoView alloc] initWithNibName:@"PersonalInfoView" bundle:nil];
            officialInfoVIew = [[OfficialInfoVIew alloc] initWithNibName:@"OfficialInfoVIew" bundle:nil];
            contactInfoView = [[ContactInfoView alloc] initWithNibName:@"ContactInfoView" bundle:nil];
            
        }
        else
        {
            personalInfoView = [[PersonalInfoView alloc] initWithNibName:@"PersonalInfoView_iPad" bundle:nil];
            officialInfoVIew = [[OfficialInfoVIew alloc] initWithNibName:@"OfficialInfoVIew_iPad" bundle:nil];
            contactInfoView = [[ContactInfoView alloc] initWithNibName:@"ContactInfoView_iPad" bundle:nil];
            
        }
        self.title = @"Employee Info";
        personalInfoView.title=@"Personal Information";
        officialInfoVIew.title=@"Official Information";
        contactInfoView.title=@"Contact Information";
        [[[self tabBarController] tabBar] setBackgroundImage:[UIImage imageNamed:@"uitabbar_bg.png"]];

        
        NSArray *viewControllersList = [[NSArray alloc] initWithObjects:personalInfoView,officialInfoVIew,contactInfoView, nil];
        tabBarViewControl = [[UITabBarController alloc]initWithNibName:nil bundle:nil];
        [tabBarViewControl setDelegate:self];
        tabBarViewControl.viewControllers  = viewControllersList;
        self.tabBarViewControl.selectedIndex = 1;
//        NSArray *viewControllers = [[self navigationController] viewControllers];
//        NSLog(@" view Controllers : %@",viewControllers);
        self.tabBarItem.title = @"asdfafda";
        [self.view addSubview:tabBarViewControl.view];
    }
    return self;
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)piewController
{
    
    
	// This works but the hidden tab bar leaves a blank white area so is just shown for info - simpler solution is simply to display a modal view on top of the main view
     //----- HIDE TAB BAR FOR SPECIFIC VIEWS -----
         
}




- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    
    if ([viewController isKindOfClass:[PersonalInfoView class]])
        {
            selectedIndex = 0;
        }
    else if ([viewController isKindOfClass:[OfficialInfoVIew class]])
        {
            selectedIndex = 1;
        
        }
    else if ([viewController isKindOfClass:[ContactInfoView class]])
        {
            selectedIndex = 2;
        }
    
    if(([PersonalInfoView sharedPersonalInfoView].fnameFlag == YES || [PersonalInfoView sharedPersonalInfoView].lnameFlag == YES || [PersonalInfoView sharedPersonalInfoView].dobFlag == YES || [OfficialInfoVIew sharedOfficialInfoVIew].roleFlag == YES || [OfficialInfoVIew sharedOfficialInfoVIew].dojFlag == YES ||[ContactInfoView sharedContactInfoView].contactFlag == YES || [ContactInfoView sharedContactInfoView].addressFlag == YES ) && regularEmpViewFlag == NO)
    {
        alertView1 = [[UIAlertView alloc]initWithTitle:@"Warning!" message:@"Do you want to save previous changes" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    
        [alertView1 show];
//            personalInfoView.nameFlag = NO;
//            personalInfoView.dobFlag = NO;
//            officialInfoVIew.roleFlag = NO;
//            officialInfoVIew.dojFlag = NO;
//            contactInfoView.contactFlag = NO;
//            contactInfoView.addressFlag = NO;
        return NO;
       
    }
        else
        {
//            personalInfoView.nameFlag = NO;
//            personalInfoView.dobFlag = NO;
//            officialInfoVIew.roleFlag = NO;
//            officialInfoVIew.dojFlag = NO;
//            contactInfoView.contactFlag = NO;
//            contactInfoView.addressFlag = NO;
            return YES;
        }
   

    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
   
    tabBarViewControl.delegate = self;
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarViewControl.tabBar.items objectAtIndex:1] setTitle:@"personalInfoView"];
    //[[self.tabBarViewControl.tabBar.items objectAtIndex:2] setTitle:@""
    if(regularEmpViewFlag == NO)
    {
        
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered  target:self action:@selector(clickEdit:)];
    }
    
    //NSMutableDictionary *Data =[[NSMutableDictionary alloc]initWithDictionary:[TabBarController sharedTabBarController].employeeRecord];
    
  
    [PersonalInfoView sharedPersonalInfoView].empFirstNameText.enabled = NO;
    [PersonalInfoView sharedPersonalInfoView].empLastNameText.enabled = NO;
    [PersonalInfoView sharedPersonalInfoView].empDOBText.enabled = NO;
    [OfficialInfoVIew sharedOfficialInfoVIew].empEmpIdText.enabled = NO;
    [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.enabled = NO;
    [OfficialInfoVIew sharedOfficialInfoVIew].empRoleText.enabled = NO;
    [ContactInfoView sharedContactInfoView].empContactNoText.enabled = NO;
    [ContactInfoView sharedContactInfoView].empAddressText.enabled = NO;
    [self.tabBarViewControl setTitle:@"Employee Info"];
}
- (void)viewDidUnload
{
        [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}




-(IBAction)clickEdit:(id)sender
{
    alertView = [[UIAlertView alloc]initWithTitle:@"Edit Menu" message:@"Press any Button " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit",@"Save",@"Delete", nil];
    
    
    [alertView show];
    
}


-(void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   
    if(buttonIndex ==0)
    {
    
        
    }
    
    else if(buttonIndex ==1)
        {
            [PersonalInfoView sharedPersonalInfoView].empFirstNameText.enabled = YES;
            [PersonalInfoView sharedPersonalInfoView].empLastNameText.enabled = YES;
            [PersonalInfoView sharedPersonalInfoView].empDOBText.enabled = YES;
            [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.enabled = YES;
            [OfficialInfoVIew sharedOfficialInfoVIew].empRoleText.enabled = YES;
            [ContactInfoView sharedContactInfoView].empContactNoText.enabled = YES;
            [ContactInfoView sharedContactInfoView].empAddressText.enabled = YES;
            [ContactInfoView sharedContactInfoView].empEmailIdText.enabled = YES;
            }
    else if(buttonIndex ==2)
    {
        
        // save employee updates .......
        
        NSString *empEmailId,*empFName,*empLName,*empDOJ,*empDOB,*empContactNo,*empAddress,*empRole;
        NSNumber *empId;
        empId = [self.employeeRecord objectForKey:@"employeeId"];
        empFName = [self.employeeRecord objectForKey:@"employeeFirstName"];
        empLName = [self.employeeRecord objectForKey:@"employeeLastName"];
        empDOB = [self.employeeRecord objectForKey:@"dob"];
        empEmailId = [self.employeeRecord objectForKey:@"email"];
        empDOJ = [self.employeeRecord objectForKey:@"employeeHireDate"];
        empContactNo = [self.employeeRecord objectForKey:@"phoneNumber"];
        empAddress = [self.employeeRecord objectForKey:@"permanentAddress"];
        empRole = [self.employeeRecord objectForKey:@"role"];
        NSMutableDictionary *tempRecord = [[ NSMutableDictionary alloc] init];
        
        tempRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      empId,@"employeeId",
                      empFName,@"employeeFirstName",
                      @"",@"employeeMiddleName",
                      empLName,@"employeeLastName",
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
        
        
        
        
        if([PersonalInfoView sharedPersonalInfoView].fnameFlag == YES)
        {
            empFName = [PersonalInfoView sharedPersonalInfoView].empFirstNameText.text;
            [tempRecord setObject:(NSString *)empFName forKey:@"employeeFirstName"];
        }
        if([PersonalInfoView sharedPersonalInfoView].lnameFlag == YES)
        {
            empLName = [PersonalInfoView sharedPersonalInfoView].empLastNameText.text;
            [tempRecord setObject:(NSString *)empLName forKey:@"employeeLastName"];
        }

        if([PersonalInfoView sharedPersonalInfoView].dobFlag == YES)
        {
            empDOB = [PersonalInfoView sharedPersonalInfoView].empDOBText.text;
            
            [tempRecord setObject:empDOB forKey:@"dob"];
        }
        else
        {            
           
         
            NSString *fromDate = [PersonalInfoView sharedPersonalInfoView].empDOBText.text;
 
            if ([fromDate isEqualToString: @""]) {
                fromDate = [self.employeeRecord objectForKey:@"dob"];
            }
            NSDate *date = [self parseRFC3339Date:fromDate];
            NSLog(@"%@", [self parseRFC3339Date:fromDate]);
            
            
            NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
            [rfc3339TimestampFormatterWithTimeZone setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
         
            NSString *a = [rfc3339TimestampFormatterWithTimeZone stringFromDate:date];
            NSLog(@"%@",a);
            
            [tempRecord setObject:a forKey:@"dob"];
        }

        if([OfficialInfoVIew sharedOfficialInfoVIew].dojFlag == YES)
        {
            empDOJ = [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.text;
            [tempRecord setObject:empDOJ forKey:@"employeeHireDate"];
            
        }
        else
        {
            //fetching the unchanged date.
            NSString *fromDate1 = [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.text;
            
            if ([fromDate1 isEqualToString: @""]) {
                fromDate1 = [self.employeeRecord objectForKey:@"employeeHireDate"];
            }

            NSDate *date1 = [self parseRFC3339Date:fromDate1];
            NSLog(@"%@", [self parseRFC3339Date:fromDate1]);

            NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
            [rfc3339TimestampFormatterWithTimeZone setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
            
            NSString *a1 = [rfc3339TimestampFormatterWithTimeZone stringFromDate:date1];
            NSLog(@"%@",a1);

             [tempRecord setObject:a1 forKey:@"employeeHireDate"];
            
        }
        if([OfficialInfoVIew sharedOfficialInfoVIew].roleFlag == YES)
        {
            empRole = [OfficialInfoVIew sharedOfficialInfoVIew].empRoleText.text;
            [tempRecord setObject:empRole forKey:@"role"];
            
        }
        if([ContactInfoView sharedContactInfoView].contactFlag == YES)
        {
            empContactNo = [ContactInfoView sharedContactInfoView].empContactNoText.text;
            [tempRecord setObject:empContactNo forKey:@"phoneNumber"];
        }
        if([ContactInfoView sharedContactInfoView].addressFlag == YES)
        {
            empAddress = [ContactInfoView sharedContactInfoView].empAddressText.text;
            [tempRecord setObject:empAddress forKey:@"permanentAddress"];
        }
        
        
        RemoteDataUpdation *remoteDataUpdation = [[RemoteDataUpdation alloc]init];
        BOOL result = [remoteDataUpdation updateRecord:tempRecord ];
        if(result == YES)
        {
            [employeeRecord setObject:empFName forKey:@"employeeFirstName"];
            [employeeRecord setObject:empLName forKey:@"employeeLastName"];
            [employeeRecord setObject:empDOB forKey:@"dob"];
            [employeeRecord setObject:empDOJ forKey:@"employeeHireDate"];
            [employeeRecord setObject:empContactNo forKey:@"phoneNumber"];
            [employeeRecord setObject:empAddress forKey:@"permanentAddress"];
            [[PersonalInfoView sharedPersonalInfoView] viewWillAppear:YES];
            [[OfficialInfoVIew sharedOfficialInfoVIew] viewWillAppear:YES];
            [[ContactInfoView sharedContactInfoView] viewWillAppear:YES];
            int position = [EmployeeList sharedEmployeeList].tabIndex;
            int arrayId,arrayOffset;
            arrayId = position / 10;
            arrayOffset =  position % 10;
            if(arrayId == 0)
            {
                [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
            }
            else if (arrayId == 1)
            {
                [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
            }
            else if (arrayId == 2)
            {
                [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
            }

            [[EmployeeList sharedEmployeeList].theContainer replaceObjectAtIndex:position withObject:employeeRecord];
            [[EmployeeList sharedEmployeeList].employeeTableView reloadData];
           //[[DataAdapterEmployeeList sharedDataAdapterEmployeeList].theContainer replaceObjectAtIndex:(page+offset) withObject:employeeRecord];
            UIAlertView *updateSuccess = [[UIAlertView alloc]initWithTitle:@"Update Success !" message:@"Successfully updated..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
            [updateSuccess show];
            [PersonalInfoView sharedPersonalInfoView].fnameFlag = NO;
            [PersonalInfoView sharedPersonalInfoView].lnameFlag = NO;
            [PersonalInfoView sharedPersonalInfoView].dobFlag = NO;
            [OfficialInfoVIew sharedOfficialInfoVIew].roleFlag = NO;
            [OfficialInfoVIew sharedOfficialInfoVIew].dojFlag = NO;
            [ContactInfoView sharedContactInfoView].contactFlag = NO;
            [ContactInfoView sharedContactInfoView].addressFlag = NO;

          
        }
        else
        {
            UIAlertView *updateAlert = [[UIAlertView alloc]initWithTitle:@"Update failed !" message:@"Unable to update Emp record" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
            [updateAlert show];
        }
        
        
    }
    else if(buttonIndex == 3)
    {
      alertDelete= [[UIAlertView alloc]initWithTitle:@"Warning  !" message:@"Are you sure do you want to delete..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil ];
         
        
        [alertDelete show];
        
        //return;
    
    
    }
   }





//alert for tab selection

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (alertView == alertView1)
    {
        if (buttonIndex == 0)
        {
            [PersonalInfoView sharedPersonalInfoView].fnameFlag = NO;
            [PersonalInfoView sharedPersonalInfoView].lnameFlag = NO;
            [PersonalInfoView sharedPersonalInfoView].dobFlag = NO;
            [OfficialInfoVIew sharedOfficialInfoVIew].roleFlag = NO;
            [OfficialInfoVIew sharedOfficialInfoVIew].dojFlag = NO;
            [ContactInfoView sharedContactInfoView].contactFlag = NO;
            [ContactInfoView sharedContactInfoView].addressFlag = NO;

            [tabBarViewControl setSelectedIndex:selectedIndex];
            return;
            
        }
        else if(buttonIndex == 1)
        {
            
            NSString *empEmailId,*empFName,*empLName,*empDOJ,*empDOB,*empContactNo,*empAddress,*empRole;
            NSNumber *empId;
            empId = [self.employeeRecord objectForKey:@"employeeId"];
            empFName = [self.employeeRecord objectForKey:@"employeeFirstName"];
            empLName = [self.employeeRecord objectForKey:@"employeeLastName"];
            empDOB = [self.employeeRecord objectForKey:@"dob"];
            empEmailId = [self.employeeRecord objectForKey:@"email"];
            empDOJ = [self.employeeRecord objectForKey:@"employeeHireDate"];
            empContactNo = [self.employeeRecord objectForKey:@"phoneNumber"];
            empAddress = [self.employeeRecord objectForKey:@"permanentAddress"];
            empRole = [self.employeeRecord objectForKey:@"role"];
            NSMutableDictionary *tempRecord = [[ NSMutableDictionary alloc] init];
            
            tempRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          empId,@"employeeId",
                          empFName,@"employeeFirstName",
                          @"",@"employeeMiddleName",
                          empLName,@"employeeLastName",
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
            
            
            
            
            if([PersonalInfoView sharedPersonalInfoView].fnameFlag == YES)
            {
                empFName = [PersonalInfoView sharedPersonalInfoView].empFirstNameText.text;
                [tempRecord setObject:(NSString *)empFName forKey:@"employeeFirstName"];
            }
            if([PersonalInfoView sharedPersonalInfoView].lnameFlag == YES)
            {
                empLName = [PersonalInfoView sharedPersonalInfoView].empLastNameText.text;
                [tempRecord setObject:(NSString *)empLName forKey:@"employeeLastName"];
            }
            if([PersonalInfoView sharedPersonalInfoView].dobFlag == YES)
            {
                empDOB = [PersonalInfoView sharedPersonalInfoView].empDOBText.text;
                
                [tempRecord setObject:empDOB forKey:@"dob"];
            }
            else
            {
                
                
                NSString *fromDate = [PersonalInfoView sharedPersonalInfoView].empDOBText.text;
                
                
                NSDate *date = [self parseRFC3339Date:fromDate];
                NSLog(@"%@", [self parseRFC3339Date:fromDate]);
                
                
                NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
                [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
                
                NSString *a = [rfc3339TimestampFormatterWithTimeZone stringFromDate:date];
                NSLog(@"%@",a);
                
                [tempRecord setObject:a forKey:@"dob"];
            }
            
            if([OfficialInfoVIew sharedOfficialInfoVIew].dojFlag == YES)
            {
                empDOJ = [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.text;
                [tempRecord setObject:empDOJ forKey:@"employeeHireDate"];
                
            }
            else
            {
                //fetching the unchanged date.
                NSString *fromDate1 = [OfficialInfoVIew sharedOfficialInfoVIew].empDOJText.text;
                
                
                NSDate *date1 = [self parseRFC3339Date:fromDate1];
                NSLog(@"%@", [self parseRFC3339Date:fromDate1]);
                
                NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
                [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"ccc MMM YY HH:mm:ss V yyyy"];
                
                NSString *a1 = [rfc3339TimestampFormatterWithTimeZone stringFromDate:date1];
                NSLog(@"%@",a1);
                
                [tempRecord setObject:a1 forKey:@"employeeHireDate"];
                
            }
            if([OfficialInfoVIew sharedOfficialInfoVIew].roleFlag == YES)
            {
                empRole = [OfficialInfoVIew sharedOfficialInfoVIew].empRoleText.text;
                [tempRecord setObject:empRole forKey:@"role"];
                
            }
            if([ContactInfoView sharedContactInfoView].contactFlag == YES)
            {
                empContactNo = [ContactInfoView sharedContactInfoView].empContactNoText.text;
                [tempRecord setObject:empContactNo forKey:@"phoneNumber"];
            }
            if([ContactInfoView sharedContactInfoView].addressFlag == YES)
            {
                empAddress = [ContactInfoView sharedContactInfoView].empAddressText.text;
                [tempRecord setObject:empAddress forKey:@"permanentAddress"];
            }
            if([OfficialInfoVIew sharedOfficialInfoVIew].dojFlag == NO)
            {
                
                
                
                
            }
            
            RemoteDataUpdation *remoteDataUpdation = [[RemoteDataUpdation alloc]init];
            BOOL result = [remoteDataUpdation updateRecord:tempRecord ];
            if(result == YES)
            {
                [employeeRecord setObject:empFName forKey:@"employeeFirstName"];
                [employeeRecord setObject:empLName forKey:@"employeeLastName"];
                [employeeRecord setObject:empDOB forKey:@"dob"];
                [employeeRecord setObject:empDOJ forKey:@"employeeHireDate"];
                [employeeRecord setObject:empContactNo forKey:@"phoneNumber"];
                [employeeRecord setObject:empAddress forKey:@"permanentAddress"];
                [[PersonalInfoView sharedPersonalInfoView] viewWillAppear:YES];
                [[OfficialInfoVIew sharedOfficialInfoVIew] viewWillAppear:YES];
                [[ContactInfoView sharedContactInfoView] viewWillAppear:YES];
                int position = [EmployeeList sharedEmployeeList].tabIndex;
                int arrayId,arrayOffset;
                arrayId = position / 10;
                arrayOffset =  position % 10;
                if(arrayId == 0)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
                }
                else if (arrayId == 1)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
                }
                else if (arrayId == 2)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray replaceObjectAtIndex:arrayOffset withObject:employeeRecord];
                }
                
                
                
                [[EmployeeList sharedEmployeeList].theContainer replaceObjectAtIndex:position withObject:employeeRecord];
                [[EmployeeList sharedEmployeeList].employeeTableView reloadData];
               
                UIAlertView *updateSuccess = [[UIAlertView alloc]initWithTitle:@"Update Success !" message:@"Successfully updated..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
                [updateSuccess show];
                [PersonalInfoView sharedPersonalInfoView].fnameFlag = NO;
                [PersonalInfoView sharedPersonalInfoView].lnameFlag = NO;
                [PersonalInfoView sharedPersonalInfoView].dobFlag = NO;
                [OfficialInfoVIew sharedOfficialInfoVIew].roleFlag = NO;
                [OfficialInfoVIew sharedOfficialInfoVIew].dojFlag = NO;
                [ContactInfoView sharedContactInfoView].contactFlag = NO;
                [ContactInfoView sharedContactInfoView].addressFlag = NO;

                
            }
            else
            {
                UIAlertView *updateAlert = [[UIAlertView alloc]initWithTitle:@"Update failed !" message:@"Unable to update Emp record" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
                [updateAlert show];
            }
            
            
            [tabBarViewControl setSelectedIndex:selectedIndex];
            return;
        }
        
    }
    else if(alertView == alertDelete)
    {
        
        if(buttonIndex ==0)
        {
        }
        else if(buttonIndex == 1)
        {
            NSNumber *empId;
            DeleteCurrentEmployee *deleteCurrentEmployee = [[DeleteCurrentEmployee alloc] init];
            empId = [self.employeeRecord objectForKey:@"employeeId"];
            NSMutableDictionary *deleteEmpRecord = [[NSMutableDictionary alloc]init];
            [deleteEmpRecord setObject:empId forKey:@"employeeId"];
            BOOL result = [deleteCurrentEmployee  deleteRecord:deleteEmpRecord];
            if(result == YES)
            {
                
                int position = [EmployeeList sharedEmployeeList].tabIndex;
                int arrayId,arrayOffset;
                arrayId = position / 10;
                arrayOffset =  position % 10;
                if(arrayId == 0)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray removeObjectAtIndex:arrayOffset];
                }
                else if (arrayId == 1)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray removeObjectAtIndex:arrayOffset ];
                }
                else if (arrayId == 2)
                {
                    [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray removeObjectAtIndex:arrayOffset];
                }
                

                
                
                UIAlertView *deleteSuccess = [[UIAlertView alloc]initWithTitle:@"Successfully deleted!" message:@"Employee entry deleted " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
                [deleteSuccess show];
            }
                       [self.navigationController popViewControllerAnimated:YES];
        }

        
    }
    
    
}

- (NSDate *)parseRFC3339Date:(NSString *)dateString
{
    NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
   // NSLocale *mulocale = [NSLocale currentLocale];
    [rfc3339TimestampFormatterWithTimeZone setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]] ;
    [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *theDate = nil;
    NSError *error = nil;
    if (![rfc3339TimestampFormatterWithTimeZone getObjectValue:&theDate forString:dateString range:nil error:&error]) {
        NSLog(@"Date '%@' could not be parsed: %@", dateString, error);
    }
    
    
    return theDate;
}

-(void)alertDelete:(UIAlertView *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alertDelete)
    {
        
    
    if(buttonIndex ==0)
    {
    }
    else if(buttonIndex == 1)
    {
        NSNumber *empId;
        DeleteCurrentEmployee *deleteCurrentEmployee = [[DeleteCurrentEmployee alloc] init];
        empId = [self.employeeRecord objectForKey:@"employeeId"];
        NSMutableDictionary *deleteEmpRecord = [[NSMutableDictionary alloc]init];
        [deleteEmpRecord setObject:empId forKey:@"employeeId"];
        BOOL result = [deleteCurrentEmployee  deleteRecord:deleteEmpRecord];
        if(result == YES)
        {
           
            int offset = [EmployeeList sharedEmployeeList].tabIndex;
            
           [[EmployeeList sharedEmployeeList].theContainer removeObjectAtIndex:offset];
            UIAlertView *deleteSuccess = [[UIAlertView alloc]initWithTitle:@"Successfully deleted!" message:@"Employee entry deleted from remote" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
            [deleteSuccess show];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
}






@end
