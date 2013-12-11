//
//  ItemOption.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 12/8/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface ItemOption : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Item *item;

@end
