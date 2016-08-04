//
//  ServerRequest.m
//  Queue
//
//  Created by Sandeep Kumar penchala on 7/31/16.
//  Copyright © 2016 Sandeep Kumar penchala All rights reserved.
//

#import "ServerRequest.h"
#define kTagKey       @"Tag"
#define kPostDataKey      @"PostData"

@implementation ServerRequest
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_tag forKey:kTagKey];
    [encoder encodeObject:_postData forKey:kPostDataKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    _tag = [decoder decodeObjectForKey:kTagKey];
    _postData = [decoder decodeObjectForKey:kPostDataKey];
    return self;
}

@end
