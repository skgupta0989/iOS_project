//
//  MenuViewController.h
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "PickerViewcontroller.h"
@interface MenuViewController : UIViewController<UIApplicationDelegate>{

    //TableViewController *tableView;
   // PickerViewController *pickerView;
   // UIScreen *window;
    NSString *name;
    
}
@property (strong, nonatomic) UIWindow *window;
-(IBAction)onClickTableButton;
-(IBAction)onClickPickerButton;
@end
