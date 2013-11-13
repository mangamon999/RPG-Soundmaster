//
//  INPUserService.m
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/12/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import "INPUserService.h"
#import "RKResponseDescriptor.h"

#import "INPAuthenticationService.h"

#import "User+RKMapping.h"

@implementation INPUserService

+ (instancetype)sharedInstance {
    static dispatch_once_t dot = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&dot, ^{
        _sharedObject = [self new];
    });
    
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        RKObjectManager *objectManager = self.objectManager;
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[User mapping] method:RKRequestMethodGET pathPattern:@"/me.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        
        [objectManager addResponseDescriptor:responseDescriptor];
    }
    
    return self;
}

- (NSArray *)resourceRoutes {
    return @[[RKRoute routeWithClass:[User class] pathPattern:@"/me.json" method:RKRequestMethodGET]];
}

- (INPAuthenticationService *)authService {
    return [INPAuthenticationService sharedInstance];
}

- (User *)me {
    RKObjectManager *objectManager = self.objectManager;

    [objectManager getObjectsAtPath:@"/me.json" parameters:@{@"oauth_token":self.authService.oauthCredentials.accessToken} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Loaded object %@", mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to load object with error: %@", error);
    }];
    
    return nil;
}


@end
