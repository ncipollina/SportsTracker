//
//  HeadlineViewCell.m
//  SportsTracker
//
//  Created by Nicholas Cipollina on 04/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadlineViewCell.h"
#import "SportsHeadline.h"

@implementation HeadlineViewCell
@synthesize headline = _headline;
@synthesize thumbnailView = _thumbnailView;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;

- (void)setHeadline:(SportsHeadline *)aHeadline {
    if (_headline != aHeadline) {
        [aHeadline retain];
        [_headline release];
        _headline = aHeadline;

        self.titleLabel.text = _headline.headlineText;
        self.descriptionLabel.text = _headline.description;

        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_headline.imageUrl]]];
        if (image)
            self.thumbnailView.image = image;
        else
            self.thumbnailView.image = [UIImage imageNamed:@"no_image.png"];
    }
//To change the template use AppCode | Preferences | File Templates.
}

- (void)dealloc {
    [_headline release];
    [_thumbnailView release];
    [_titleLabel release];
    [_descriptionLabel release];
    [super dealloc];
}


@end
