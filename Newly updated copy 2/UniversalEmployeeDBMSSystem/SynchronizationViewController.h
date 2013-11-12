//
//  SynchronizationViewController.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLSynthesizeSingleton.h"
@interface SynchronizationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *employeeEmailArray,*employeeNameArray,*employeeSyncFlag;
    NSMutableDictionary *empSyncRecord;
    NSArray *reverseEmpNameArray,*reverseEmpEmailArray,*reverseEmpSyncFlag;
    
    NSString *selectedEmpId;
    
}

@property (strong, nonatomic) NSMutableDictionary *empSyncRecord;
@property (strong, nonatomic)NSMutableArray *employeeEmailArray;
@property (strong, nonatomic)NSMutableArray *employeeNameArray;
@property (strong, nonatomic)NSMutableArray *employeeSyncFlag;
@property (strong, nonatomic)NSArray *reverseEmpNameArray;
@property (strong, nonatomic)NSArray *reverseEmpEmailArray;
@property (strong, nonatomic)NSArray *reverseEmpSyncFlag;
@property (strong, nonatomic) IBOutlet UITableView *synchronizeTableView;
@property (strong, nonatomic)NSString *selectedEmpId;
-(void)loadEmployeeArray ;

CWL_DECLARE_SINGLETON_FOR_CLASS(SynchronizationViewController);
@end
