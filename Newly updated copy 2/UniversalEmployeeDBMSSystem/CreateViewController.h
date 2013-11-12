//
//  CreateViewController.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "sqlite3.h"

@interface CreateViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    NSString *databasePath;
    sqlite3 *userInfoDB;
    UIActionSheet *pickerViewDate;
    UIDatePicker *datePicker;
   
    UIToolbar *pickerToolbar;
}


@property (strong, nonatomic) IBOutlet UITextField *empRoleText;
@property (strong, nonatomic) IBOutlet UITextField *empPasswordText;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewController;
@property (strong, nonatomic) IBOutlet UITextField *empAddressText;
@property (strong, nonatomic) IBOutlet UITextField *empEmailIdText;
@property (strong, nonatomic) IBOutlet UITextField *empContactNoText;
@property (strong, nonatomic) IBOutlet UITextField *empDOBText;
@property (strong, nonatomic) IBOutlet UITextField *empDOJText;
@property (strong, nonatomic) IBOutlet UITextField *empLNameText;
@property (strong, nonatomic) IBOutlet UITextField *empFNameText;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) UIEdgeInsets scrollIndicatorInsets;


-(void) emptyTheFields;
- (IBAction)onClickSaveButton:(id)sender;
- (IBAction)onClickCancelButton:(id)sender;
- (IBAction)doneButtonClicked1;

- (NSString *) md5:(NSString *) input;
@end
