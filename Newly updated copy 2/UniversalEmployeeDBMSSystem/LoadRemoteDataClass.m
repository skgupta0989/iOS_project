//
//  LoadRemoteDataClass.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LoadRemoteDataClass.h"
#import "DataAdapterEmployeeList.h"
#import "EmployeeList.h"
#define employeeGetURL @"http://10.132.161.59:8080/EmployeeDetailsManagement/employee/employeeList"

@implementation LoadRemoteDataClass
@synthesize empRecordArray;



-(BOOL)getRemoteDataNext:(NSNumber*)max :(NSNumber*)offset
{
    
    NSURL *url = [NSURL URLWithString:employeeGetURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSDictionary *empRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:max,@"max",offset,@"offset",nil];
    //NSLog(@" **** empRecord %@",empRecord );
    //selectedEmailId = [empRecord objectForKey:@"email"];
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
    if([result isEqualToString:@"employee not found"])
    {
        return NO;
    }
    
    NSMutableArray *applicationArray = [json objectForKey:@"object"];
    int i = 0;
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray = [[NSMutableArray alloc]init];
    NSDictionary *tempDictionary = [[NSDictionary alloc]init] ;
    NSUInteger count = [applicationArray count];
    for (NSUInteger j = 0; j < count; j++)
    {
        tempDictionary = [applicationArray objectAtIndex:j];
        [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].thirdArray addObject:[tempDictionary copy]];
        i++;
        
    }
    if(i<[EmployeeList sharedEmployeeList].max)
    {
        [EmployeeList sharedEmployeeList].N = i;
        [EmployeeList sharedEmployeeList].endFlag = YES;
        
    }
    
    return YES;
}


-(BOOL)getRemoteDataPrevious:(NSNumber*)max :(NSNumber*)offset
{
    
    NSURL *url = [NSURL URLWithString:employeeGetURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSDictionary *empRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:max,@"max",offset,@"offset",nil];
    //NSLog(@" **** empRecord %@",empRecord );
    //selectedEmailId = [empRecord objectForKey:@"email"];
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
    if([result isEqualToString:@"employee not found"])
    {
        return NO;
    }
    
    NSMutableArray *applicationArray = [json objectForKey:@"object"];
    int i = 0;
    [DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray = [[NSMutableArray alloc]init];
    NSDictionary *tempDictionary = [[NSDictionary alloc]init] ;
    NSUInteger count = [applicationArray count];
    for (NSUInteger j = 0; j < count; j++)
    {
        tempDictionary = [applicationArray objectAtIndex:j];
        [[DataAdapterEmployeeList sharedDataAdapterEmployeeList].firstArray addObject:[tempDictionary copy]];
        i++;
        
    }
    if(i<[EmployeeList sharedEmployeeList].max)
    {
        [EmployeeList sharedEmployeeList].N = i;
        [EmployeeList sharedEmployeeList].endFlag = YES;
        
    }
    
    return YES;
}



@end
