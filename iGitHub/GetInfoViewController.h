//
//  LoginViewController.h
//  iGitHub
//
//  Created by Maiko Trindade on 27/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface GetInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblBiography;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (strong, nonatomic) IBOutlet UILabel *lblBlog;
@property (strong, nonatomic) IBOutlet UILabel *lblGitHub;
@property (strong, nonatomic) IBOutlet UILabel *lblFollowers;

@property (nonatomic, strong) User *user;

@end
