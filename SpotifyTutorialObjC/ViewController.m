//
//  ViewController.m
//  SpotifyTutorialObjC
//
//  Created by Jacob Seibert on 11/1/16.
//  Copyright © 2016 Jacob Seibert. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGreeting];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)fetchGreeting;
{
    NSURL *url = [NSURL URLWithString:@"http://rest-service.guides.spring.io/greeting"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data.length > 0 && error == nil) {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
            self.greetingContent.text = [greeting objectForKey:@"content"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
