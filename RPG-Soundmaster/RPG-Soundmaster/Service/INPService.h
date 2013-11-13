//
//  INPService.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/12/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RKObjectManager.h"
#import "RKRouteSet.h"

@interface INPService : NSObject

@property (nonatomic, strong, readonly) RKObjectManager *objectManager;

+ (instancetype)sharedInstance;

- (void)prepareManager:(RKObjectManager *)objectManager;
- (NSArray *)resourceRoutes;

@end
