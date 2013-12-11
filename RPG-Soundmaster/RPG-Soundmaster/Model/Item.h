//
//  Item.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 12/8/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * minValue;
@property (nonatomic, retain) NSNumber * maxValue;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * defaultValue;
@property (nonatomic, retain) NSSet *options;
@property (nonatomic, retain) NSManagedObject *section;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(NSManagedObject *)value;
- (void)removeOptionsObject:(NSManagedObject *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
