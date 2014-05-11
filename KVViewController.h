//
//  KVViewController.h
//  MapTest
//
//  Created by Klaus Villaca on 9/05/2014.
//  Copyright (c) 2014 Klaus Villaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KVViewController : UIViewController<CLLocationManagerDelegate>

@property(weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *addressLabel;

-(IBAction)getCurrentLocation:(id)sender;

@end
