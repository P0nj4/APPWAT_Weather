//
//  LocationUtilities.m
//  ElClima
//
//  Created by German Pereyra on 3/18/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import "LocationUtilities.h"

#define kSuiteNameGroup @"group.com.germanpereyra.test"
#define kDictionaryKey @"myLocations"

@implementation LocationUtilities

+ (NSMutableDictionary *)getLocations {
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:kSuiteNameGroup];
    NSMutableDictionary *result = [myDefaults objectForKey:kDictionaryKey];
    if (!result) {
        result = [[NSMutableDictionary alloc] init];
    }
    return result;
}

+ (void)insertLocation:(NSString *)locationName coordinates:(NSString *)coordinates {
    NSMutableDictionary *result = [LocationUtilities getLocations];
    [result setObject:coordinates forKey:locationName];
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:kSuiteNameGroup];
    [myDefaults setObject:result forKey:kDictionaryKey];
}

@end
