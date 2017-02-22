//
//  User.h
//  iGitHub
//
//  Created by Maiko Trindade on 30/01/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(strong, nonatomic) NSString *_id;
@property(strong, nonatomic) NSString *login;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *avatar_url;
@property(strong, nonatomic) NSString *html_url;
@property(strong, nonatomic) NSString *followers;
@property(strong, nonatomic) NSString *repos_url;
@property(strong, nonatomic) NSString *blog;
@property(strong, nonatomic) NSString *location;
@property(strong, nonatomic) NSString *bio;
@property(strong, nonatomic) NSString *created_at;

+(User *) parse:(NSDictionary *) responseObject;

@end
