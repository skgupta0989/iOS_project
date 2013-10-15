//
//  TableViewController.m
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "MenuViewController.h"

@implementation TableViewController
@synthesize tableViewOutlet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableViewOutlet = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableViewOutlet.dataSource = self; 
        tableViewOutlet.delegate = self;
        [self.view addSubview:self.tableViewOutlet];
        tableViewData= [[NSArray alloc] initWithObjects:@"red",@"green",@"yellow",@"red",@"green",@"yellow",@"red",@"green",@"yellow",@"black",@"red",@"green",@"yellow",@"red",@"green",@"yellow",@"red",@"green",@"yellow",@"black",nil];

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.

 - (void)loadView
{
    
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/
 - (void)viewDidLoad
{
  
}
    
  
-(IBAction)onClickTableButton{
     MenuViewController *viewController=[[MenuViewController alloc]initWithNibName:nil bundle:nil];
     [self presentModalViewController:viewController animated:YES];
   // [self.navigationController pushViewController:viewController animated:YES];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//datasource methods.....
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableViewData count];
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==NULL)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.textLabel.text=[tableViewData objectAtIndex:indexPath.row];
    return cell;
}


//delegate method(s).......

/* -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}*/
@end
