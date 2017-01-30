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

+ (User *)parse:(NSDictionary *) responseObject; {
    User *user = [[User alloc] init];
    NSString *name = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"name"]];
    [user setName: name];
    return user;
}

@end
