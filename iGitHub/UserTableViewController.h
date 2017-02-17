//
//  UserTableViewController.h
//  iGitHub
//
//  Created by Maiko Trindade on 16/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class UserTableViewController;
@protocol UserTableViewControllerDelegate <NSObject>
- (void) openGetInfoScreen: (UserTableViewController *) sender withUser:(User *)user;
@end

@interface UserTableViewController : UITableViewController

@property (nonatomic, weak) id <UserTableViewControllerDelegate> navDelegate;

@property (strong, nonatomic) NSMutableArray *usersTableData;

@end
