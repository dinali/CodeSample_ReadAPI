//
//  GroupBuilder.h
//  CodeSample_ReadAPI
//
//  Created by ISD MacBook on 12/3/13.
//  Copyright (c) 2013 USDAERS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
