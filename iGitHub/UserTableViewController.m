//
//  UserTableViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 16/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "UserTableViewController.h"
#import "User.h"
#import "UsersTableViewCell.h"
#import "GetInfoViewController.h"

@interface UserTableViewController ()

@end

@implementation UserTableViewController

@synthesize usersTableData;

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsersTableViewCell"];
    
    if (cell == nil) {
        cell = [[UsersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsersTableViewCell"];
    }
    
    User *user = [usersTableData objectAtIndex:indexPath.row];
    
    if(user.name.length) {
        cell.lblUsername.text = user.name;
    } else {
        cell.lblUsername.text = user.login;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return usersTableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = [usersTableData objectAtIndex:indexPath.row];
    [self.navDelegate openGetInfoScreen:self withUser:user];
}
        
@end
