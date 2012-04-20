//
//  Created by ncipollina on 4/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "APIManager.h"
#import "ASIHTTPRequest.h"


@implementation APIManager {
    __block ASIHTTPRequest *request;
}
@synthesize delegate = _delegate;


- (id)initWithDelegate:(id <APIManagerDelegate>)theDelegate {
    if (self = [super init]){
        _delegate = theDelegate;
    }

    backgroundQueue = dispatch_queue_create("com.captech.sportstracker.bgqueue", NULL);
    return self;
}

- (void)processData:(NSData *)data {

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];


    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.delegate requestDataReady:json];
    });
}

- (void)retrieveData:(NSURL *)theUrl attempts:(NSInteger)numberOfAttempts {
    NSLog(@"Retrieving Data attempt %d...", numberOfAttempts);

    ASIBasicBlock errorBlock = ^{
        NSError *error = [request error];
        NSLog(@"Data failed to retrieve: %@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.delegate requestDataReady:nil];
        });
    };

    request = [ASIHTTPRequest requestWithURL:theUrl];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setCompletionBlock:^{
        NSLog(@"Data retrieved");
        NSData *data = [request responseData];

        NSInteger code = [request responseStatusCode];
        if (code != 200)
        {
            if (numberOfAttempts < 3)
            {
                sleep(1);
                [self retrieveData:theUrl attempts:numberOfAttempts+1];
            }
            else
            {
                errorBlock();
            }
        }
        else
            dispatch_async(backgroundQueue, ^(void){
                [self processData:data];
            });
    }];
    [request setFailedBlock:errorBlock];
    [request startSynchronous];
}

- (void)process:(NSURL *)theUrl {
    dispatch_async(backgroundQueue, ^(void){
        [self retrieveData:theUrl attempts:0];
    });
}

- (void)dealloc {
    [_parser release];
    _parser = nil;
    [super dealloc];
}


@end