//
//  ViewController.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UIScrollViewDelegate>

// outlet names for create, edit, sync buttons
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (strong, nonatomic) IBOutlet UIButton *EditButton;
@property (strong, nonatomic) IBOutlet UIButton *syncButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewController;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *changePasswordButton;

//action instance method names for the respectives
- (IBAction)onClickCreateButton:(id)sender;
- (IBAction)onClickEditButton:(id)sender;
- (IBAction)onClickSyncButton:(id)sender;
- (IBAction)onClickLogoutButton:(id)sender;
- (IBAction)onClickChangePass:(id)sender;

@end
