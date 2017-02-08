//
//  LoginViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 27/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "GetInfoViewController.h"
#import "AFHTTPSessionManager.h"
#import "User.h"
#import "Repo.h"
#import "RepoTableViewController.h"

@interface GetInfoViewController ()

@end

@implementation GetInfoViewController 

@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getInfo];
}

- (void) getInfo {
    [self showProgress];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/users/maikotrindade" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.user = [User parse:responseObject];
        [self stopProgress];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self stopProgress];
        [self showErrorMessage];
    }];
}

-(void) showProgress {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.tag = 666;
    CGPoint centerImageView = spinner.center;
    centerImageView.x = self.view.center.x;
    centerImageView.y = self.view.center.y;
    spinner.center = centerImageView;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void) stopProgress {
    [[self.view viewWithTag:666] stopAnimating];
}

-(void) showErrorMessage {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Title"
                                 message:@"Message"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

# pragma ACTIONS

- (IBAction)repoListButtonTapped:(id)sender {
    [self showProgress];
    
    NSString *reposUrl = self.user.repos_url;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:reposUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *responseArray = responseObject;

        RepoTableViewController *controller = [[RepoTableViewController alloc] initWithNibName:@"RepoTableViewController" bundle:nil];
        [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        controller.tableData = [[NSMutableArray alloc] initWithArray:[Repo parse:responseArray]];
        [self presentViewController:controller animated:YES completion:nil];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self stopProgress];
        [self showErrorMessage];
    }];
    
}

@end
