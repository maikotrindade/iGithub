//
//  ReposTableViewCell.h
//  iGitHub
//
//  Created by Maiko Trindade on 01/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReposTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblUrl;
@property (weak, nonatomic) IBOutlet UILabel *lblFullname;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@end
