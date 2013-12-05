//
//  Report.h
//  CodeSample_ReadAPI
//
//  Created by USDAERS on 12/3/13.
//  Code available in the public domain

#import <Foundation/Foundation.h>

/* Sample model class, replace this with a class that reflects the API data that you want to display */

@interface Report : NSObject

@property (strong, nonatomic) NSString *report_num;
@property (strong, nonatomic) NSString *report_header;

@end
