//
//  MPPositionResult.h
//  MapsIndoors
//
//  Created by Daniel Nielsen on 10/03/14.
//  Copyright (c) 2014 MapsPeople A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPPoint.h"
#import "MPJSONModel.h"


/**
 Position result model
 */
@interface MPPositionResult : MPJSONModel


/**
 The geographic point geometry of the position
 */
@property MPPoint* geometry;

/**
 Properties dictionary
 */
@property NSMutableDictionary* properties;
/**
 Type property
 */
@property NSString* type DEPRECATED_MSG_ATTRIBUTE("Marked as obsolete property");
/**
 Position provider that delivered this position
 */
@property id<Optional> provider;

/**
 Get the probability of the position. This is a radius in meters. Can be used to generate an approximation circle.

 @return A double representing the positions accuracy in meters.
 */
- (double)getProbability;

/**
 Get the roundtrip property

 @return The roundtrip value.
 */
- (double)getRoundtrip DEPRECATED_MSG_ATTRIBUTE("Marked as obsolete method");

/**
 Get the heading in degrees from north

 @return The heading value in degrees from north as a double
 */
- (double)getHeadingDegrees;

/**
 Get the age of the this position result; the time in seconds since the position was first determined.

 @return The age property as a number
 */
- (NSNumber*)getAge DEPRECATED_MSG_ATTRIBUTE("Marked as obsolete method");

/**
 Get the floor index property

 @return The floor index property
 */
- (NSNumber*)getFloor;

- (void)setProbability:(double)probability;
/**
 Set the heading of the position result in degrees from north
 
 @param heading The heading value in degrees from north as a double
 */
- (void)setHeadingDegrees:(double)heading;

@end
