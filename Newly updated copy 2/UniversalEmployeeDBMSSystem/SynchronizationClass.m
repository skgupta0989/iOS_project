    //
//  SynchronizationClass.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SynchronizationClass.h"
#import "SynchronizationViewController.h"
#import "LoadRemoteDataClass.h"
#import "LocalDatabaseOperations.h"

#define employeePostURL @"http://10.132.161.59:8080/EmployeeDetailsManagement/employee/saveEmployee"


@implementation SynchronizationClass

@synthesize selectedEmpId;
@synthesize responseData = _responseData;

- (BOOL)loadURL :(NSDictionary *)empRecord
{ 
   
    // load the url and post the employee record..... 
    NSURL *url = [NSURL URLWithString:employeePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    
    NSLog(@" **** empRecord %@",empRecord );
    NSString *emailId = [empRecord objectForKey:@"email"];
    selectedEmailId = [empRecord objectForKey:@"email"];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:empRecord options:0 error:nil];
       [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    
    
    NSError *error;
    
    
    NSURLResponse * response = nil;
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //NSLog(@">>>>>>>>>>>>> Request Sent >>>>>>>>>>>> ");
    
    NSMutableDictionary* json = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 
                                 options:kNilOptions
                                 error:&error];
    //NSLog(@"json %@",json);
    NSString *result = [json objectForKey:@"message"];
    if([result isEqualToString:@"employee saved"])  
    {
        [[LocalDatabaseOperations sharedLocalDatabaseOperations] deleteRemoteData :emailId ];
        
        return YES;
    }
    else
    {
        return NO;
    }

       
}




- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
}




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
       
}




- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
  
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Server Error !" message:@"Please try again later ......" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];           
    [alertView show];  
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
   
    
}

@end






