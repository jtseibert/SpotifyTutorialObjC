//
//  AppDelegate.h
//  SpotifyTutorialObjC
//
//  Created by Jacob Seibert on 11/1/16.
//  Copyright © 2016 Jacob Seibert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpotifyMetadata/SpotifyMetadata.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate, SPTAudioStreamingDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

