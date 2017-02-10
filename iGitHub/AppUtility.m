//
//  AppUtility.m
//  iGitHub
//
//  Created by Maiko Trindade on 10/02/17.
//  Copyright © 2017 Maiko Trindade. All rights reserved.
//

#import "AppUtility.h"

@implementation AppUtility

+ (NSDictionary *)dictionaryByReplacingNullsWithBlanks:(NSDictionary *) dictionary {
    const NSMutableDictionary *replaced = [dictionary mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in dictionary) {
        id object = [dictionary objectForKey:key];
        if (object == nul) [replaced setObject:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks:object] forKey:key];
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks:object ] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

+ (NSArray *)arrayByReplacingNullsWithBlanks:(NSArray *) array {
    NSMutableArray *replaced = [array mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks:object]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks:object]];
    }
    return [replaced copy];
}

@end
