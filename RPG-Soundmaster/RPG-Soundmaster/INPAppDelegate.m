//
//  INPAppDelegate.m
//  RPG-Soundmaster
//
//  Created by Bruno Pinheiro on 10/15/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//


#import "INPAppDelegate.h"

#import "RKManagedObjectStore.h"
#import "RKPathUtilities.h"
#import "RKObjectManager.h"
#import "RKLog.h"
#import "INPAuthenticationService.h"

#import "INPUserService.h"

#import "SCUI.h"

@implementation INPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [SCSoundCloud  setClientID:@"5f2189a6505c3c6c4ef30ed19c27ef92"
//                        secret:@"f71da3a60d1d8be0a6bbbdff10db4c5b"
//                   redirectURL:[NSURL URLWithString:@"rpgsoundmaster://oauth"]];

    
    INPAuthenticationService *authenticationService = [INPAuthenticationService sharedInstance];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:authenticationService.oauthClient];
    [RKObjectManager setSharedManager:objectManager];

    NSError *error;

    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (!success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }

    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"PersitentStore.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (!persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }
    [managedObjectStore createManagedObjectContexts];

    objectManager.managedObjectStore = managedObjectStore;

    [authenticationService authenticateWithUserName:@"mangamon999@gmail.com" password:@"Mangamon9" success:^{
        NSLog(@"YAY!!! Succeeded!");
        id me = [INPUserService sharedInstance].me;
        me = me;
    } failure:^{
        NSLog(@"OHHH!!! It Failed =(");
    }];

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
