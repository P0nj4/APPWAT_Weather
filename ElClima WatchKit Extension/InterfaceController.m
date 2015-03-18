//
//  InterfaceController.m
//  ElClima WatchKit Extension
//
//  Created by German Pereyra on 3/17/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "InterfaceController.h"
#import "LocationRow.h"
#import "Weather.h"
#import "LocationUtilities.h"

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSArray *locations;
@end

@implementation InterfaceController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locations = [[LocationUtilities getLocations] allKeys];
    }
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self configureTableWithData];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)configureTableWithData {
    [self.table setNumberOfRows:[self.locations count] withRowType:@"LocationRow"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        LocationRow* theRow = [self.table rowControllerAtIndex:i];
        NSString* dataObj = [self.locations objectAtIndex:i];
        [theRow.rowDescription setText:dataObj];
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    NSString *selectedLocation = [self.locations objectAtIndex:rowIndex];
    NSLog(@"%@", selectedLocation);
    [self pushControllerWithName:@"WeatherInterfaceController" context:[[LocationUtilities getLocations] objectForKey:selectedLocation]];
}

@end



