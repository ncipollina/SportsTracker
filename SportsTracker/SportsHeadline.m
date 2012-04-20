//
//  Created by ncipollina on 4/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SportsHeadline.h"


@implementation SportsHeadline {

}
@synthesize articleLink = _articleLink;
@synthesize description = _description;
@synthesize headlineText = _headlineText;
@synthesize imageUrl = _imageUrl;

- (id)initWithDictionary:(NSDictionary *)theData {
    self = [super init];
    if (self){
        _headlineText = [[theData objectForKey:@"headline"] copy];
        _description = [[theData objectForKey:@"linkText"] copy];

        NSDictionary *links = [theData objectForKey:@"links"];
        NSDictionary *mobile = [links objectForKey:@"mobile"];
        _articleLink = [[mobile objectForKey:@"href"] copy];

        NSArray *images = [theData objectForKey:@"images"];
        if (images != nil && images.count > 0){
            NSDictionary *image = [[theData objectForKey:@"images"] objectAtIndex:0];
            if (image){
                _imageUrl = [[image objectForKey:@"url"] copy];
            }
        }
    }
    return self;
}


- (void)dealloc {
    [_articleLink release];
    [_description release];
    [_headlineText release];
    [_imageUrl release];
    [super dealloc];
}


@end