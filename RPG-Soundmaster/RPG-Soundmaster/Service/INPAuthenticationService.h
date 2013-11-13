//
//  INPAuthenticationService.h
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/13/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import "INPService.h"
#import "AFOAuth2Client.h"

typedef void(^INPAuthenticationSuccessBlock)();
typedef void(^INPAuthenticationFailureBlock)();

@interface INPAuthenticationService : INPService

@property (nonatomic, readonly) AFOAuth2Client *oauthClient;
@property (nonatomic, readonly) AFOAuthCredential *oauthCredentials;

- (void)authenticateWithUserName:(NSString *)userName password:(NSString *)password success:(INPAuthenticationSuccessBlock)successBlock failure:(INPAuthenticationFailureBlock)failureBlock;

@end
