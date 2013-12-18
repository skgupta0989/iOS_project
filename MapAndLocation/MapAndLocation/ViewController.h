//
//  ViewController.h
//  MapAndLocation
//
//  Created by Sandeep Kumar Gupta on 18/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocationController.h"
#import "CoreLocation/CoreLocation.h"
@interface ViewController : UIViewController<CoreLocationControllerDelegate,MKMapViewDelegate>
{
    float a,b;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *address1;
}
@property float a,b;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (nonatomic ,retain) CoreLocationController *locationController;

- (IBAction)tappedAdd:(id)sender;
- (IBAction)tappedRemove:(id)sender;
@end
