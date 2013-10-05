//
//  ViewController.h
//  SQLdatabase
//
//  Created by Yokesh on 9/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    
    sqlite3 *studentDB;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UITextField *studentIdText;
@property (strong, nonatomic) IBOutlet UITextField *studentNameText;
@property (strong, nonatomic) IBOutlet UITextField *subjectText;
- (IBAction)onClickSaveButton:(id)sender;
- (IBAction)onClickSearchButton:(id)sender;

@end
