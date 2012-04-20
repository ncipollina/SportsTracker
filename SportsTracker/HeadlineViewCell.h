//
//  HeadlineViewCell.h
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@class SportsHeadline;

@interface HeadlineViewCell : UITableViewCell

@property (retain) SportsHeadline *headline;

@property (retain, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
