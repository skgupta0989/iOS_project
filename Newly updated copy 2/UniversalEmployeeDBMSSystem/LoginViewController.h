//
//  MyLoginControl.h
//  MyLoginTest
///Users/yokesh/Desktop/MyLoginTest/MyLoginTest/loginSuccessView.h
//  Created by Yokesh on 9/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *successfulLoginMessage;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIWindow *window;

- (IBAction)FbLoginButton:(id)sender;
- (IBAction)okButtonTouchUpInside:(id)sender;
- (void)openSession;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)onClickReset:(id)sender;




- (NSString *) md5:(NSString *) input;
@end
