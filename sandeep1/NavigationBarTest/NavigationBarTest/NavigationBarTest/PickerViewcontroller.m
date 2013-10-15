//
//  PickerViewcontroller.m
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PickerViewcontroller.h"

@implementation PickerViewcontroller
@synthesize pickerViewCountry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.pickerViewCountry = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 50, 200,400)];
                pickerViewCountry.dataSource = self; 
        pickerViewCountry.delegate=self;
                [self.view addSubview:self.pickerViewCountry];
        countryNamesArray = [[NSMutableArray alloc]initWithObjects:@"Australia",@"Bangladesh",@"Cuba",@"Denmark",@"England",@"France",@"Germany",@"Holand",@"India",@"Japan",@"Kenya",@"Libya",@"Mangolia",@"Netherlands",@"Oman",@"Pakistan",@"Qatar",@"Russia",@"Spain",@"Thailand",@"Ukraine",@"Vietnam",@"Wales",@"Yemen",@"Zimbabwe",nil];


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
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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


//datasource methods ......


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [countryNamesArray count];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//delegate methods ......

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [ countryNamesArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

@end
