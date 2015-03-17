//
//  Weather.m
//  ElClima
//
//  Created by German Pereyra on 3/17/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "Weather.h"

@implementation Weather



+ (void)loadWheaterForLat:(long)lat Lon:(long)lon completationHandler:(WeatherLoadCompletition)completition {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%li&lon=%li&units=metric&lang=sp", lat, lon]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            NSError *jsonParseError;
            NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
            if (jsonParseError) {
                completition(&jsonParseError, nil);
            }
            if (dicResult.count > 0) {
                Weather *result = [[Weather alloc] init];
                if ([dicResult objectForKey:@"sys"] && [dicResult objectForKey:@"sys"] != [NSNull null]) {
                    if ([[dicResult objectForKey:@"sys"] objectForKey:@"country"] && [[dicResult objectForKey:@"sys"] objectForKey:@"country"] != [NSNull null]) {
                        result.countryCode = [[dicResult objectForKey:@"sys"] objectForKey:@"country"];
                    }
                }
                if ([dicResult objectForKey:@"weather"] && [dicResult objectForKey:@"weather"] != [NSNull null]) {
                    if ([[[dicResult objectForKey:@"weather"] firstObject] objectForKey:@"description"] && [[[dicResult objectForKey:@"weather"] firstObject] objectForKey:@"description"] != [NSNull null]) {
                        result.skyDescription = [[[dicResult objectForKey:@"weather"] firstObject] objectForKey:@"description"];
                    }
                }
                if ([dicResult objectForKey:@"main"] && [dicResult objectForKey:@"main"] != [NSNull null]) {
                    if ([[dicResult objectForKey:@"main"] objectForKey:@"temp"] && [[dicResult objectForKey:@"main"] objectForKey:@"temp"] != [NSNull null]) {
                        result.temp = [[[dicResult objectForKey:@"main"] objectForKey:@"temp"] longValue];
                    }
                }
                if ([dicResult objectForKey:@"main"] && [dicResult objectForKey:@"main"] != [NSNull null]) {
                    if ([[dicResult objectForKey:@"main"] objectForKey:@"humidity"] && [[dicResult objectForKey:@"main"] objectForKey:@"humidity"] != [NSNull null]) {
                        result.humidity = [[[dicResult objectForKey:@"main"] objectForKey:@"humidity"] longValue];
                    }
                }
                if ([dicResult objectForKey:@"wind"] && [dicResult objectForKey:@"wind"] != [NSNull null]) {
                    if ([[dicResult objectForKey:@"wind"] objectForKey:@"speed"] && [[dicResult objectForKey:@"wind"] objectForKey:@"speed"] != [NSNull null]) {
                        result.windSpeed = [[[dicResult objectForKey:@"wind"] objectForKey:@"speed"] longValue];
                    }
                }
                if ([dicResult objectForKey:@"name"] && [dicResult objectForKey:@"name"] != [NSNull null]) {
                    result.place = [dicResult objectForKey:@"name"];
                }
                completition(nil, result);
            }
            
        } else if ([data length] == 0 && connectionError == nil)
            completition(&connectionError, nil);
        else if (connectionError != nil)
            completition(&connectionError, nil);
    }];
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"code:%@, sky:%@, temp:%i", self.countryCode, self.skyDescription, (int)self.temp];
}
@end
