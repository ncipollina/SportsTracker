//
//  HeadlineListViewController.m
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadlineListViewController.h"
#import "Constants.h"
#import "SportsHeadline.h"
#import "HeadlineViewCell.h"
#import "SportsLeague.h"

@interface HeadlineListViewController ()

@end

@implementation HeadlineListViewController
@synthesize league = _league;
@synthesize sport = _sport;
@synthesize activityIndicator = _activityIndicator;
@synthesize headLines = _headLines;
@synthesize articleViewController = _articleViewController;
static NSString *CellClassName = @"HeadlineViewCell";


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

    cellLoader = [[UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]] retain];

    self.navigationItem.title = [NSString stringWithFormat:@"%@ Headlines", self.league.leagueName];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.headLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellClassName];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }

    SportsHeadline *headline = [self.headLines objectAtIndex:indexPath.row];
    cell.headline = headline;

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
    self.articleViewController = [[[ArticleViewController alloc] initWithNibName:@"ArticleViewController" bundle:nil] autorelease];
    SportsHeadline *headline = [self.headLines objectAtIndex:indexPath.row];
    self.articleViewController.url = headline.articleLink;
    [self.navigationController pushViewController:self.articleViewController animated:YES];
}

- (NSURL *)setMyUrl {
    NSString *urlString = [NSString stringWithFormat:@"%@%@/sports/%@/%@/news/headlines?apiKey=%@",API_BASE_URI,API_VERSION,self.sport, self.league.leagueAbbreviation ,API_KEY];
    NSURL *myUrl = [NSURL URLWithString:urlString];
    return myUrl;
}

- (void)requestDataReady:(NSDictionary *)dataItems {
    NSMutableArray *headLines = [[NSMutableArray new] autorelease];

    [[dataItems objectForKey:@"headlines"] enumerateObjectsUsingBlock:^(id obj, NSUInteger indx, BOOL *stop){
        [headLines addObject:[[[SportsHeadline alloc] initWithDictionary:obj] autorelease]];
    }];

    self.headLines = [NSArray arrayWithArray:headLines];
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (void)dealloc {
    [_league release];
    [_sport release];
    [_activityIndicator release];
    [_headLines release];
    [_articleViewController release];
    [cellLoader release];
    [super dealloc];
}

@end
