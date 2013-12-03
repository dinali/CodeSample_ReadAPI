//
//  mainViewController.m
//  CodeSample_ReadAPI
//
//  Created by ISD MacBook on 12/3/13.
//  Copyright (c) 2013 USDAERS. All rights reserved.
//

#import "mainViewController.h"
#import "GroupBuilder.h"
#import "DetailCell.h"
#import "Report.h"

//#define API_KEY @"1f5718c16a7fb3a5452f45193232"
//#define PAGE_COUNT 20
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kURL [NSURL URLWithString:@"http://api.data.gov/USDA/ERS/data/Arms/Reports?api_key=ZF7qInK0qpeRaDVcadQv7Tx9kwSR0pmMAyk9i6LG&survey=FINANCE"]

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self parseJSON];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)parseJSON
{
   // NSString *urlAsString = [NSString stringWithFormat:@"http://api.data.gov/census/american-community-survey/v1/2011/populations/states?api_key=ZF7qInK0qpeRaDVcadQv7Tx9kwSR0pmMAyk9i6LG"];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://api.data.gov/USDA/ERS/data/Arms/Reports?api_key=ZF7qInK0qpeRaDVcadQv7Tx9kwSR0pmMAyk9i6LG&survey=FINANCE"];    
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kURL];
        [self performSelectorOnMainThread:@selector(receivedGroupsJSON:) withObject:data waitUntilDone:YES];
        
        //[self receivedGroupsJSON:data];

    });
    /*
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self fetchingGroupsFailedWithError:error];
        } else {
            [self receivedGroupsJSON:data];
        }
    }];
     */
}

- (void)receivedGroupsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [GroupBuilder groupsFromJSON:objectNotation error:&error];
    
   // int arrayCount = groups.count;
    
    if (error != nil) {
        [self fetchingGroupsFailedWithError:error];
        
    } else {
        //[self didReceiveGroups:groups];
        NSLog(@"didReceiveGroups");
        _groups = groups;
        
        NSLog(@"group id = %@", [_groups objectAtIndex:1]);
        
        Report *testReport = [[Report alloc]init];
        testReport = [_groups objectAtIndex:1];
        
        NSLog(@"reportHeader = %@", testReport.report_header);
        
        //  self.tableView.dataSource = _groups;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}
/*
- (void)didReceiveGroups:(NSArray *)groups
{
    NSLog(@"didReceiveGroups");
    _groups = groups;
    
    NSLog(@"group id = %@", [_groups objectAtIndex:1]);
    
    Report *testReport = [[Report alloc]init];
    testReport = [_groups objectAtIndex:1];
    
    NSLog(@"reportHeader = %@", testReport.report_header);
    
   //  self.tableView.dataSource = _groups;
    [self.tableView reloadData];
}
*/
- (void)viewWillAppear:(BOOL)animated
{
   // [self.tableView reloadData];
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"top of tableView");
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Report *group = _groups[indexPath.row];
    [cell.nameLabel setText:group.report_header];
    [cell.idLabel setText:group.report_num];
    //[cell.locationLabel setText:[NSString stringWithFormat:@"%@, %@", group.city, group.country]];
    //[cell.descriptionLabel setText:group.description];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
