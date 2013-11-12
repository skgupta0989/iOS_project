//
//  AppDelegate.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    Reachability *reachability;
    BOOL internetActive;
    
}
@property BOOL internetActive;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginViewController;

@property(strong,nonatomic)UINavigationController *navigationController;

@property (strong, nonatomic) UITabBarController *tabController;


@end
