//
//  Repo.m
//  iGitHub
//
//  Created by Maiko Trindade on 01/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "Repo.h"

@implementation Repo

@synthesize has_wiki;
@synthesize homepage;
@synthesize url;
@synthesize size;
@synthesize language;
@synthesize forks_count;
@synthesize watchers_count;
@synthesize name;
@synthesize created_at;
@synthesize forks;
@synthesize git_url;
@synthesize full_name;

+(NSMutableArray *) parse:(NSArray *) responseArray {
    
    NSMutableArray *repoArray = [[NSMutableArray alloc] init];
    for (NSDictionary *responseObject in responseArray) {
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
        
        [repoArray addObject: repo];
    }
    
    return repoArray;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Repo: has_wiki=%@ homepage=%@ url=%@ size=%@ language=%@ forks_count=%@ watchers_count=%@ name=%@ created_at=%@ forks=%@ git_url=%@ full_name=%@ ", has_wiki, homepage, url, size, language, forks_count, watchers_count, name, created_at, forks, git_url, full_name];
}

@end
