//
//  EmployeeList.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "CWLSynthesizeSingleton.h"


typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface EmployeeList : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIScrollViewDelegate>
{
    NSString *databasePath;
    sqlite3 *userInfoDB;
    NSMutableArray *employeeId;
    NSMutableArray *employeeName;
    NSInteger selectedEmployeeId;
    int numberOfRows;
    BOOL regularEmpFlag;
    int max,offset,tabIndex;
    int savedScrollPosition;
    NSNumber *oldRow,*rowSize;
    CGFloat _lastContentOffset;
    float reload_distance ,y,h;
    NSInteger lastContentOffset;
    ScrollDirection scrollDirection;
    BOOL endFlag,endBoundary,startFlag,startBoundary;
    int lastScroll,flag[3];
    int start,end,N;
	NSMutableArray *theContainer;
    // NSMutableArray *theContainer;
}
CWL_DECLARE_SINGLETON_FOR_CLASS(EmployeeList);
@property NSInteger selectedEmployeeId;
@property BOOL regularEmpFlag;
@property BOOL endFlag,endBoundary,startFlag,startBoundary;
@property int lastScroll;
@property int* flag;
@property int start,max,N;

@property int end,offset,tabIndex;

@property (strong, atomic)NSMutableArray *theContainer;
//@property (strong, nonatomic) NSMutableArray *theContainer;

@property (strong, nonatomic) IBOutlet UITableView *employeeTableView;
@property (strong, nonatomic)  NSMutableArray *empRecordOffset;
@property (strong, nonatomic)  NSMutableArray *employeeId;
@property (strong, nonatomic)  NSMutableArray *employeeName;
@property (strong, nonatomic)  NSArray *reverseEmpArray;
@property (strong, nonatomic)  NSArray *reverseEmpArray1;
@property (strong, nonatomic) IBOutlet UITextField *editEmpDOJText;
@property (strong, nonatomic) IBOutlet UITextField *editEmpDOBText;

@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UITextField *editEmpContactNoText;
@property (strong, nonatomic) IBOutlet UITextField *editEmpEmailIDText;
@property (strong, nonatomic) IBOutlet UITextField *editEmpAddressText;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UITextField *editEmpNameText;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UILabel *editEmpIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, assign) NSInteger lastContentOffset;

-(void) pickEmpRecord ;
-(IBAction)onClickEditButton:(id)sender;
-(IBAction)onClickUpdateButton:(id)sender;
-(IBAction)onClickCancelButton:(id)sender;
- (IBAction)onClickLogOutButton:(id)sender;
//-(void) removeLeastRecentlyUsed: (int)start range:(int) end;
//- (void) loadContents:(NSNumber *)_max nextOffset :(NSNumber *) _offset;
-(void)signout;
@end
