//
//  INPAuthenticationService.m
//  RPG-Soundmaster
//
//  Created by Manga Mon on 11/13/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import "INPAuthenticationService.h"
#import "AFOAuth2Client.h"

#define Safe(block) if(block)block

@interface INPAuthenticationService ()

@property (nonatomic, strong) AFOAuth2Client *oauthClient;
@property (nonatomic) AFOAuthCredential *oauthCredential;
@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation INPAuthenticationService

+ (instancetype)sharedInstance {
    static dispatch_once_t dot = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&dot, ^{
        _sharedObject = [self new];
    });
    
    return _sharedObject;
}

- (void)authenticateWithUserName:(NSString *)userName password:(NSString *)password success:(INPAuthenticationSuccessBlock)successBlock failure:(INPAuthenticationFailureBlock)failureBlock {
   
    __weak INPAuthenticationService *weakSelf = self;
    
    [self.oauthClient authenticateUsingOAuthWithPath:@"/oauth2/token"
                                       username:userName
                                       password:password
                                          scope:nil
                                        success:^(AFOAuthCredential *credential) {
                                           
                                            NSLog(@"I have a token! %@", credential.accessToken);
                                            weakSelf.oauthCredential = credential;
                                            Safe(successBlock)();
                                        }
                                        failure:^(NSError *error) {
                                            
                                            NSLog(@"Error: %@", error);
                                            Safe(failureBlock)();
                                        }];
}

- (void)authenticateWithGoogleUser:(NSString *)userName password:(NSString *)password success:(INPAuthenticationSuccessBlock)successBlock failure:(INPAuthenticationFailureBlock)failureBlock {
    
    __weak INPAuthenticationService *weakSelf = self;
    
//    NSURL *URLToOpen = [NSURL URLWithString:[NSString stringWithFormat:@"%@/via/facebook?client_id=%@&redirect_uri=%@&display=popup&response_type=code",
//                                             ,
//                                             accountConfig[kNXOAuth2AccountStoreConfigurationClientID],
//                                             accountConfig[kNXOAuth2AccountStoreConfigurationRedirectURL]]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:URLToOpen]];
    
    [self.oauthClient authenticateUsingOAuthWithPath:@"/oauth2/token"
                                            code:@"code"
                                         redirectURI:nil
                                             success:^(AFOAuthCredential *credential) {
                                                 
                                                 NSLog(@"I have a token! %@", credential.accessToken);
                                                 weakSelf.oauthCredential = credential;
                                                 Safe(successBlock)();
                                             }
                                             failure:^(NSError *error) {
                                                 
                                                 NSLog(@"Error: %@", error);
                                                 Safe(failureBlock)();
                                             }];
}

#pragma mark - Public accessor methods

- (AFOAuthCredential *)oauthCredentials {
    return [AFOAuthCredential retrieveCredentialWithIdentifier:self.oauthClient.serviceProviderIdentifier];
}

#pragma mark - Accessor methods

- (AFOAuth2Client *)oauthClient {
    
    static dispatch_once_t dot = 0;
    
    dispatch_once(&dot, ^{
        _oauthClient = [AFOAuth2Client clientWithBaseURL:self.baseUrl
                                                clientID:@"5f2189a6505c3c6c4ef30ed19c27ef92"
                                                  secret:@"f71da3a60d1d8be0a6bbbdff10db4c5b"];
    });
    
    return _oauthClient;
}

- (void)setOauthCredential:(AFOAuthCredential *)oauthCredential {
    [AFOAuthCredential storeCredential:oauthCredential withIdentifier:self.oauthClient.serviceProviderIdentifier];
}

- (NSURL *)baseUrl {
    
    if (!_baseUrl) {
        _baseUrl = [NSURL URLWithString:@"https://api.soundcloud.com"];
    }
    
    return _baseUrl;
}

@end
