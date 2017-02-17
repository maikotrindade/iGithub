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

@synthesize user, lblName, lblBiography, lblLocation, lblBlog, lblCreatedAt, lblGitHub, lblFollowers, filePath, imgProfilePicture;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureElements];
}

-(void) configureElements {
    if (user) {
        [lblName setText:user.name];
        [lblFollowers setText:user.followers];
        [lblCreatedAt setText:[user.created_at substringWithRange:NSMakeRange(0, 10)]];
        [lblGitHub setText:user.html_url];
        
        if (user.bio || [user.bio length] == 0) {
            [lblBlog setText:user.blog];
        } else {
            [lblBlog setText:@"Not available"];
        }
        
        if (user.bio || [user.bio length] == 0) {
            [lblBiography setText:user.bio];
        } else {
            lblBiography.frame = CGRectZero;
        }
        if (user.location || [user.location length] == 0) {
            [lblLocation setText:user.location];
        } else {
            lblLocation.frame = CGRectZero;
        }
    } else {
        [self showErrorMessage];
    }
    
    if (filePath) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        imgProfilePicture.image = image;
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.size.width / 2;
        imgProfilePicture.clipsToBounds = YES;
    }
    
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
