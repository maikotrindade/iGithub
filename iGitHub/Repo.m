//
//  Repo.m
//  iGitHub
//
//  Created by Maiko Trindade on 01/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "Repo.h"

@implementation Repo

+(Repo *) parse:(NSDictionary *) responseObject {
    Repo *repo = [[Repo alloc] init];
    [repo setHas_wiki: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"has_wiki"]]];
    [repo setHomepage: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"homepage"]]];
    [repo setUrl: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"url"]]];
    [repo setSize: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"size"]]];
    [repo setLanguage: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"language"]]];
    [repo setForks_count: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"forks_count"]]];
    [repo setWatchers_count: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"watchers_count"]]];
    [repo setName: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"name"]]];
    [repo setCreated_at: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"created_at"]]];
    [repo setForks: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"forks"]]];
    [repo setGit_url: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"git_url"]]];
    [repo setFull_name: [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"full_name"]]];
    return repo;
}

@end
