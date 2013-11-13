//
//  INPService.m
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/12/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import "INPService.h"

@implementation INPService

+ (instancetype)sharedInstance {
    @throw @"This method is abstract and should only be called from subclasses";
}

- (id)init
{
    self = [super init];
    if (self) {
        RKObjectManager *objectManager = self.objectManager;
        [self prepareManager:objectManager];
        [self registerRoutesWithObjectManager:objectManager];
    }
    return self;
}

- (RKObjectManager *)objectManager {
    return [RKObjectManager sharedManager];
}

- (void)prepareManager:(RKObjectManager *)objectManager {
    //nothing to do
}

- (NSArray *)resourceRoutes {
    return nil;
}

#pragma Utility Methods

- (void)registerRoutesWithObjectManager:(RKObjectManager *)objectManager {
    NSArray *routes = self.resourceRoutes;
    if (routes) {
        [objectManager.router.routeSet addRoutes:routes];
    }
}

@end
