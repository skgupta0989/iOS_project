//
//  EmployeeList.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#import "EmployeeList.h"
#import "CreateViewController.h"
#import "EmployeeDetails.h"

#import "FBSession.h"
#import "FacebookSDK.h"
#import "LoginViewController.h"
#import "PersonalInfoView.h"
#import "OfficialInfoVIew.h"
#import "ContactInfoView.h"
#import "LoadRemoteDataClass.h"
#import "TabBarController.h"
#import "DataAdapterEmployeeList.h"
#import "ResetPasswordViewController.h"

@implementation EmployeeList

@synthesize selectedEmployeeId;
@synthesize updateButton;
@synthesize logoutButton;
@synthesize editEmpDOJText;
@synthesize editEmpDOBText;
@synthesize editButton;
@synthesize editEmpContactNoText;
@synthesize editEmpEmailIDText;
@synthesize editEmpAddressText;
@synthesize editEmpNameText;
@synthesize cancelButton;
@synthesize editEmpIdLabel;
@synthesize messageLabel;
@synthesize employeeTableView;
@synthesize employeeId;
@synthesize employeeName;
@synthesize regularEmpFlag;
@synthesize reverseEmpArray;
@synthesize reverseEmpArray1;
@synthesize lastContentOffset;
@synthesize endFlag,endBoundary;
@synthesize empRecordOffset;
@synthesize theContainer;
@synthesize lastScroll;
@synthesize offset,tabIndex,max,N;
//@synthesize flag;
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)



CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(EmployeeList);

//void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);

//#define queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"List of Employees";
        employeeTableView.delegate = self;
        //yOffset = 0.0;
        offset = 0;
        max = 10;
        lastScroll = 1;
               
                     startFlag = YES;
              // [DataAdapterEmployeeList sharedDataAdapterEmployeeList].theContainer = [[NSMutableArray alloc]init];
                self.navigationItem.backBarButtonItem.target = self;
        self.navigationItem.backBarButtonItem.action = @selector(backButtonDidPressed:);
        

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEmployeeTableView:nil];
    [self setEditEmpDOJText:nil];
    [self setEditEmpDOBText:nil];
    [self setEditEmpContactNoText:nil];
    [self setEditEmpEmailIDText:nil];
    [self setEditEmpAddressText:nil];
    [self setEditEmpNameText:nil];
    [self setEditEmpIdLabel:nil];
    [self setUpdateButton:nil];
    [self setCancelButton:nil];
    [self setEditButton:nil];
    [self setMessageLabel:nil];
    [self setLogoutButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// How this view controller should appear when this view controller is triggered...

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self pickEmpRecord];
    [employeeTableView reloadData];
    
    if(regularEmpFlag == YES)
    {
        editButton.hidden = YES;
        updateButton.hidden = YES;
        cancelButton.hidden = YES;
        logoutButton.hidden = NO;
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign out" style:UIBarButtonItemStyleBordered  target:self action:@selector(signout:)];
        self.navigationItem.leftBarButtonItem = signOutButton;
        
       
    }
    else
    {
        editButton.hidden = NO;
        updateButton.hidden = NO;
        cancelButton.hidden = NO;
        logoutButton.hidden = YES;
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        // [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
   
}


//Enabling auto rotation via this method.....
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    
}



-(void) pickEmpRecord
{
    employeeId = [[NSMutableArray alloc] init];
    employeeName = [[NSMutableArray alloc] init];
    
    self.theContainer = [[NSMutableArray alloc]init];
        NSUInteger count = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray count];
        
    for (NSUInteger i = 0; i < count; i++)
    {
        NSMutableDictionary *tempData = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray objectAtIndex:i];
        [self.theContainer addObject:tempData];
        NSString *empId = [[tempData objectForKey:@"employeeId"] stringValue];
        NSString *empName = [tempData objectForKey:@"employeeFirstName"];
       [self.employeeId addObject:empId];
       [self.employeeName addObject:empName];  
                       
    }
        
                
   
    count = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray count];
        
    for (NSUInteger i = 0; i < count; i++)
    {
        NSMutableDictionary *tempData = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].secondArray objectAtIndex:i];
        [self.theContainer addObject:tempData];
        NSString *empId = [[tempData objectForKey:@"employeeId"] stringValue];
        NSString *empName = [tempData objectForKey:@"employeeFirstName"];
        [self.employeeId addObject:empId];
        [self.employeeName addObject:empName];
                               
       
            
    }
    

    count = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray count];
    for (NSUInteger i = 0; i < count; i++)
    {
        NSMutableDictionary *tempData = [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray objectAtIndex:i];
        [self.theContainer addObject:tempData];
        NSString *empId = [[tempData objectForKey:@"employeeId"] stringValue];
        NSString *empName = [tempData objectForKey:@"employeeFirstName"];
        [self.employeeId addObject:empId];
        [self.employeeName addObject:empName];
            
        
    }
  
}



// In ipad view performing updation over employee existing data into local database ...
/*
- (IBAction)onClickUpdateButton:(id)sender {
    BOOL status;
    NSString *empId,*empName,*empDOJ,*empDOB,*empEmailId,*empContactNo,*empAddress;
    empId = editEmpIdLabel.text;
    empName =editEmpNameText.text;
    empDOJ = editEmpDOJText.text;
    empDOB = editEmpDOBText.text;
    empEmailId = editEmpEmailIDText.text;
    empContactNo = editEmpContactNoText.text;
    empAddress = editEmpContactNoText.text;
    int empSyncFlag = 0;
    status = [[DatabaseConnectivity sharedDatabaseConnectivity] updateEmployeeDatabase :(NSString*)empId:(NSString*)empName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress:(int)empSyncFlag] ;
    
    if (status == YES)
    {
        //If the updation done successfully, inform the user with a alertView...
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"UPDATE !" message:@"Succesfully updated ..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
        [alertView show];
        
    }
    
    [self viewWillAppear:YES];
    
}
*/


// tableview data source methods .....

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.employeeId count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell==NULL)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        
    }
    
    // customizing each cell with emp Name, emp Id, and details button....
    
    //reverseEmpArray = [[self.employeeArray reverseObjectEnumerator]allObjects];
    cell.textLabel.text=[self.employeeId objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:@"executive.png"];
    [cell.imageView setImage:image];
    cell.tag = offset;
    //reverseEmpArray1 = [[self.employeeArray1 reverseObjectEnumerator] allObjects];
    
    NSString *tempId = [self.employeeName objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=tempId;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabBarController *tabBarController1 = [[TabBarController alloc] init];

  
    if(self.regularEmpFlag == YES)
    {
            tabBarController1.regularEmpViewFlag = YES;
    }
    tabBarController1.employeeRecord = [NSMutableDictionary alloc];
        flag[1]=2;
    tabIndex = [indexPath row];
    
    NSLog(@"%@", [self.theContainer objectAtIndex:tabIndex]);
    
    tabBarController1.employeeRecord = [[NSMutableDictionary alloc]initWithDictionary: [self.theContainer objectAtIndex:tabIndex]];
//    NSArray *viewControllers = [[self navigationController] viewControllers];
//    NSLog(@" view Controllers : %@",viewControllers);
    [self.navigationController pushViewController:tabBarController1 animated:YES];
//    NSArray *viewControllers1 = [[self navigationController] viewControllers];
//    NSLog(@" view Controllers : %@",viewControllers1);

}




 
 
 
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint point =scrollView.contentOffset ;//  employeeTableView.contentSize;

    float rowIndex = point.y;
    if(scrollDirection == ScrollDirectionUp)
    //if(rowIndex < 5.0f)
    
    {
        lastScroll = -1;
        if(offset == 0)
        {
            
            return ;
        }
        
        offset =  offset - max;
        if(offset == 0)
        {
            self.startFlag = YES;
        }
        else
        {
            endFlag = NO;
        }
        dispatch_sync(kBgQueue, ^{
            NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
            NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset-max];
            [[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
            
            
        });
        [self pickEmpRecord];
        [employeeTableView reloadData];
                        
    }
    
    else if(scrollDirection == ScrollDirectionDown)
    //else if(rowIndex > 22.0f)
    //else if(y > h + reload_distance)
    {
        
        if(endFlag == YES)
        {
             return ;
        }
        offset =  offset + max;
        lastScroll = 1;
        dispatch_sync(kBgQueue, ^{
            NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
            NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset+max-1];
            BOOL result =[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
            if( result == NO)
            {
                endFlag = YES;
                
            }
            else
                startFlag = NO;
        });
        
        [self pickEmpRecord];
        [employeeTableView reloadData];
    }
    
}







-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.lastContentOffset <  scrollView.contentOffset.y )
        scrollDirection = ScrollDirectionDown;
    else if (self.lastContentOffset > scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionUp;
    
    self.lastContentOffset = scrollView.contentOffset.y;
    
    /*
    
    if (employeeTableView.contentOffset.y  >=  emp employeeTableView.frame.size.height - 0xff)
    {
        if(endFlag == YES)
        {
            return ;
        }
        offset =  offset + max;
        lastScroll = 1;
        dispatch_sync(kBgQueue, ^{
            NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
            NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset+max-1];
            BOOL result =[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
            if( result == NO)
            {
                endFlag = YES;
                
            }
            else
                startFlag = NO;
        });
        
        [self pickEmpRecord];
        [employeeTableView reloadData];

    }
    else if (employeeTableView.contentOffset.y  <=  employeeTableView.frame.size.height - 0xffff)
    {
        lastScroll = -1;
        if(offset == 0)
        {
            
            return ;
        }
        
        offset =  offset - max;
        if(offset == 0)
        {
            self.startFlag = YES;
        }
        else
        {
            endFlag = NO;
        }
        dispatch_sync(kBgQueue, ^{
            NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
            NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset-max];
            [[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
            
            
        });
        [self pickEmpRecord];
        [employeeTableView reloadData];

        
    }
     */
     

}


- (void)backButtonDidPressed:(id)aResponder {
    //do your stuff
    //but don't forget to dismiss the viewcontroller
    NSArray *viewControllers1 = [[self navigationController] viewControllers];
    NSLog(@" view Controllers : %@",viewControllers1);

    [self.navigationController popViewControllerAnimated:TRUE];
}


/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@" offset %d",offset);
    
    if(scrollDirection == ScrollDirectionUp)
    {
        lastScroll = -1;
        if(offset == 0)
        {
            [self viewWillAppear:YES];
            return ;
        }
        
        
        
        offset =  offset - max;
            if(offset == 0)
            {
                self.startFlag = YES;
            }
            else
            {
                endFlag = NO;
            }
            dispatch_sync(kBgQueue, ^{
            NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
            NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset-7];
            //[self loadContents:maxSize nextOffset:newOffset];
                [[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
            
            
        });
            [self viewWillAppear:YES];
            //[self pickEmpRecord];
            //[employeeTableView reloadData];
            
        //}
    }
    else if (scrollDirection == ScrollDirectionDown)
    {
        // load the next set of records
        
        if(endFlag == YES)
        {
            if(endBoundary == YES)
            {
                //if we reached the last remote data cell, do nothing.
                return;
            }   
            else
            {
                offset = offset + max;
                endBoundary = YES;
                [self viewWillAppear:YES];
                return;
                
            }
        }
        offset =  offset + max;
        lastScroll = 1;
        dispatch_sync(kBgQueue, ^{
        NSNumber *maxSize = [[NSNumber alloc] initWithInt:max];
        NSNumber *newOffset = [[NSNumber alloc]initWithInt:offset+6];
        BOOL result =[[DataAdapterEmployeeList sharedDataAdapterEmployeeList] loadContents:maxSize nextOffset:newOffset :lastScroll];
        if( result == NO)
        {
           endFlag = YES;
            
        }
            else
                startFlag = NO;
       });
        [self viewWillAppear:YES];
    }
    
    
}

*/

//This action method is triggered when the user clicks the details button in the tableView...

- (IBAction)onClickCancelButton:(id)sender {
    
    editEmpNameText.text = @"";
    editEmpDOBText.text = @"";
    editEmpDOJText.text = @"";
    editEmpEmailIDText.text = @"";
    editEmpContactNoText.text = @"";
    editEmpAddressText.text = @"";
    
}


- (IBAction)onClickEditButton:(id)sender
{
    cancelButton.enabled = YES;
    editEmpNameText.enabled = YES;
    editEmpDOJText.enabled = YES;
    editEmpDOBText.enabled = YES;
    editEmpContactNoText.enabled = YES;
    editEmpEmailIDText.enabled = YES;
    editEmpEmailIDText.enabled = YES;
}



-(void)signout:(id)sender
{
    [FBSession.activeSession closeAndClearTokenInformation];
    
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    
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
    
   
    
}

@end
