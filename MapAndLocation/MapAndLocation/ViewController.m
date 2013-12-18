//
//  ViewController.m
//  MapAndLocation
//
//  Created by Sandeep Kumar Gupta on 18/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocationController.h"
#define METERS_PER_MILE 1609.344
#import "CoreLocation/CoreLocation.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize a,b;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.locationController = [[CoreLocationController alloc] init];
    self.locationController.delegate = self;
    [self.locationController.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update:(CLLocation *)location
{
   
    //for getting the coordinates..................................................
    
    a = [location coordinate].latitude;
    b = [location coordinate].longitude;
    self.latitude.text= [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
    self.longitude.text = [NSString stringWithFormat:@"Longitude: %f", [location coordinate].longitude];
    

    //to zoom on the coordinates....................................................
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = a;
    zoomLocation.longitude= b;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    
    
  // for reverse geocoder...converting coordinates into place names................
    
//    -----------------------
    if (!geocoder)
                geocoder = [[CLGeocoder alloc] init];
        
            [geocoder reverseGeocodeLocation:location completionHandler:
             ^(NSArray* placemarks, NSError* error)
             {
                 if ([placemarks count] > 0)
                 {
                     placemark = [placemarks objectAtIndex:0];
                      address1 = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                                               placemark.subThoroughfare, placemark.thoroughfare,
                                                               placemark.postalCode, placemark.locality,
                                                               placemark.administrativeArea,
                                                               placemark.country];

                      NSLog(@"%@",address1);
                     
                     
                     self.address.text = address1;
                  }
                 else
                 {
                        NSLog(@"%@", error.debugDescription);
                     //self.address.text = @"some error ocurred";
                 }
             }];
 }


- (void)locationError:(NSError *)error
{
    self.latitude.text = [error description];
    self.longitude.text = nil;
    
}


//for adding and deleting annotations on the map.............................

- (IBAction)tappedAdd:(id)sender {
    CLLocationCoordinate2D mapPoint;
    mapPoint.longitude = b;
    mapPoint.latitude = a;
    
    MKPointAnnotation *any = [[MKPointAnnotation alloc] init];
    any.coordinate = mapPoint;
    any.title = @"Annotation description";
    any.subtitle = address1;
    [self.mapView addAnnotation:any];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *AnnotationViewID = @"annotationViewID";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    return annotationView;
}

- (IBAction)tappedRemove:(id)sender {
    for (id annotation in self.mapView.annotations)
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [self.mapView removeAnnotation:annotation];
        }
}


@end
