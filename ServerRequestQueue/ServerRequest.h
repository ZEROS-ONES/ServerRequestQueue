//
//  ServerRequest.h
//  Queue
//
//  Created by Sandeep Kumar penchala on 7/31/16.
//  Copyright © 2016 Sandeep Kumar penchala All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerRequest : NSObject <NSCoding>

@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSDictionary *postData;

@end
