//
//  WeatherInterfaceController.m
//  ElClima
//
//  Created by German Pereyra on 3/18/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "WeatherInterfaceController.h"
#import "Weather.h"

@interface WeatherInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTemp;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblHumidity;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblWindSpeed;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblDescription;
@property (nonatomic, strong) NSString *coordinates;

@end


@implementation WeatherInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.coordinates = context;
    NSString *lat = [[self.coordinates componentsSeparatedByString:@","] firstObject];
    NSString *lon = [[self.coordinates componentsSeparatedByString:@","] lastObject];
    
    [Weather loadWheaterForLat:[lat floatValue] Lon:[lon floatValue] completationHandler:^(NSError **error, Weather *result) {
        if (!error) {
            NSLog(@"result->%@",result);
            self.lblDescription.text = result.skyDescription;
            self.lblHumidity.text = [NSString stringWithFormat:@"%ld %%", (long)result.humidity];
            self.lblTemp.text = [NSString stringWithFormat:@"%ld °C", (long)result.temp];
            self.lblWindSpeed.text = [NSString stringWithFormat:@"%ld Km/h", (long)result.windSpeed];
        }
    }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)btnShowMapPressed {
    [self pushControllerWithName:@"MapInterfaceController" context:self.coordinates];
}

@end



