//
//  Repo.h
//  iGitHub
//
//  Created by Maiko Trindade on 01/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property(strong, nonatomic) NSString *has_wiki;
@property(strong, nonatomic) NSString *homepage;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *size;
@property(strong, nonatomic) NSString *language;
@property(strong, nonatomic) NSString *forks_count;
@property(strong, nonatomic) NSString *watchers_count;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *created_at;
@property(strong, nonatomic) NSString *forks;
@property(strong, nonatomic) NSString *git_url;
@property(strong, nonatomic) NSString *full_name;

+(NSMutableArray *) parse:(NSArray *) responseArray ;



@end
