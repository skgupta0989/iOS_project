//
//  ViewController.m
//  SQLdatabase
//
//  Created by Yokesh on 9/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize studentIdText;
@synthesize studentNameText;
@synthesize subjectText;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSString *dirDocs;
    NSArray *dirPath;
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"dirPath=%@",dirPath);
    dirDocs=[dirPath objectAtIndex:0];
    databasePath=[[NSString alloc]initWithString:[dirDocs stringByAppendingPathComponent:@"student.db"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath] ==NO)
    {
        const char *dbPath = [databasePath UTF8String];
        
        if(sqlite3_open(dbPath,&studentDB )== SQLITE_OK)
        {
            char *errorMsg;
            char const *sql_stmt = "CREATE TABLE IF NOT EXISTS STUDENT(student_id INTEGER PRIMARY KEY,s_name TEXT,s_subject TEXT)";
            if(sqlite3_exec(studentDB, sql_stmt, NULL,NULL, &errorMsg)!=SQLITE_OK)
            {
                NSLog(@"Database cannot be created *******");
            }
            else
            {
                NSLog(@"Database successfully created *****");
            
            }
            sqlite3_close(studentDB);
        }
        else
        {
            NSLog(@"Database cannot be opened *****");
        }
    }

           
        
        [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)createDatabase{
    
}

- (void)viewDidUnload
{
    [self setStudentIdText:nil];
    [self setStudentNameText:nil];
    [self setSubjectText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)onClickSaveButton:(id)sender {
    
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &studentDB)==SQLITE_OK)
    {
        NSLog(@"inside insert sql open******");

        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO STUDENT(student_id,s_name,s_subject)VALUES (\"%@\",\"%@\",\"%@\")", self.studentIdText.text,self.studentNameText.text,self.subjectText.text];
        const char *insertStatement=[insertQuery UTF8String];
        
        sqlite3_prepare_v2(studentDB, insertStatement, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE)
        {
            
            self.studentNameText.text = @"";
            self.studentIdText.text = @"";
            self.subjectText.text = @"";
        }
        else 
        {
            NSLog(@"Failed to add contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(studentDB);
    }
    NSLog(@"Data Added******");
}

- (IBAction)onClickSearchButton:(id)sender {
    sqlite3_stmt    *statement;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &studentDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT s_name,s_subject FROM STUDENT WHERE student_id=\"%@\"",
                              self.studentIdText.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(studentDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]
                                  initWithUTF8String:
                                  (const char *) sqlite3_column_text(
                                                                     statement, 0)];
                self.studentNameText.text=name;
                NSString *subject = [[NSString alloc]
                                  initWithUTF8String:
                                  (const char *) sqlite3_column_text(
                                                                     statement, 1)];
                
                self.subjectText.text = subject;
                //                NSString *designation = [[NSString alloc]
                //                                        initWithUTF8String:(const char *)
                //                                        sqlite3_column_text(statement, 1)];
                //                self.empDesignation.text = designation;
                
            } else {
                NSLog(@"Match not found");
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(studentDB);
    }
}
@end
