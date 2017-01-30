//
//  LoginViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 27/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "GetInfoViewController.h"
#import "AFHTTPSessionManager.h"

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
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/users/maikotrindade" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
