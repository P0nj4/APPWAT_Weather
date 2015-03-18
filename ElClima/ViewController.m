//
//  ViewController.m
//  ElClima
//
//  Created by German Pereyra on 3/17/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "LocationUtilities.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //user needs to press for 2 seconds
    [self.mapview addGestureRecognizer:lpgr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapview];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapview convertPoint:touchPoint toCoordinateFromView:self.mapview];
    
    MKPointAnnotation *annotation =
    [[MKPointAnnotation alloc]init];
    annotation.coordinate = touchMapCoordinate;
    annotation.title = @"ubicación";

    [self.mapview addAnnotation:annotation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    [geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"placemark %@",placemark);
        //String to hold address
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        NSLog(@"addressDictionary %@", placemark.addressDictionary);
        
        NSLog(@"placemark %@",placemark.region);
        NSLog(@"placemark %@",placemark.country);  // Give Country Name
        NSLog(@"placemark %@",placemark.locality); // Extract the city name
        NSLog(@"location %@",placemark.name);
        NSLog(@"location %@",placemark.ocean);
        NSLog(@"location %@",placemark.postalCode);
        NSLog(@"location %@",placemark.subLocality);
        
        NSLog(@"location %@",placemark.location);
        //Print the location to console
        NSLog(@"I am currently at %@",locatedAt);
        [LocationUtilities insertLocation:placemark.country coordinates:[NSString stringWithFormat:@"%f,%f",touchMapCoordinate.latitude, touchMapCoordinate.longitude]];
    }];
}

@end
