//
//  EmployeeDetails.h
//  EmployeeDBMS
//
//  Created by Yokesh on 9/30/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "AppDelegate.h"
@interface EmployeeDetails : UIViewController{
    int selectedEmployeeId;
    NSString *databasePath;
    sqlite3 *userInfoDB;
    NSString *selectedEmpId;
    BOOL regularEmpViewFlag;
}
@property BOOL regularEmpViewFlag;
@property(strong , nonatomic)NSString *selectedEmpId;
@property int selectedEmployeeId;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)onClickLogoutButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *empIdText;
@property (strong, nonatomic) IBOutlet UITextField *empNameText;
@property (strong, nonatomic) IBOutlet UITextField *empDojText;
@property (strong, nonatomic) IBOutlet UITextField *empDobText;
@property (strong, nonatomic) IBOutlet UITextField *empContactText;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UITextField *empEmailText;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UITextField *empAddressText;
@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewController;

-(void) pickEmpRecord ;
- (IBAction)onClickCancel:(id)sender;
- (IBAction)onClickSave:(id)sender;
- (IBAction)onClickEdit:(id)sender;
@end
