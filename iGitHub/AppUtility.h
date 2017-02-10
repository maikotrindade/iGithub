//
//  AppUtility.h
//  iGitHub
//
//  Created by Maiko Trindade on 10/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtility : NSObject 

+ (NSDictionary *)dictionaryByReplacingNullsWithBlanks:(NSDictionary *) dictionary;
+ (NSArray *)arrayByReplacingNullsWithBlanks:(NSArray *) array;

@end
