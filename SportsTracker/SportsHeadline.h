//
//  Created by ncipollina on 4/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SportsHeadline : NSObject

@property (retain) NSString *headlineText;
@property (retain) NSString *description;
@property (retain) NSString *articleLink;
@property (retain) NSString *imageUrl;

- (id)initWithDictionary:(NSDictionary *)theData;

@end