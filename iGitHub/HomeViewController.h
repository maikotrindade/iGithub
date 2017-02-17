//
//  ViewController.h
//  iGitHub
//
//  Created by Maiko Trindade on 23/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserTableViewController.h"

@interface HomeViewController : UIViewController <UserTableViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtFldUsername;
@property (nonatomic, strong) User *user;
@property (strong) NSMutableArray *users;

@property (strong, nonatomic) IBOutlet UITableView *usersTableView;


@end

