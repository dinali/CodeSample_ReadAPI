//
//  mainViewController.m
//  CodeSample_ReadAPI
//
//  Created by USDAERS on 12/3/13.
//  Code available in the public domain//
//

#import "mainViewController.h"
#import "GroupBuilder.h"
#import "DetailCell.h"
#import "Report.h"

/* replace this with your URL and data.gov api key available from: http://api.data.gov)  */

#define kURL @"http://api.data.gov/USDA/ERS/data/Arms/Reports?api_key=ZF7qInK0qpeRaDVcadQv7Tx9kwSR0pmMAyk9i6LG&survey=FINANCE"

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
         
    }
    return self;
}

/* display activity indicator in a label */
-(void)viewDidLoad
{
    _activitySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
     _activitySpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.48*self.tableView.frame.size.width-self.tableView.frame.size.width/4, 0.30*self.tableView.frame.size.height, 50, self.tableView.frame.size.height/8.179)];
    
    [ _activitySpinner setBackgroundColor:[UIColor blackColor]];
    _activitySpinner.hidesWhenStopped = YES;
    
    [_activitySpinner startAnimating];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.5*self.tableView.frame.size.width-self.tableView.frame.size.width/4, 0.30*self.tableView.frame.size.height, self.tableView.frame.size.width/2, _activitySpinner.bounds.size.height)];

    _label.font = [UIFont boldSystemFontOfSize:15.0f];
    _label.numberOfLines = 1;
    
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.text = @"    Loading......";
    _label.textAlignment = NSTextAlignmentCenter;
    
    [self.tableView addSubview:_label];
    [self.tableView addSubview: _activitySpinner];
}

/* Description: requests data from API and serializes the JSON results for display in the table */

- (void)viewDidAppear:(BOOL)animated
{
  
    NSString *urlAsString = [NSString stringWithFormat:kURL];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self fetchingGroupsFailedWithError:error];
        } else {
            NSError *error = nil;
            NSArray *groups = [GroupBuilder groupsFromJSON:data error:&error];
            
            if (error != nil) {
                [self fetchingGroupsFailedWithError:error];
                
            } else {
                                
                _groups = groups;
                [self.tableView reloadData];
                                
                /* debugging
                Report *testReport = [[Report alloc]init];
                testReport = [_groups objectAtIndex:1];
                
                NSLog(@"reportHeader = %@", testReport.report_header);
                */
 
            }
        }
    }];
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    [_activitySpinner stopAnimating];
    [_label removeFromSuperview];
    
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    UIAlertView *alertMe = [[UIAlertView alloc]initWithTitle:@"Error"
                                                     message:[error localizedDescription]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertMe show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    /* TODO: show your data by calling your object model class */
    
    Report *group = _groups[indexPath.row];
    [cell.nameLabel setText:group.report_header];
    
    NSString *numberAsText = [NSString stringWithFormat:@"%@", group.report_num];

    [cell.idLabel setText:numberAsText];
    
    [_activitySpinner stopAnimating];
    [_label removeFromSuperview];
    
    return cell;
}

#pragma mark - Rotation and Cleanup

//  supportedInterfaceOrientations
//  Support portrait (iOS 6).

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
