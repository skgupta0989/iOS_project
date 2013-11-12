//
//  ContactInfoView.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ContactInfoView.h"
#import "TabBarController.h"


@implementation ContactInfoView
@synthesize empEmailIdText;
@synthesize empContactNoText;
@synthesize empAddressText;
@synthesize editButton;
@synthesize contactFlag,addressFlag;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(ContactInfoView);
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
    [self setEmpEmailIdText:nil];
    [self setEmpContactNoText:nil];
    [self setEmpAddressText:nil];
    [self setEditButton:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Contact information";
    [self deployContactInfo];
    self.empEmailIdText.enabled = NO;
    self.empContactNoText.enabled = NO;
    self.empAddressText.enabled = NO;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)deployContactInfo
{
    NSMutableDictionary *Data =[[NSMutableDictionary alloc]initWithDictionary:[TabBarController sharedTabBarController].employeeRecord];
    self.empEmailIdText.text = [Data objectForKey:@"email"];
    self.empContactNoText.text = [Data objectForKey:@"phoneNumber"];
    self.empAddressText.text = [Data objectForKey:@"permanentAddress"];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    
    if(theTextField == self.empContactNoText)
    {
        [theTextField resignFirstResponder];
        
    }
    else if(theTextField == self.empAddressText)
    {
        [theTextField resignFirstResponder];
        
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == empContactNoText)
    {
        self.contactFlag = YES;
    }
    else if(textField == empAddressText)
    {
        self.addressFlag = YES;
    }
}

@end
