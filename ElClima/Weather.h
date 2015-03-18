//
//  Weather.h
//  ElClima
//
//  Created by German Pereyra on 3/17/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather;
typedef void (^WeatherLoadCompletition)(NSError **, Weather *);

@interface Weather : NSObject
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *skyDescription;
@property (nonatomic) NSInteger temp;
@property (nonatomic) NSInteger humidity;
@property (nonatomic) NSInteger windSpeed;
+ (void)loadWheaterForLat:(float)lat Lon:(float)lon completationHandler:(WeatherLoadCompletition)completition;
@end

