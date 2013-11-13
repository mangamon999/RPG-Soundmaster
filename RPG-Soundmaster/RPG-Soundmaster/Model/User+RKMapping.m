//
//  User+RKMapping.m
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/12/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import "User+RKMapping.h"

#import "RKObjectManager.h"

@implementation User (RKMapping)

+ (RKEntityMapping *)mapping {
    
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class]) inManagedObjectStore:[RKObjectManager sharedManager].managedObjectStore];
    
    [mapping addAttributeMappingsFromArray:
     @[
       @"id",
       @"permalink",
       @"username",
       @"uri",
       @"country",
       @"city",
       @"website",
       @"online",
       @"plan"
       ]
     ];
    
    [mapping addAttributeMappingsFromDictionary:
     @{
       @"description": @"selfDescription",
       @"discogs_name": @"discogsName",
       @"myspace_name": @"myspaceName",
       @"website_title": @"websiteTitle",
       @"track_count": @"trackCount",
       @"playlist_count": @"playlistCount",
       @"followers_count": @"followersCount",
       @"followings_count": @"followingsCount",
       @"public_favorites_count": @"publicFavoritesCount",
       @"private_tracks_count": @"privateTracksCount",
       @"private_playlists_count":@"privatePlaylistsCount",
       @"primary_email_confirmed": @"primaryEmailConfirmed",
       @"permalink_url": @"permalinkUrl",
       @"avatar_url": @"avatarUrl",
       @"full_name": @"fullName"
       }
     ];
    
    return mapping;
}

@end
