//
//  LeagueViewController.m
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LeagueViewController.h"
#import "Constants.h"
#import "SportsLeague.h"

@interface LeagueViewController ()

@end

@implementation LeagueViewController
@synthesize sport = _sport;
@synthesize activityIndicator = _activityIndicator;
@synthesize leagues = _leagues;
@synthesize headLineListViewController = _headLineListViewController;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

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

    self.navigationItem.title = [NSString stringWithFormat:@"%@: Leagues", [self.sport capitalizedString]];
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

    APIManager *apiManager = [[[APIManager alloc] initWithDelegate:self] autorelease];
    [apiManager process:[self setMyUrl]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.leagues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    SportsLeague *league = [self.leagues objectAtIndex:indexPath.row];
    cell.textLabel.text = league.leagueName;

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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    self.headLineListViewController = [[[HeadlineListViewController alloc] initWithNibName:@"HeadlineListViewController" bundle:nil] autorelease];
    SportsLeague *league = [self.leagues objectAtIndex:indexPath.row];
    self.headLineListViewController.league = league;
    self.headLineListViewController.sport = self.sport;
    [self.navigationController pushViewController:self.headLineListViewController animated:YES];
}

- (void)requestDataReady:(NSDictionary *)dataItems {
    NSMutableArray *leagues = [[NSMutableArray new] autorelease];

    NSDictionary *leagueDict =[[dataItems objectForKey:@"sports"] objectAtIndex:0];

    [[leagueDict objectForKey:@"leagues"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        [leagues addObject:[[[SportsLeague alloc] initWithDictionary:obj] autorelease]];
    }];

    self.leagues =  [NSArray arrayWithArray:leagues];
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (NSURL *)setMyUrl {
    NSString *urlString = [NSString stringWithFormat:@"%@%@/sports/%@?apiKey=%@",API_BASE_URI,API_VERSION,self.sport ,API_KEY];
    NSURL *myUrl = [NSURL URLWithString:urlString];
    return myUrl;
}

- (void)dealloc {
    [_sport release];
    [_activityIndicator release];
    [_leagues release];
    [_headLineListViewController release];
    [super dealloc];
}

@end
