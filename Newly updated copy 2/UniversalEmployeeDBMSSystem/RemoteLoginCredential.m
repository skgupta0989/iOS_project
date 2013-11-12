    //
//  RemoteLoginCredential.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RemoteLoginCredential.h"
#import "LoadRemoteDataClass.h"

#define employeeGetURL @"http://10.132.161.59:8080/EmployeeDetailsManagement/employee/login"

@implementation RemoteLoginCredential

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(RemoteLoginCredential);



-(int)checkCredential:(NSString *) userName : (NSString *) passWord
{
    
    NSURL *url = [NSURL URLWithString:employeeGetURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    NSDictionary *empRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"email",passWord,@"password",nil];
    NSLog(@" **** empRecord %@",empRecord );
    //selectedEmailId = [empRecord objectForKey:@"email"];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:empRecord options:0 error:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    NSLog(@"jsonData : %@",jsonData);
    
    
    NSError *error;
    NSURLResponse * response = nil;
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (error == nil) 
    {
        //responseData = [NSMutableData data];
        NSLog(@" ********Connection established ***** ");
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@" jsonString : %@",jsonString);
        NSError* error;
        NSMutableDictionary* json = [NSJSONSerialization 
                                     JSONObjectWithData:data
                                     
                                     options:kNilOptions 
                                     error:&error];
        NSLog(@"json %@",json);
        if([[json objectForKey:@"message"] isEqualToString:@"successfull"])
        {
            NSDictionary *applicationData = [json objectForKey:@"object"];
            //  NSMutableArray *mutableAppNamesArray = [[NSMutableArray alloc]init];
        
            NSString *empRole = [applicationData objectForKey:@"role"]; 
        
            NSLog(@"empRole : %@",empRole);
        
            if([empRole isEqualToString:@"Admin"])
            {
                return 1;
            }
            else
            {
                return 0;
            }
        
        
        }
        else
            return -1;

    }
    else
    {
        //request error.....
        return -1;
        
    }
    
    
    
}
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"didReceiveResponse");
//    //[self.responseData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {        
//    
//    //    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    //    NSLog(@" jsonString : %@",jsonString);
//    
//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@" jsonString : %@",jsonString);
//    NSError* error;
//    NSMutableDictionary* json = [NSJSONSerialization 
//                                 JSONObjectWithData:data
//                                 
//                                 options:kNilOptions 
//                                 error:&error];
//    NSLog(@"json %@",json);
//    
//    NSDictionary *applicationData = [json objectForKey:@"object"];
//    //  NSMutableArray *mutableAppNamesArray = [[NSMutableArray alloc]init];
//    
//    NSString *empRole = [applicationData objectForKey:@"role"]; 
//    
//    NSLog(@"empRole : %@",empRole);
//    
//    if(![empRole isEqualToString:@""])
//    {
//        if([empRole isEqualToString:@"Admin"])
//        {
//            //return 1;
//        }
//        else
//        {
//            //return 0;
//        }
//    }
//   // return -1;
//    
////    for(NSDictionary *dict in applicationArray){
////        NSString *empId = [[dict objectForKey:@"employeeId"] stringValue];
////        NSString *empName = [dict objectForKey:@"employeeFirstName"];
////        NSString *empDoj = [dict objectForKey:@"employeeHireDate"];
////        NSString *empDob = [dict objectForKey:@"dob"];
////        NSString *empMail = [NSString stringWithFormat:[dict objectForKey:@"email"]];
////        NSString *empNumber = [dict objectForKey:@"phoneNumber"];
////        NSString *empAddress = [dict objectForKey:@"permanentAddress"];
////        NSString *empRole = [dict objectForKey:@"role"];
////        
////        //  NSString *appName = [dict objectForKey:@"employeeId"];
////        NSLog(@"employeeId : %@", empId);
////        NSLog(@"employeeFirstName : %@", empName);
////        NSLog(@"employeeHireDate : %@", empDoj);
////        NSLog(@"dob : %@", empDob);
////        NSLog(@"email : %@", empMail);
////        NSLog(@"phoneNumber : %@", empNumber);
////        NSLog(@"permanentAddress : %@", empAddress);
////        NSLog(@"role : %@", empRole);
//        //  NSLog(@"app name : %@", appName);
//        
//        
// /*       //  [mutableAppNamesArray addObject:appName];
//        int empSyncFlag = 1;
//        
//        // inserting the remote data into the local database...
//        BOOL resultStatus = [[DatabaseConnectivity sharedDatabaseConnectivity] insertEmployeeDatabase:empId :empName :empDoj :empDob :empMail :empNumber :empAddress :empRole :empSyncFlag];                                                                                               
//        if(resultStatus == YES)
//        {
//            NSLog(@"Remote Data Inserted Successfully ...!");
//            
//        }
//        else
//        {
//            NSLog(@"Remote Data Insertion Failed ...!");
//        }
//    }
//    //After the insertion of remote data, loading the employee data in linked list...
//    [[DatabaseConnectivity sharedDatabaseConnectivity]loadEmployeeDatabase];
//    */
//    
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
//    NSLog(@"didFailWithError");
//    // NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"connectionDidFinishLoading");
//    // NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
//    
//}


@end
