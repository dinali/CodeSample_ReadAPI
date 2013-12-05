//
//  mainViewController.h
//  CodeSample_ReadAPI
//  Credits: http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
//  Created by USDAERS on 12/3/13.
//  Code available in the public domain//

#import <UIKit/UIKit.h>

@interface mainViewController : UITableViewController

@property(strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIActivityIndicatorView *activitySpinner;
@property (strong, nonatomic) UILabel *label;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
