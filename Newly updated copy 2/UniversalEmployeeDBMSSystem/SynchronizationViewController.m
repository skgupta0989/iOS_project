    //
//  SynchronizationViewController.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SynchronizationViewController.h"
#import "LocalDatabaseOperations.h"
#import "LoadRemoteDataClass.h"
#import "SynchronizationClass.h"


@implementation SynchronizationViewController
@synthesize synchronizeTableView;
@synthesize employeeEmailArray;
@synthesize employeeNameArray;
@synthesize reverseEmpEmailArray;
@synthesize reverseEmpNameArray;
@synthesize reverseEmpSyncFlag;
@synthesize empSyncRecord;
@synthesize selectedEmpId;
@synthesize employeeSyncFlag;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SynchronizationViewController);


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Synchronize";
        //[DataAdapterEmployeeList sharedDataAdapterEmployeeList].theContainer = [[NSMutableArray alloc]init];
        [LocalDatabaseOperations sharedLocalDatabaseOperations].localDataArray = [[NSMutableArray alloc]init];
        self.employeeNameArray = [[NSMutableArray alloc]init];
         self.employeeEmailArray = [[NSMutableArray alloc]init];
         self.employeeSyncFlag = [[NSMutableArray alloc]init];
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
    [self setSynchronizeTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[LocalDatabaseOperations sharedLocalDatabaseOperations] loadEmployeeDatabase];
    
    [self loadEmployeeArray];
    [synchronizeTableView reloadData];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


//auto rotation enabled through this method....
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//initially loading the employee id,name,syncFlag in different format, for tableview presentation aspects.
-(void)loadEmployeeArray 
{
    
    NSUInteger count = [[LocalDatabaseOperations sharedLocalDatabaseOperations].localDataArray count];
    if(count == 0)
    {
        UIAlertView *deleteSuccess = [[UIAlertView alloc]initWithTitle:@"Empty !" message:@"There are no records to display" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
        [deleteSuccess show];
        return;
        
    }

    for (NSUInteger i = 0; i < count; i++)
    {
        NSMutableDictionary *tempData = [[LocalDatabaseOperations sharedLocalDatabaseOperations].localDataArray objectAtIndex: i];
            NSString *empEmail = [tempData objectForKey:@"email"] ;
            NSString *empName = [tempData objectForKey:@"employeeFirstName"];
            [self.employeeNameArray addObject:empName];
            [self.employeeEmailArray addObject:empEmail];
            [self.employeeSyncFlag addObject:[NSNumber numberWithInt:0]];
    }
        
}

          

// tableview data source methods .....

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.employeeEmailArray count];
}


//customizing the tableview cell (datasource) method.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell==NULL)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    
   
    cell.textLabel.text=[self.employeeNameArray objectAtIndex:indexPath.row];
    
    NSString *emailId = [self.employeeEmailArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=emailId;
    
    
    //default image to represent the employee list
    UIImage *image = [UIImage imageNamed:@"executive.png"];
    [cell.imageView setImage:image];
    
    
    //button to represent whether the employee data is is synched or not...
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = indexPath.row ;
    button.titleLabel.text = @"Sync";
    [button setTitle:@"Sync" forState:UIControlStateNormal];
    
    
    NSNumber *x = [self.employeeSyncFlag objectAtIndex:indexPath.row];
    
    
    //to differntiate the uploaded data and not-uploaded data
    int flag = [x intValue];
    
    if(flag == 1)
    {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         button.enabled = NO;
    }
    
    else
    {   
        button.enabled = YES;
        [button setTintColor:[UIColor purpleColor]];
        
    }
    
    button.frame = CGRectMake(250,15,70, 30);
    [button addTarget:self action:@selector(myAction: ) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:button];
        return cell;
}




//action to upload the corresponding employee info in remote...
- (void)myAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSUInteger selectedEmployeeIndex = button.tag;
    SynchronizationClass *synchronizationClass = [[SynchronizationClass alloc]init];
    BOOL result =[synchronizationClass loadURL:[[LocalDatabaseOperations sharedLocalDatabaseOperations].localDataArray objectAtIndex:selectedEmployeeIndex ]];
    if(result == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Employee Exists !" message:@"You're trying to sync with existing emp..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
        
        [alertView show];

        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Data Synched" message:@"Successfully added to the remote database" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
        
        [alertView show];
        button.enabled = NO;
        [self viewWillAppear:YES];
    }

}


//tableview delegate method

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
    //doing nothing with the tableview delegate.
}


@end
