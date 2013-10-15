//
//  LoginViewController.m
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"

@implementation LoginViewController

@synthesize userName;
@synthesize passWord;
//@synthesize loginButton;

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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/
 - (void)viewDidLoad
{
    [super viewDidLoad];
    //Label 2 creation
    passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,50,100,30 )];
    passWordLabel.text=@"password";
    
    [self.view addSubview:passWordLabel];
    //Label 1 creation
    
    userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,100,30 )];
    userNameLabel.text=@"username";
    [self.view addSubview:userNameLabel];
    
    //TextField 1 creation
    userNameText=[[UITextField alloc]initWithFrame:CGRectMake(120, 10, 100,30)];
    userNameText.text=@"";

    userNameText.borderStyle=3;
    userNameText.delegate=self;
    
    [self.view addSubview:userNameText];
   
    //TextField 2 creation
    passWordText=[[UITextField alloc]initWithFrame:CGRectMake(120, 50, 100,30)];
    //passWordText.frame=CGRectMake(120, 50, 100,30);
    passWordText.text=@"";
    passWordText.borderStyle=3;
    [self.view addSubview:passWordText];
    
    //Login Button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton addTarget:self 
               action:@selector(onClickLoginButton)
     forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(75, 100, 50, 30);
    
    [self.view addSubview:loginButton];

//    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(75, 100, 50,30 )];
//    loginButton.accessibilityHint =@"Login";
//
//    [self.view addSubview:loginButton];
//    
}

-(IBAction)onClickLoginButton{
    
    if([userNameText.text isEqualToString:@"abc"] && [passWordText.text isEqualToString:@"123"])
    {
        NSLog(@"WELCOME*****");
        MenuViewController *menuView = [[MenuViewController alloc]initWithNibName:nil bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuView];
    
        [self presentModalViewController:navigationController animated:YES];
    //[self.navigationController pushViewController:navigationController animated:YES];                               
        
    }
    else
    {
        NSLog(@"***** TRY AGAIN ******");
    }
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
