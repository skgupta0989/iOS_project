//
//  OfficialInfoVIew.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLSynthesizeSingleton.h"

@interface OfficialInfoVIew : UIViewController<UITextFieldDelegate>
{
    BOOL regularEmpViewFlag;
    NSMutableDictionary *updatedEmpRecord;
    UIActionSheet *pickerViewDate;
    UIDatePicker *datePicker;
    NSDateFormatter *dateFormatter;
    UIToolbar *pickerToolbar;
    BOOL dojFlag,roleFlag;
    
}


CWL_DECLARE_SINGLETON_FOR_CLASS(OfficialInfoVIew);

@property BOOL dojFlag,roleFlag;

@property (strong, nonatomic) UIActionSheet *pickerViewDate;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIToolbar *pickerToolbar;
@property (strong, nonatomic) IBOutlet UITextField *empEmpIdText;
@property (strong, nonatomic) IBOutlet UITextField *empDOJText;
@property (strong, nonatomic) IBOutlet UITextField *empRoleText;
@property (strong, nonatomic) NSMutableDictionary *updatedEmpRecord;

- (IBAction)onClickSaveButton:(id)sender;
-(void)deployPersonalInfo;
- (IBAction)doneButtonClicked1;


@end
