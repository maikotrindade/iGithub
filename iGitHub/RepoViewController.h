//
//  RepoViewController.h
//  iGitHub
//
//  Created by Maiko Trindade on 20/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
