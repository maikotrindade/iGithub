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
#import "RepoViewController.h"

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
        
        if (user.blog.length) {
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
    
    //imageProfile settings
    imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.size.width / 2;
    imgProfilePicture.clipsToBounds = YES;
    if (user.image_path) {
        UIImage *image = [UIImage imageWithContentsOfFile:user.image_path];
        imgProfilePicture.image = image;
    } else {
        if (filePath) {
            UIImage *image = [UIImage imageWithContentsOfFile:filePath];
            imgProfilePicture.image = image;
        } else {
            UIImage *image = [UIImage imageNamed:@"user"];
            imgProfilePicture.image = image;
        }
    }
}

-(void) showProgress {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.tag = 666;
    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
    spinner.color = [UIColor colorWithRed:41.0f/255.0f
                                    green:98.0f/255.0f
                                     blue:255.0f/255.0f
                                    alpha:1.0f];
    CGPoint centerImageView = spinner.center;
    centerImageView.x = self.view.center.x;
    centerImageView.y = self.view.center.y;
    spinner.center = centerImageView;
    
    UIView *squareView = [[UIView alloc] initWithFrame:CGRectMake(60,60,60,60)];
    squareView.tag = 667;
    squareView.backgroundColor = [UIColor colorWithRed:41.0f/255.0f
                                                 green:98.0f/255.0f
                                                  blue:255.0f/255.0f
                                                 alpha:0.5f];
    squareView.layer.borderColor = [[UIColor colorWithRed:41.0f/255.0f
                                                    green:98.0f/255.0f
                                                     blue:255.0f/255.0f
                                                    alpha:0.5f] CGColor];
    squareView.layer.borderWidth = 1.5;
    squareView.layer.cornerRadius = 7;
    squareView.layer.masksToBounds = YES;
    squareView.center = centerImageView;
    
    [self.view addSubview:squareView];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void) stopProgress {
    [[self.view viewWithTag:666] removeFromSuperview];
    [[self.view viewWithTag:667] removeFromSuperview];
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

        RepoViewController *controller = [[RepoViewController alloc] initWithNibName:@"RepoViewController" bundle:nil];
        [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        controller.tableData = [[NSMutableArray alloc] initWithArray:[Repo parse:responseArray]];
        [self stopProgress];
        [self presentViewController:controller animated:YES completion:nil];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self stopProgress];
        [self showErrorMessage];
    }];
    
}


- (IBAction)backButtonTapped:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
