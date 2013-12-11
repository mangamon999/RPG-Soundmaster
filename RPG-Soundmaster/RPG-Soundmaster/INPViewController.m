//
//  INPViewController.m
//  RPG-Soundmaster
//
//  Created by Bruno Pinheiro on 10/15/13.
//  Copyright (c) 2013 INpHELLer. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "INPViewController.h"
#import "ItemOption.h"
#import "SCUI.h"

@interface INPViewController ()

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation INPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton *)sender {
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Done!");

            [self getTracks];
        }
    };

    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        loginViewController = [SCLoginViewController loginViewControllerWithPreparedURL:preparedURL completionHandler:handler];
        [self presentViewController:loginViewController animated:YES completion:nil]; }];
}

- (void)getTracks {
    SCAccount *account = [SCSoundCloud account];

    if (!account) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Not logged In"
                              message:@"You must login first"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];

        [alert show];
        return;
    }

    SCRequestResponseHandler handler;

    handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSError *jsonError = nil;
        NSJSONSerialization *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:0
                                                                              error:&jsonError];

        if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {

            self.tracks = (NSArray *)jsonResponse;
        }
    };

    NSString *resourceURL = @"https://api.soundcloud.com/me/tracks.json";
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:resourceURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:handler];

}

#pragma mark - Accessor methods

- (void)setTracks:(NSArray *)tracks {
    //TODO - Use ReactiveCocoa framework for these bindings
    _tracks = tracks;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }

    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    cell.textLabel.text = [track objectForKey:@"title"];

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    NSString *streamURL = [track objectForKey:@"stream_url"];

    SCAccount *account = [SCSoundCloud account];

    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:streamURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                 NSError *playerError;
                 self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
                 [self.audioPlayer prepareToPlay];
                 [self.audioPlayer play];
             }];
}

@end
