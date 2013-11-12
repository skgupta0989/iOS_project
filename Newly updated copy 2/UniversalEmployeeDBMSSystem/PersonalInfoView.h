//
//  PersonalInfoView.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLSynthesizeSingleton.h"
@interface PersonalInfoView : UIViewController<UITextFieldDelegate,UITabBarControllerDelegate,UIApplicationDelegate,UITabBarDelegate>
{
    BOOL regularEmpViewFlag;
    int selectedOffset;
    UIActionSheet *pickerViewDate;
    UIDatePicker *datePicker;
    NSDateFormatter *dateFormatter;
    UIToolbar *pickerToolbar;
    BOOL fnameFlag,lnameFlag,dobFlag;
    UITabBarController *tabBar;
   
    
}
@property BOOL fnameFlag,lnameFlag;
@property BOOL dobFlag;

@property (strong, nonatomic) IBOutlet UITextField *empDOBText;
@property (strong,nonatomic) UITabBarController *tabBar;
CWL_DECLARE_SINGLETON_FOR_CLASS(PersonalInfoView);
@property (weak, nonatomic) IBOutlet UITextField *empFirstNameText;
@property (weak, nonatomic) IBOutlet UITextField *empLastNameText;

-(void)deployPersonalInfo;


@end
