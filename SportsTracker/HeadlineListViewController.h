//
//  HeadlineListViewController.h
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APIManager.h"
#import "ArticleViewController.h"

@class SportsLeague;

@interface HeadlineListViewController : UITableViewController <APIManagerDelegate>{
    UINib *cellLoader;

}

@property (retain) UIActivityIndicatorView *activityIndicator;
@property (retain) SportsLeague *league;
@property (retain) NSString *sport;
@property (retain) NSArray *headLines;
@property (retain) ArticleViewController *articleViewController;

@end
