//
//  LoginViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 27/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "GetInfoViewController.h"

@interface GetInfoViewController ()

@end

@implementation GetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getInfo {
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:@"https://api.github.com/users/maikotrindade"
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    
}

@end
