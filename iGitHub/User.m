//
//  User.m
//  iGitHub
//
//  Created by Maiko Trindade on 30/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

+(User *) parse:(NSDictionary *) responseObject {
    User *user = [[User alloc] init];
    [user setName: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"name"]]];
    [user setAvatar_url: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"avatar_url"]]];
    [user setHtml_url: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"html_url"]]];
    [user setFollowers_url: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"followers_url"]]];
    [user setRepos_url: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"repos_url"]]];
    [user setBlog: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"blog"]]];
    [user setLocation: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"location"]]];
    [user setBio: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"bio"]]];
    [user setCreated_at: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"created_at"]]];
    return user;
}

@end
