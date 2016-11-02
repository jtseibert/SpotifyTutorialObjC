//
//  AppDelegate.m
//  SpotifyTutorialObjC
//
//  Created by Jacob Seibert on 11/1/16.
//  Copyright © 2016 Jacob Seibert. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) SPTSession *session;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Entered didFinishLaunchingWithOptions.");
    [[SPTAuth defaultInstance] setClientID:@"af9f9402ffd648d2b23673caf008f4b1"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"spotifytutorialobjc-login://callback"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope]];
    
    

    NSURL *loginURL = [[SPTAuth defaultInstance] spotifyWebAuthenticationURL];
    
    [application openURL:loginURL options:@{} completionHandler: nil];
    return YES;
    
    // return a spotify-action:// URI that you should open with -[UIApplication openURL:] if +[SPTAuth supportsApplicationAuthentication] returns YES, in order to perform SSO authentication against the Spotify application.
//    NSLog(@"Calling spotifyAppAuthenticationURL.");
//    NSURL *loginURL = [[SPTAuth defaultInstance] spotifyAppAuthenticationURL];
//    NSLog(@"spotifyAppAuth successful.");
    
//    NSLog(@"checking supportsApplicationAuth.");
//    if ([SPTAuth supportsApplicationAuthentication]) {
//        NSLog(@"In the if");
//        [application openURL:loginURL options:@{} completionHandler: nil];
//        NSLog(@"Leaving didFinishLaunchingWithOptions.");
//        return YES;
//    } else {
//        NSLog(@"Leaving didFinishLaunchingWithOptions.");
//        return NO;
//    }
    
    
    
}

// Handle auth callback
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    NSLog(@"Handling auth callback.");

    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
            
            // Call the -loginUsingSession: method to login SDK
            [self loginUsingSession:session];
        }];
        NSLog(@"Handled auth callback.");
        return YES;
    }
    NSLog(@"Handled auth callback.");
    return NO;
}

-(void)loginUsingSession:(SPTSession *)session {
    NSLog(@"Entered loginUsingSession.");
    // Get the player instance
    self.player = [SPTAudioStreamingController sharedInstance];
    self.player.delegate = self;
    // Start the player (will start a thread)
    [self.player startWithClientId:@"af9f9402ffd648d2b23673caf008f4b1" error:nil];
    // Login SDK before we can start playback
    [self.player loginWithAccessToken:session.accessToken];
    NSLog(@"Leaving loginUsingSession.");
}

- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming {
    NSLog(@"Entered audioStreamingDidLogin.");
    [self.player playSpotifyURI:@"spotify:track:58s6EuEYJdlb0kO7awm3Vp" startingWithIndex:0 startingWithPosition:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** failed to play: %@", error);
            return;
        }
    }];
    NSLog(@"Leaving audioStreamingDidLogin.");
}

@end
