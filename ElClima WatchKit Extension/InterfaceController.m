//
//  InterfaceController.m
//  ElClima WatchKit Extension
//
//  Created by German Pereyra on 3/17/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "InterfaceController.h"
#import "Weather.h"

@interface InterfaceController()

@end

@implementation InterfaceController

- (instancetype)init {
    self = [super init];
    if (self) {
        [Weather loadWheaterForLat:-34.915092 Lon:-56.156671 completationHandler:^(NSError **error, Weather *result) {
            if (!error) {
                NSLog(@"result->%@",result);
            }
        }];
    }
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



