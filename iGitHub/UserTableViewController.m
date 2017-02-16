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

@interface UserTableViewController ()

@end

@implementation UserTableViewController

@synthesize usersTableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"UsersTableViewCell" bundle:nil] forCellReuseIdentifier:@"UsersCell"];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsersCell"];
    
    if (cell == nil) {
        cell = [[UsersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsersCell"];
    }
    
    User *user = [usersTableData objectAtIndex:indexPath.row];
    cell.lblUsername.text = @"Maiko";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return usersTableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.f;
}

@end
