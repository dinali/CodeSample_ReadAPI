//
//  mainViewController.h
//  CodeSample_ReadAPI
//
//  Created by ISD MacBook on 12/3/13.
//  Copyright (c) 2013 USDAERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UITableViewController

@property(strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)parseJSON;

@end
