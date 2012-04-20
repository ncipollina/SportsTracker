//
//  MasterViewController.h
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@class LeagueViewController;

@interface MasterViewController : UITableViewController <APIManagerDelegate>

@property (strong, nonatomic) LeagueViewController *leagueViewController;
@property (retain) UIActivityIndicatorView *activityIndicator;
@property (retain) NSArray *sports;

@end