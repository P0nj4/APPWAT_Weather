//
//  LocationUtilities.h
//  ElClima
//
//  Created by German Pereyra on 3/18/15.
//  Copyright (c) 2015 German Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationUtilities : NSObject
+ (void)insertLocation:(NSString *)locationName coordinates:(NSString *)coordinates;
+ (NSMutableDictionary *)getLocations;
@end
