//
//  ValidationClass.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ValidationClass.h"
#import "MenuViewController.h"

@implementation ValidationClass


+(BOOL)validateFields:(NSString*)empId:(NSString*)empName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress: (NSString*) empRole
{
    
    if ([empId isEqualToString:@""])
    {
        return FALSE;
    }
    else if([empEmailId isEqualToString:@""])
    {
        return FALSE;
    }
    else if([empRole isEqualToString:@""])
    {
        return  FALSE;
    }
    else
    {
        return TRUE;
    }
}



@end

