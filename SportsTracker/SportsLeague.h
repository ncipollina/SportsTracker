//
//  Created by ncipollina on 4/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SportsLeague : NSObject

@property (retain) NSString *leagueName;
@property (retain) NSString *leagueAbbreviation;

- (id)initWithDictionary:(NSDictionary *)theData;
@end