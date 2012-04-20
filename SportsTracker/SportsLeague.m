//
//  Created by ncipollina on 4/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SportsLeague.h"


@implementation SportsLeague {

}
@synthesize leagueName = _leagueName;
@synthesize leagueAbbreviation = _leagueAbbreviation;

- (id)initWithDictionary:(NSDictionary *)theData {
    if (self = [super init]){
        _leagueAbbreviation = [[theData objectForKey:@"abbreviation"] copy];
        _leagueName = [[theData objectForKey:@"name"] copy];
    }
    return self;
}

- (void)dealloc {
    [_leagueName release];
    [_leagueAbbreviation release];
    [super dealloc];
}


@end