//
//  ServerRequestsQueue.h
//  Queue
//
//  Created by Sandeep Kumar penchala on 7/31/16.
//  Copyright © 2016 Sandeep Kumar penchala All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequest.h"

@interface ServerRequestsQueue : NSObject
+ (id)sharedQueue;
- (void)enqueue:(ServerRequest *)request;
- (ServerRequest *)dequeue;
- (ServerRequest *)peek;
- (ServerRequest *)peekAt:(NSInteger) position;
- (void) insertAt:(NSInteger) position with:(ServerRequest *) request;
- (void) removeAt:(NSInteger) position;
- (NSInteger) getSize;
@end
