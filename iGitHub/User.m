//
//  User.m
//  iGitHub
//
//  Created by Maiko Trindade on 30/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "AppUtility.h"

@implementation User

+(User *) parse:(NSDictionary *) responseObject {
    User *user = [[User alloc] init];
    
    NSDictionary *dictionaryResponse = [AppUtility dictionaryByReplacingNullsWithBlanks:responseObject];
    
    [user set_id: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"id"]]];
    [user setLogin: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"login"]]];
    [user setName: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"name"]]];
    [user setAvatar_url: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"avatar_url"]]];
    [user setHtml_url: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"html_url"]]];
    [user setFollowers: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"followers"]]];
    [user setRepos_url: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"repos_url"]]];
    [user setBlog: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"blog"]]];
    [user setLocation: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"location"]]];
    [user setBio: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"bio"]]];
    [user setCreated_at: [NSString stringWithFormat:@"%@", [dictionaryResponse objectForKey:@"created_at"]]];
    
    return user;
}

@end
