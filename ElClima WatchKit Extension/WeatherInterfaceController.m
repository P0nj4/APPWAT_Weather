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
@property (weak, nonatomic) IBOutlet WKInterfaceImage *imgIcon;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblDescription;
@property (nonatomic, strong) NSString *coordinates;

@end


@implementation WeatherInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.coordinates = context;
    NSString *lat = [[self.coordinates componentsSeparatedByString:@","] firstObject];
    NSString *lon = [[self.coordinates componentsSeparatedByString:@","] lastObject];
    
    [Weather loadUWheaterForLat:[lat floatValue] Lon:[lon floatValue] completationHandler:^(NSError **error, Weather *result) {
        if (!error) {
            NSLog(@"result->%@",result);
            self.lblDescription.text = result.place;
            self.lblHumidity.text = [NSString stringWithFormat:@"%@",result.humidity];
            self.lblTemp.text = [NSString stringWithFormat:@"%ld °C", (long)result.temp];
            self.lblWindSpeed.text = [NSString stringWithFormat:@"%ld Km/h", (long)result.windSpeed];
            if (result.icon) {
                [self loadImage:result.icon];
            } else {
                [self.imgIcon setHidden:YES];
            }
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

- (void)loadImage:(NSString *)imgUrl {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void) {
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imgIcon setImage:image];
        });
    });
}

@end



