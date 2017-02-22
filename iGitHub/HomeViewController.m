//
//  ViewController.m
//  iGitHub
//
//  Created by Maiko Trindade on 23/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "HomeViewController.h"
#import "GetInfoViewController.h"
#import "AFHTTPSessionManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "UserTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController 

NSManagedObjectContext *managedObjectContext;

@synthesize txtFldUsername, user, users, usersTableView, filePath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    managedObjectContext = [AppDelegate getManagedContext];
    [self bindUsersTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindUsersTableView];
}

-(void) bindUsersTableView {
    [self getUsers];
    UserTableViewController *tableViewController = [[UserTableViewController alloc] init];
    //workaround for registering tableview inside another view controller
    [usersTableView registerNib:[UINib nibWithNibName:@"UsersTableViewCell" bundle:nil] forCellReuseIdentifier:@"UsersTableViewCell"];
    tableViewController.usersTableData = users;
    usersTableView.dataSource = tableViewController;
    usersTableView.delegate = tableViewController;
    [self addChildViewController:tableViewController];
    [usersTableView reloadData];
    tableViewController.navDelegate = self;
}

- (void) openGetInfoScreen: (UserTableViewController *) sender withUser:(User *)userSelected{
    self.user = userSelected;
    [self performSegueWithIdentifier:@"HomeScreenToGetInfoScreen" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HomeScreenToGetInfoScreen"] == YES) {
        GetInfoViewController *controller = segue.destinationViewController;
        controller.user = self.user;
        controller.filePath = self.filePath;
    }
}

- (void) getInfoWithUser :(NSString *) username {
    [self showProgress];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url = [NSString stringWithFormat:@"%@%@", @"https://api.github.com/users/", username];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.user = [User parse:responseObject];
        [self getPictureWithURL:user.avatar_url];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self stopProgress];
        [self showError];
    }];
}

- (void) getPictureWithURL:(NSString *)pictureURL {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:pictureURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePathUrl, NSError *error) {
        self.filePath = [filePathUrl path];
        self.user.image_path = [filePathUrl path];
        [self performSegueWithIdentifier:@"HomeScreenToGetInfoScreen" sender:self];
        [self saveUser];
        [self stopProgress];
    }];
    [downloadTask resume];
}

-(void) showProgress {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.tag = 666;
    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
    spinner.color = [UIColor colorWithRed:41.0f/255.0f
                                    green:98.0f/255.0f
                                     blue:255.0f/255.0f
                                    alpha:1.0f];
    CGPoint centerImageView = spinner.center;
    centerImageView.x = self.view.center.x;
    centerImageView.y = self.view.center.y;
    spinner.center = centerImageView;
    
    UIView *squareView = [[UIView alloc] initWithFrame:CGRectMake(60,60,60,60)];
    squareView.tag = 667;
    squareView.backgroundColor = [UIColor colorWithRed:41.0f/255.0f
                                                 green:98.0f/255.0f
                                                  blue:255.0f/255.0f
                                                 alpha:0.5f];
    squareView.layer.borderColor = [[UIColor colorWithRed:41.0f/255.0f
                                                    green:98.0f/255.0f
                                                     blue:255.0f/255.0f
                                                    alpha:0.5f] CGColor];
    squareView.layer.borderWidth = 1.5;
    squareView.layer.cornerRadius = 7;
    squareView.layer.masksToBounds = YES;
    squareView.center = centerImageView;
    
    [self.view addSubview:squareView];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)saveUser {
    
    //check whether this user is already registered or not
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User_Table"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %@", user._id]];
    NSArray *usersAlreadyDB = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    if (usersAlreadyDB.count == 0) {
        NSManagedObject *userManagedObj = [NSEntityDescription insertNewObjectForEntityForName:@"User_Table" inManagedObjectContext:managedObjectContext];
        [userManagedObj setValue:user._id forKey:@"id"];
        [userManagedObj setValue:user.name forKey:@"name"];
        [userManagedObj setValue:user.login forKey:@"login"];
        [userManagedObj setValue:user.image_path forKey:@"image_path"];
        [userManagedObj setValue:user.followers forKey:@"followers"];
        [userManagedObj setValue:user.avatar_url forKey:@"avatar_url"];
        [userManagedObj setValue:user.html_url forKey:@"html_url"];
        [userManagedObj setValue:user.bio forKey:@"bio"];
        [userManagedObj setValue:user.repos_url forKey:@"repos_url"];
        [userManagedObj setValue:user.blog forKey:@"blog"];
        [userManagedObj setValue:user.location forKey:@"location"];
        [userManagedObj setValue:user.created_at forKey:@"created_at"];
    } else {
        User *userUpdate = usersAlreadyDB[0];
        [userUpdate setValue:user._id forKey:@"id"];
        [userUpdate setValue:user.name forKey:@"name"];
        [userUpdate setValue:user.login forKey:@"login"];
        [userUpdate setValue:user.image_path forKey:@"image_path"];
        [userUpdate setValue:user.followers forKey:@"followers"];
        [userUpdate setValue:user.avatar_url forKey:@"avatar_url"];
        [userUpdate setValue:user.html_url forKey:@"html_url"];
        [userUpdate setValue:user.bio forKey:@"bio"];
        [userUpdate setValue:user.repos_url forKey:@"repos_url"];
        [userUpdate setValue:user.blog forKey:@"blog"];
        [userUpdate setValue:user.location forKey:@"location"];
        [userUpdate setValue:user.created_at forKey:@"created_at"];
    }

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        [self showError];
    }
}

- (void) getUsers {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User_Table"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

-(void) stopProgress {
    [[self.view viewWithTag:666] removeFromSuperview];
    [[self.view viewWithTag:667] removeFromSuperview];
}

-(void) showError {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Something unexpected happened"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Okay"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) showErrorWithMessage : (NSString *)message withTitle:(NSString *)title {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Okay"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)getInfoButtonTapped:(id)sender {
    //trimming string
    NSString *username = username = [txtFldUsername.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
    if (username.length) {
      [self getInfoWithUser:username];
    } else {
        [self showErrorWithMessage:@"Please, fill all required fields" withTitle:@"Error"];
    }
}

- (IBAction)exitButtonTapped:(id)sender {
    exit(0);
}


@end
