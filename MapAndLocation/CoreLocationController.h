//
//  CoreLocationController.h
//  MapAndLocation
//
//  Created by Sandeep Kumar Gupta on 18/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@protocol CoreLocationControllerDelegate
@required
- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationController : NSObject<CLLocationManagerDelegate>
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

}


@property (nonatomic ,retain)CLLocationManager *locationManager;
@property (nonatomic ,retain)id delegate;

@end
