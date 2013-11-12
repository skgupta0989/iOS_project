//
//  NetworkConnectivity.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "NetworkConnectivity.h"
#import "Reachability.h"



@implementation NetworkConnectivity


-(BOOL) checkConnection 
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [ Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    

    
    BOOL statusFlag;
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            //imageView.image = [UIImage imageNamed:@"stop-32.png"] ;
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            statusFlag = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            //imageView.image = [UIImage imageNamed:@"WWAN5.png"];
            statusFlag = YES;
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            //imageView.image = [UIImage imageNamed:@"Airport.png"];
            statusFlag = YES;
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"network connection" 
//                                                    message:statusString 
//                                                   delegate:nil 
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
    return statusFlag;
}




@end
