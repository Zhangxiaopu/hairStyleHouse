//
//  findStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>

@interface findStyleViewController : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    CLLocationManager *locationManager;
}
@end
