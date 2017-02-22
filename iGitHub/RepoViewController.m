//
//  RepoViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 20/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "RepoViewController.h"
#import "ReposTableViewCell.h"
#import "Repo.h"

@interface RepoViewController ()

@end

@implementation RepoViewController

@synthesize tableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReposTableViewCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReposTableViewCell" owner:nil options:nil] objectAtIndex: 0];
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
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
