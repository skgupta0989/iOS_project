//
//  ContactInfoView.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLSynthesizeSingleton.h"

@interface ContactInfoView : UIViewController
{
    BOOL regularEmpViewFlag;
    BOOL contactFlag,addressFlag;
}

CWL_DECLARE_SINGLETON_FOR_CLASS(ContactInfoView);


@property BOOL contactFlag,addressFlag;


@property (strong, nonatomic) IBOutlet UITextField *empEmailIdText;
@property (strong, nonatomic) IBOutlet UITextField *empContactNoText;
@property (strong, nonatomic) IBOutlet UITextField *empAddressText;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

-(void)deployContactInfo;
@end
