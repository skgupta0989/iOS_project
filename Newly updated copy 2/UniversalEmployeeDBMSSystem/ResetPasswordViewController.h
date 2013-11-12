//
//  ResetPasswordViewController.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Sandeep Kumar Gupta on 24/10/13.
//
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
@interface ResetPasswordViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailIdField;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UITextField *confPasswordText;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewController;
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordText;
@property (strong, nonatomic) IBOutlet UIButton *loginPageButton;
- (IBAction)onClickSave:(id)sender;
- (NSString *) md5:(NSString *) input;
- (IBAction)onClickLogin:(id)sender;
-(int)resetPassword:(NSString *) userName :(NSString *) newPassword : (NSString *) oldPassWord;
@end
