//
//  KVViewController.m
//  MapTest
//
//  Created by Klaus Villaca on 9/05/2014.
//  Copyright (c) 2014 Klaus Villaca. All rights reserved.
//

#import "KVViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface KVViewController ()


@end

@implementation KVViewController

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

@synthesize addressLabel, latitudeLabel, longitudeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    //    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //    [locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)getCurrentLocation:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Start acquiring location
    [locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation !=nil) {
        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    // Stop acquiring location
    [locationManager stopUpdatingLocation];
    
    // Geocoding - Reverse
    NSLog(@"REsolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                                        placemark.subThoroughfare, placemark.thoroughfare,
                                                        placemark.postalCode, placemark.locality,
                                                        placemark.administrativeArea, placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to get your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


// If we are using a .nib
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        locationManager = [[CLLocationManager alloc] init];
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//        [locationManager startUpdatingLocation];
//    }
//    return self;
//}


@end
