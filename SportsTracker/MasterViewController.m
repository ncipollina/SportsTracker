//
//  MasterViewController.m
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "LeagueViewController.h"
#import "Constants.h"

@interface MasterViewController ()
@end

@implementation MasterViewController

@synthesize activityIndicator = _activityIndicator;
@synthesize sports = _sports;
@synthesize leagueViewController = _leagueViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

- (void)requestDataReady:(NSDictionary *)dataItems {
    NSArray *sports =  [dataItems objectForKey:@"sports"];

    NSMutableArray *mutableItems = [[NSMutableArray new] autorelease];

    for (NSDictionary *sport in sports){
        [mutableItems addObject:[sport objectForKey:@"name"]];
    }

    self.sports = [NSArray arrayWithArray:mutableItems];
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];

}

- (NSURL *)setMyUrl {
    NSString *urlString = [NSString stringWithFormat:@"%@%@/sports?apiKey=%@",API_BASE_URI,API_VERSION,API_KEY];
    NSURL *myUrl = [NSURL URLWithString:urlString];
    return myUrl;
}


- (void)dealloc
{
    [_activityIndicator release];
    _activityIndicator = nil;
    [_sports release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
    self.activityIndicator = [[[UIActivityIndicatorView alloc]
            initWithFrame:frame] autorelease];
    [self.activityIndicator sizeToFit];
    self.activityIndicator.autoresizingMask =
            (UIViewAutoresizingFlexibleLeftMargin |
                    UIViewAutoresizingFlexibleRightMargin |
                    UIViewAutoresizingFlexibleTopMargin |
                    UIViewAutoresizingFlexibleBottomMargin);
    [self.activityIndicator startAnimating];


    UIBarButtonItem *loadingView = [[[UIBarButtonItem alloc]
            initWithCustomView:self.activityIndicator] autorelease];
    loadingView.target = self;
    self.navigationItem.rightBarButtonItem = loadingView;

    self.navigationItem.title = @"Sports";

    APIManager *apiManager = [[[APIManager alloc] initWithDelegate:self] autorelease];
    [apiManager process:[self setMyUrl]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sports.count;

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }


    NSString *sport = [self.sports objectAtIndex:indexPath.row];
    cell.textLabel.text = [sport capitalizedString];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.leagueViewController = [[[LeagueViewController alloc] initWithNibName:@"LeagueViewController" bundle:nil] autorelease];
    NSString *sport = [self.sports objectAtIndex:indexPath.row];
    self.leagueViewController.sport = sport;
    [self.navigationController pushViewController:self.leagueViewController animated:YES];
}

@end