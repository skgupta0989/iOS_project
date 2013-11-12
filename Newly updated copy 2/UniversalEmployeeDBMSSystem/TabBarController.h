//
//  TabBarController.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLSynthesizeSingleton.h"
#import "PersonalInfoView.h"
#import "OfficialInfoVIew.h"
#import "ContactInfoView.h"

@interface TabBarController : UITabBarController<UITabBarDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIApplicationDelegate,UITabBarControllerDelegate>
{
    BOOL regularEmpViewFlag;
    int selectedOffset;
    NSInteger selectedIndex;
    NSMutableDictionary *employeeRecord;
    UITabBarController *tabBarViewControl;
    UIAlertView *alertView;
    UIAlertView *alertDelete;
    UIAlertView *alertView1;
    
    PersonalInfoView *personalInfoView;
    OfficialInfoVIew *officialInfoVIew;
    ContactInfoView *contactInfoView ;
}

CWL_DECLARE_SINGLETON_FOR_CLASS(TabBarController);

@property int selectedOffset;
@property BOOL regularEmpViewFlag;
@property (strong, nonatomic) UITabBarController *tabBarViewControl;

@property (strong, nonatomic) NSMutableDictionary *employeeRecord;
- (BOOL)tabBarViewControl:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;


@end
