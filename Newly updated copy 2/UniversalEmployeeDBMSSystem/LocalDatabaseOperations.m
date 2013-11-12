//
//  LocalDatabaseOperations.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Sandeep Kumar Gupta on 29/10/13.
//
//

#import "LocalDatabaseOperations.h"

@implementation LocalDatabaseOperations

@synthesize localDataArray;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(LocalDatabaseOperations);

- (void) createEmployeeDatabase
{
    NSString *dirDocs;
    NSArray *dirPath;
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"dirPath=%@",dirPath);
    dirDocs=[dirPath objectAtIndex:0];
    databasePath=[[NSString alloc]initWithString:[dirDocs stringByAppendingPathComponent:@"EmployeeDatabase.sqlite"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath] ==NO)
    {
        const char *dbPath = [databasePath UTF8String];
        NSLog(@"dirPath=%@",dirPath);
        if(sqlite3_open(dbPath,&userInfoDB )== SQLITE_OK)
        {
            char *errorMsg;
            char const *sql_stmt = "CREATE TABLE IF NOT EXISTS EMPLOYEEDATA(emp_fname TEXT,emp_lname TEXT,date_of_join TEXT,date_of_birth TEXT,emailId TEXT PRIMARY KEY,contactNo TEXT,address TEXT,password TEXT,role TEXT)";
            if(sqlite3_exec(userInfoDB, sql_stmt, NULL,NULL, &errorMsg)!=SQLITE_OK)
            {
                NSLog(@"Database cannot be created *******");
            }
            else
            {
                NSLog(@"Database successfully created *****");
                
            }
            sqlite3_close(userInfoDB);
        }
        else
        {
            NSLog(@"Database cannot be opened *****");
        }
    }
    
}


-(BOOL)insertEmployeeDatabase :(NSString*)empFirstName:(NSString*)empLastName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress:(NSString*)empPassword:(NSString*)role
{
    /*
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
    tempData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  empEmailId,@"email",
                  empPassword,@"password",
                  empFirstName,@"employeeFirstName",
                  @"",@"employeeMiddleName",
                  empLastName,@"employeeLastName",
                  @"",@"status",
                  empDOB,@"dob",
                  @"",@"bloodGroup",                  
                  empContactNo,@"phoneNumber",
                  @"",@"mobileNumber",
                  @"",@"emergencyContactNumber",
                  empDOJ,@"employeeHireDate",
                  @"true",@"desigination",
                  @"",@"status",
                  @"",@"correspondenceAddress",
                  empAddress,@"permanentAddress",
                  role,@"role",
                  nil];
    [self.localDataArray addObject:tempData];

    return YES;
     */

    BOOL resultStatus;
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &userInfoDB)==SQLITE_OK)
    {
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO EMPLOYEEDATA(emp_fname,emp_lname,date_of_join, date_of_birth, emailId, contactNo, address,password,role)VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",empFirstName,empLastName,empDOJ,empDOB,empEmailId,empContactNo,empAddress,empPassword,role];
        const char *insertStatement=[insertQuery UTF8String];
        NSLog(@"insertStatement %s",insertStatement);
        sqlite3_prepare_v2(userInfoDB, insertStatement, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            resultStatus = YES;
        }
        else
        {
            resultStatus = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(userInfoDB);
    }
    
    return resultStatus;
    
}




-(void)loadEmployeeDatabase
{
    NSString *empFName,*empLName,*empDOJ,*empDOB,*empEmailId,*empContactNo,*empAddress,*empPassword,*role;
    int  syncFlag;
    
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];

    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &userInfoDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM EMPLOYEEDATA"];
        NSLog(@"Data = %@",querySQL);
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(userInfoDB ,query_stmt , -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                empFName= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                empLName= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                empDOJ= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                empDOB= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                empEmailId= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                empContactNo= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                empAddress= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                empPassword= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                
                role= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                //syncFlag = sqlite3_column_int(statement, 8);
                
                // Copy the local variable values into the nsdictionary...
                
                tempData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            empEmailId,@"email",
                            empPassword,@"password",
                            empFName,@"employeeFirstName",
                            @"",@"employeeMiddleName",
                            empLName,@"employeeLastName",
                            @"",@"status",
                            empDOB,@"dob",
                            @"",@"bloodGroup",
                            empContactNo,@"phoneNumber",
                            @"",@"mobileNumber",
                            @"",@"emergencyContactNumber",
                            empDOJ,@"employeeHireDate",
                            @"true",@"desigination",
                            @"",@"status",
                            @"",@"correspondenceAddress",
                            empAddress,@"permanentAddress",
                            role,@"role",
                            nil];
                [self.localDataArray addObject:tempData];
                
          }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(userInfoDB);
    }
 
}

-(void) deleteRemoteData : (NSString *) emailId
{
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &userInfoDB)==SQLITE_OK)
    {
        NSString *insertQuery = [NSString stringWithFormat:@"DELETE FROM EMPLOYEEDATA WHERE emailId=\"%@\"",emailId];
        const char *insertStatement=[insertQuery UTF8String];
        NSLog(@"query delete : %s",insertStatement);
        sqlite3_prepare_v2(userInfoDB, insertStatement, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Succesfully removed from local db...");
            
           
        }
        else
        {
            NSLog(@"Failed to remove contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(userInfoDB);
    }
    
}




@end
