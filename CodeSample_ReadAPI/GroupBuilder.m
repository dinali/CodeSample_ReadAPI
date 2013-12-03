//
//  GroupBuilder.m
//  CodeSample_ReadAPI
//
//  Created by ISD MacBook on 12/3/13.
//  Copyright (c) 2013 USDAERS. All rights reserved.
//

#import "GroupBuilder.h"
#import "Report.h"

@implementation GroupBuilder
+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"dataTable"];
    // Censue returns an array instead of a dictionary; the keyword results shown above, is specific to the meetup API's dataset
  //  NSArray *keys = [parsedObject allKeys];
  //  NSArray *results = [parsedObject allValues];
    
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        Report *report = [[Report alloc] init];
        
        for (NSString *key in groupDic) {
            NSLog(@"key = %@", key);
            
            if ([report respondsToSelector:NSSelectorFromString(key)]) {
                [report setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:report];
    }
    
    return groups;
}
@end
