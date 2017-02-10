//
//  ViewController.h
//  iGitHub
//
//  Created by Maiko Trindade on 23/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtFldUsername;
@property (nonatomic, strong) User *user;

@end

