//
//  ViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 23/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "HomeViewController.h"
#import "GetInfoViewController.h"
#import "ConstantsUtil.h"
#import "AFHTTPSessionManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize txtFldUsername, user;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HomeScreenToGetInfoScreen"] == YES) {
        GetInfoViewController *controller = segue.destinationViewController;
        controller.user = self.user;
    }
}

- (void) getInfo {
    [self showProgress];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *username = username = txtFldUsername.text;;
    NSString *url = [NSString stringWithFormat:@"%@%@", @"https://api.github.com/users/", username];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.user = [User parse:responseObject];
        [self saveUser];
        [self performSegueWithIdentifier:@"HomeScreenToGetInfoScreen" sender:self];
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

- (void)saveUser {
    NSManagedObjectContext *context = [AppDelegate getManagedContext];
    
    // Create a new managed object
    NSManagedObject *userManagedObj = [NSEntityDescription insertNewObjectForEntityForName:@"User_Table" inManagedObjectContext:context];
    [userManagedObj setValue:user.name forKey:@"name"];
    [userManagedObj setValue:user.followers forKey:@"followers"];
    [userManagedObj setValue:user.avatar_url forKey:@"avatar_url"];
    [userManagedObj setValue:user.html_url forKey:@"html_url"];
    [userManagedObj setValue:user.bio forKey:@"bio"];
    [userManagedObj setValue:user.repos_url forKey:@"repos_url"];
    [userManagedObj setValue:user.blog forKey:@"blog"];
    [userManagedObj setValue:user.location forKey:@"location"];
    [userManagedObj setValue:user.created_at forKey:@"created_at"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        [self showErrorMessage];
    } else {
        NSLog(@"User %@ saved successfully", user.name);
    }
    
}

-(void) stopProgress {
    [[self.view viewWithTag:666] stopAnimating];
}

-(void) showErrorMessage {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Something unexpected happened"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Okay"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)getInfoButtonTapped:(id)sender {
    [self getInfo];
}



@end
