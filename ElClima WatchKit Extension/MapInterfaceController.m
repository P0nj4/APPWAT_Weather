//
//  MapInterfaceController.m
//  ElClima
//
//  Created by German Pereyra on 3/18/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "MapInterfaceController.h"


@interface MapInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;
@property (weak, nonatomic) NSString *coordinates;
@end


@implementation MapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.coordinates = context;

    [self loadMap];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)loadMap {
    NSString *lat = [[self.coordinates componentsSeparatedByString:@","] firstObject];
    NSString *lon = [[self.coordinates componentsSeparatedByString:@","] lastObject];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([lat floatValue], [lon floatValue]);
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(10, 10);
    [self.map addAnnotation:location withPinColor:WKInterfaceMapPinColorPurple];
    [self.map setRegion:MKCoordinateRegionMake(location, coordinateSpan)];
}


@end



