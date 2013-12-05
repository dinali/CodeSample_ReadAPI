//
//  GroupBuilder.h
//  CodeSample_ReadAPI
//
//  Created by USDAERS on 12/3/13.
//  Code available in the public domain
//

#import <Foundation/Foundation.h>

/* Description: returns an array of objects by serializing the API json data */

@interface GroupBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
