//
//  SampleLoginDatabase.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "CWLSynthesizeSingleton.h"

@interface SampleLoginDatabase : NSObject
{
    NSString *databasePath;
    sqlite3 *userInfoDB;
}

CWL_DECLARE_SINGLETON_FOR_CLASS(SampleLoginDatabase);
-(void)loadLoginData;
- (void) createLoginData;
-(BOOL)insertLoginData :(NSString*)userName:(NSString*)passWord:(NSString *)role;
-(BOOL) loginCheck :(NSString*)userName:(NSString*)passWord;
@end
