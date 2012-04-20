//
//  Created by ncipollina on 4/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol APIManagerDelegate

- (void)requestDataReady:(NSDictionary *)dataItems;
- (NSURL *)setMyUrl;

@end

@interface APIManager : NSObject{
    dispatch_queue_t backgroundQueue;
@private
    SBJsonParser *_parser;
}

@property (assign) id<APIManagerDelegate> delegate;

- (id)initWithDelegate:(id <APIManagerDelegate>)theDelegate;

- (void)process:(NSURL *)theUrl;

@end