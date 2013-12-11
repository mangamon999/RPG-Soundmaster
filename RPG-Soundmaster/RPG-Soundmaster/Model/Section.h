//
//  Section.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 12/8/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Section;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *subSections;
@property (nonatomic, retain) Section *parentSection;
@property (nonatomic, retain) NSSet *items;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addSubSectionsObject:(Section *)value;
- (void)removeSubSectionsObject:(Section *)value;
- (void)addSubSections:(NSSet *)values;
- (void)removeSubSections:(NSSet *)values;

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
