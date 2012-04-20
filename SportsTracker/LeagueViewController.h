//
//  LeagueViewController.h
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APIManager.h"
#import "HeadlineListViewController.h"


@interface LeagueViewController : UITableViewController <APIManagerDelegate>

@property (retain) UIActivityIndicatorView *activityIndicator;
@property (retain) NSString *sport;
@property (retain) NSArray *leagues;
@property (retain) HeadlineListViewController *headLineListViewController;

@end
