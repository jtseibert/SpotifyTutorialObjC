//
//  ViewController.h
//  SpotifyTutorialObjC
//
//  Created by Jacob Seibert on 11/1/16.
//  Copyright © 2016 Jacob Seibert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;

-(IBAction)fetchGreeting;

@end

