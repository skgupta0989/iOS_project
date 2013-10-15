//
//  LoginViewController.h
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
//    IBOutlet UITextField* userNameText;
//    IBOutlet UITextField* passWordText;
//    IBOutlet UILabel* loginButton;
    
    
    UITextField *userNameText,*passWordText;
    UILabel *userNameLabel,*passWordLabel;
   
    
}
@property (strong,retain) NSString *userName;
@property (strong,retain) NSString *passWord;
-(IBAction)onClickLoginButton;
@end
