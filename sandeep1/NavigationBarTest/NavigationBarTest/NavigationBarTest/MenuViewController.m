//
//  MenuViewController.m
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "TableViewController.h"
#import "PickerViewcontroller.h"
@implementation MenuViewController
@synthesize window;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do a
 dditional setup after loading the view, typically from a nib.
*/
/*
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
    MenuViewController *menuView=[[MenuViewController alloc]initWithNibName:nil bundle:nil];
    
    
    UINavigationController *navigationViewControl = [[UINavigationController alloc]initWithRootViewController:menuView];
    
    self.window.rootViewController=navigationViewControl;
    
        [window makeKeyAndVisible];
    //window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // *** IMPORTANT DIFFERENCE:
    //[window addSubview:navigationViewControl.view];
    return YES;
}*/

 - (void)viewDidLoad
{
    [super viewDidLoad];
    //tree view button
    
    
    
    
    UIButton *treeViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [treeViewButton addTarget:self 
                    action:@selector(onClickTableButton)
          forControlEvents:UIControlEventTouchUpInside];
    [treeViewButton setTitle:@"Tree View" forState:UIControlStateNormal];
    treeViewButton.frame = CGRectMake(70, 70, 100, 30);
    
    [self.view addSubview:treeViewButton];
    
    
    //picker view button
    UIButton *pickerViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pickerViewButton addTarget:self 
                       action:@selector(onClickPickerButton)
             forControlEvents:UIControlEventTouchUpInside];
    [pickerViewButton setTitle:@"picker View" forState:UIControlStateNormal];
    pickerViewButton.frame = CGRectMake(70, 130, 100, 30);
    
    [self.view addSubview:pickerViewButton];

    
}
-(IBAction)onClickTableButton{
   // MenuViewController *menuView = [[MenuViewController alloc]initWithNibName:nil bundle:nil];
    //[self presentModalViewController:viewController animated:YES];
    NSLog(@"inside table button click*******");
     TableViewController *tableView=[[TableViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:tableView animated:YES];
    //[self presentModalViewController:tableView animated:YES];
}
-(IBAction)onClickPickerButton{
 
    NSLog(@"inside picker button click*******");
    PickerViewcontroller *pickerView=[[PickerViewcontroller alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:pickerView animated:YES];
    
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

@end
