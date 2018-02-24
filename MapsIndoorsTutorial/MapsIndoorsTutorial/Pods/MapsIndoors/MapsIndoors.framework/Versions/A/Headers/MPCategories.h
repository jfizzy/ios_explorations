//
//  MPCategories.h
//  MapsIndoors
//
//  Created by Daniel Nielsen on 18/01/16.
//  Copyright  Daniel Nielsen. All rights reserved.
//

#import "MPJSONModel.h"
#import "MPDataField.h"

@protocol MPDataField
@end

@interface MPCategories : MPJSONModel

@property (nonatomic, strong) NSArray<MPDataField>* list;

@end
