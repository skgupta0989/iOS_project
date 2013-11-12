//
//  AppDelegate.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadRemoteDataClass.h"
#import "LoginViewController.h"
#import "IQKeyBoardManager.h"
#import "LocalDatabaseOperations.h"
#import "SynchronizationClass.h"
#import "Facebook.h"
#import "MenuViewController.h"
#import "FBSession.h"
#import "FacebookSDK.h"
#import "EmployeeDetails.h"
#import "SampleLoginDatabase.h"
#import "EmployeeList.h"
#import "NetworkConnectivity.h"
#import "PersonalInfoView.h"
#import "OfficialInfoVIew.h"
#import "ContactInfoView.h"
#import "DataAdapterEmployeeList.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize loginViewController = _loginViewController;
@synthesize navigationController;
@synthesize internetActive;

@synthesize tabController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    // Override point for customization after application launch.
    
    
    //calling the keyboardManager  method to enable keyboard activities though out the application..
    [IQKeyBoardManager installKeyboardManager];
    
    
    //creating the local database if not exists...
    [[LocalDatabaseOperations sharedLocalDatabaseOperations] createEmployeeDatabase];
    
    // Check internet connection
    NetworkConnectivity *networkConnectivity = [[NetworkConnectivity alloc]init];
    
    BOOL status= [networkConnectivity checkConnection];
    
       
    if(status == NO)
    {
        // Inform the user network is not available and allow him to work in offline.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable" 
                                                        message:@"Start working in off-line" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    

    //[DataAdapterEmployeeList sharedDataAdapterEmployeeList].theContainer = [[NSMutableArray alloc]init];
    

    //Check for the device either iPhone or iPad...    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        //For iPhone redirection....
        self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    } 
    else 
    {
        //For iPad redirection....
        self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }
    
    //put the loginViewController instance as navigationController's root...
    navigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    
    //set the window's root as navigationController...
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{  
    return [FBSession.activeSession handleOpenURL:url]; 
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //[FBSession.activeSession handleDidBecomeActive];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"App cannot connect to the internet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        self.internetActive = NO;
    }
    
    
    else
    {
        
        NSLog(@"internet available");
        self.internetActive = YES;
        
    }
    
    
    // if internet available call viewcontroller;
    
    if (self.internetActive)
    {
        navigationController.viewControllers = [NSArray arrayWithObject:self.loginViewController];
        [self.window addSubview:navigationController.view];
        [self.window makeKeyAndVisible];
    }
    else {
        //error pic background display
    }




        
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    // It's very important to deallocate the struct variables once try to quit the application. By free the struct variables we can avoid memory leaks.
    
    
    //For deleting the remote data;
}



@end
