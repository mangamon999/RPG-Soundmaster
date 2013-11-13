//
//  User.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/12/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * permalink;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * uri;
@property (nonatomic, retain) NSString * permalinkUrl;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * selfDescription;
@property (nonatomic, retain) NSString * discogsName;
@property (nonatomic, retain) NSString * myspaceName;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * websiteTitle;
@property (nonatomic, retain) NSNumber * online;
@property (nonatomic, retain) NSNumber * trackCount;
@property (nonatomic, retain) NSNumber * playlistCount;
@property (nonatomic, retain) NSNumber * followersCount;
@property (nonatomic, retain) NSNumber * followingsCount;
@property (nonatomic, retain) NSNumber * publicFavoritesCount;
@property (nonatomic, retain) NSString * plan;
@property (nonatomic, retain) NSNumber * privateTracksCount;
@property (nonatomic, retain) NSNumber * privatePlaylistsCount;
@property (nonatomic, retain) NSNumber * primaryEmailConfirmed;

@end
