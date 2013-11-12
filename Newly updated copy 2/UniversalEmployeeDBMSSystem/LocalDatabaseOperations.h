//
//  LocalDatabaseOperations.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Sandeep Kumar Gupta on 29/10/13.
//
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "CWLSynthesizeSingleton.h"

@interface LocalDatabaseOperations : NSObject
{
    NSMutableArray *localDataArray;
    NSString *databasePath;
    sqlite3 *userInfoDB;
    
}
CWL_DECLARE_SINGLETON_FOR_CLASS(LocalDatabaseOperations);
@property (nonatomic, strong) NSMutableArray *localDataArray;
- (void) createEmployeeDatabase;
-(BOOL)insertEmployeeDatabase :(NSString*)empFirstName:(NSString*)empLastName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress:(NSString*)empPassword:(NSString*)role;

-(void)loadEmployeeDatabase;
-(void) deleteRemoteData : (NSString *) emailId;
@end
