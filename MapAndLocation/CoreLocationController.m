//
//  CoreLocationController.m
//  MapAndLocation
//
//  Created by Sandeep Kumar Gupta on 18/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "CoreLocationController.h"

@implementation CoreLocationController

-(id)init
{
    self = [super init];
    
    if (self != nil)
        {
            self.locationManager = [[CLLocationManager alloc]init];
            self.locationManager.delegate = self;
    
        }
    return self;
    
}

- (void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0)
{
    [self.delegate update:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self.delegate locationError:error];
}




@end
