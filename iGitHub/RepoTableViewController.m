//
//  RepoTableViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 01/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "RepoTableViewController.h"
#import "ReposTableViewCell.h"
#import "Repo.h"

@interface RepoTableViewController ()

@end

@implementation RepoTableViewController

@synthesize tableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReposTableViewCell" bundle:nil] forCellReuseIdentifier:@"repoCell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repoCell"];

    if (cell == nil) {
        cell = [[ReposTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"repoCell"];
    }
    
    Repo *repo = [tableData objectAtIndex:indexPath.row];
    
    cell.lblRepoName.text = repo.name;
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

@end
