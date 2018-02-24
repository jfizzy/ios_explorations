//
//  MPMapsIndoors.h
//  MapsIndoorsSDK
//
//  Created by Daniel Nielsen on 04/11/2016.
//  Copyright  Daniel-Nielsen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MPImageProvider.h"
#import "MPPositionProvider.h"

typedef void(^mpOfflineDataHandlerBlockType)(NSError* error);

@interface MapsIndoors : NSObject

/**
 Provides your Solution Id to the MapsIndoors SDK for iOS. This key is generated for your solution.
 @return YES if the Solution Id was successfully provided
 */
+ (BOOL) provideSolutionId:(NSString*)solutionId;

/**
 Gets the current MapsIndoors solution id.
 @param  The solution id as a string value.
 */
+ (NSString*) getSolutionId;

/**
 Sets the language for the content provided by MapsIndoors.
 @param  language The language for which the content should be fetched. Uses the two-letter language code ISO 639-1.
 */
+ (void) setLanguage:(NSString*)languageCode;

/**
 Gets the current language for the content provided by MapsIndoors.
   @returns The language for which the content should be fetched. Uses the two-letter language code ISO 639-1.
 */
+ (NSString*) getLanguage;

/**
 Fetch all neccesary content to be able to run MapsIndoors in offline environments
 @param  completionHandler Callback function that fires when content has been fetched or if this process resolves in an error. Note: Does not automtically retry fetch.
 */
+ (void)fetchDataForOfflineUse: (mpOfflineDataHandlerBlockType) completionHandler;

/**
 Sets the offline mode for the content provided by MapsIndoors. NB: This forces the implementation to be offline, even if there is no data available offline.
 @param  offlineMode The offline mode. Can be true/offline false/offline.
 */

+ (void) setOfflineMode:(BOOL)offline;

/**
 Gets the current offline mode.
 */

+ (BOOL) getOfflineMode;

/**
 The font that MapsIndoors should use when rendering labels on the map.
 */
@property (class) UIFont* mapLabelFont;

/**
 The color that MapsIndoors should use when rendering labels on the map.
 */
@property (class) UIColor* mapLabelColor;

/**
 The position provider that MapsIndoors should use when user location services are needed.
 */
@property (class) id<MPPositionProvider> positionProvider;

/**
 Default map icon size
 */
@property(class) CGSize mapIconSize;

/**
 The image provider that MapsIndoors should use when image ressources are needed. MapsIndoors will provide a default if this property is nil.
 */
@property(class) id<MPImageProvider> imageProvider;

@end
