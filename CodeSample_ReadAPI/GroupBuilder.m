//
//  GroupBuilder.m
//  CodeSample_ReadAPI
//  Adapted from: http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
//  Created by USDAERS on 12/3/13.
//  Code available in the public domain
//

#import "GroupBuilder.h"
#import "Report.h"

@implementation GroupBuilder

/* Parameter is the data retrieved from the API service */
/* TODO: show your data by calling your object model class */
+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    // NOTE: valueForKey is the name of the dictionary returned from the JSON feed
    NSArray *results = [parsedObject valueForKey:@"dataTable"];
    
    for (NSDictionary *groupDic in results) {
        Report *report = [[Report alloc] init];  // replace this
        
        for (NSString *key in groupDic) {
            // NSLog(@"key = %@", key);
            
            if ([report respondsToSelector:NSSelectorFromString(key)]) {
                [report setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        [groups addObject:report];
    }
    return groups;
}
@end
