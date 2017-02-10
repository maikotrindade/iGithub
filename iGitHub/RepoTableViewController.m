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
    cell.lblFullname.text = repo.full_name;
    cell.lblName.text = repo.name;
    cell.lblCreatedAt.text = [repo.created_at substringWithRange:NSMakeRange(0, 10)];
    cell.lblUrl.text = repo.url;
    
    double sizeInMB = [repo.size integerValue]/1024.0;
    cell.lblSize.text = [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%.1lf", sizeInMB], @" megabytes"];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 124.f;
}

@end
