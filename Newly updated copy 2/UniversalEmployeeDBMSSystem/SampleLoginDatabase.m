//
//  SampleLoginDatabase.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SampleLoginDatabase.h"

@implementation SampleLoginDatabase

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SampleLoginDatabase);

- (void) createLoginData 
{
    NSString *dirDocs;
    NSArray *dirPath;
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"dirPath=%@",dirPath);
    dirDocs=[dirPath objectAtIndex:0];
    databasePath=[[NSString alloc]initWithString:[dirDocs stringByAppendingPathComponent:@"LoginDetails.sqlite"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath] ==NO)
    {
        
               const char *dbPath = [databasePath UTF8String];
        NSLog(@"dirPath=%@",dirPath);
        if(sqlite3_open(dbPath,&userInfoDB )== SQLITE_OK)
        {
            char *errorMsg;
            char const *sql_stmt = "CREATE TABLE IF NOT EXISTS LOGINDATA(userid TEXT PRIMARY KEY,password TEXT,role TEXT)";
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

-(void)loadLoginData
{
    [self insertLoginData :@"neevtech":@"test":@"Admin"];
    [self insertLoginData :@"hello" :@"world":@"Admin"];
    [self insertLoginData :@"test":@"test":@"developer"];
    [self insertLoginData :@"hello" :@"hello":@"developer"];
    
}
-(BOOL)insertLoginData :(NSString*)userName:(NSString*)passWord:(NSString *)role
{
    BOOL resultStatus; 
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &userInfoDB)==SQLITE_OK)
    {
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO LOGINDATA(userid,password,role)VALUES (\"%@\",\"%@\",\"%@\")",userName,passWord,role];
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




-(BOOL) loginCheck :(NSString*)userName:(NSString*)passWord
{
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &userInfoDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM LOGINDATA"];
        NSLog(@"Data = %@",querySQL);
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(userInfoDB ,query_stmt , -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *userid,*password,*userRole;
                userid= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                password= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                userRole= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSLog(@"username :%@    password:%@",userid,password);
                if([userName isEqualToString:userid] && [passWord isEqualToString:password])
                {
                    
                    if([userRole isEqualToString:@"Admin"])
                    {//admin user
                        return 1;
                    }
                    else
                    {//nonadmin user
                        return 0;
                    }
                }
                
            } 
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(userInfoDB);
    }
    
    return -1;
    
    
    
}



@end
