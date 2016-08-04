//
//  ServerRequestsQueue.m
//  Queue
//
//  Created by Sandeep Kumar penchala on 7/31/16.
//  Copyright © 2016 Sandeep Kumar penchala All rights reserved.
//

#import "ServerRequestsQueue.h"
#import "ServerRequest.h"

#define kDataKey        @"Data"
#define kDataFile       @"ServiceRequestsQueue.plist"

@interface ServerRequestsQueue ()
@property (strong) NSMutableArray *data;
@end

@implementation ServerRequestsQueue

+ (id)sharedQueue {
    static ServerRequestsQueue *sharedQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQueue = [[self alloc] init];
    });
    return sharedQueue;
}

- (id)init {
    if (self = [super init]) {
        self.data = [[NSMutableArray alloc] init];
        [self recoverQueue];
    }
    return self;
}

#pragma mark Queue operations
-(void)enqueue:(ServerRequest *)request {
    [self.data addObject:request];
    [self saveQueue];
}

-(ServerRequest *)dequeue {
    ServerRequest *headObject = [self.data objectAtIndex:0];
    if (headObject != nil) {
        [self.data removeObjectAtIndex:0];
        [self saveQueue];
    }
    return headObject;
}

-(ServerRequest *)peek {
    ServerRequest *headObject = [self.data objectAtIndex:0];
    return headObject;
}

- (ServerRequest *)peekAt:(NSInteger) position {
    if(position>=self.data.count){
        return nil;
    }
    ServerRequest *headObject = [self.data objectAtIndex:position];
    return headObject;
}

- (void) insertAt:(NSInteger) position with:(ServerRequest *) request{
    [self.data insertObject:request atIndex:position];
    [self saveQueue];
}

- (void) removeAt:(NSInteger) position {
    if (position < self.data.count) {
        [self.data removeObjectAtIndex:position];
        [self saveQueue];
    }
}

- (NSInteger) getSize {
    return self.data.count;
}

#pragma mark Persist Queue
- (void) saveQueue {
    [self deleteDoc];
    NSString *docPath = [self getFilePathToSaveData];
    NSString *dataPath = [docPath stringByAppendingPathComponent:kDataFile];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.data];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:arrayData forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}

- (void) recoverQueue {
    
    NSString *docPath = [self getFilePathToSaveData];
    NSString *dataPath = [docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData == nil) return;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    NSData *arrayData = [unarchiver decodeObjectForKey:kDataKey];
    NSMutableArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    self.data = array;
    [unarchiver finishDecoding];

}


#pragma mark Helper methods 
- (NSString *)getFilePathToSaveData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    return documentsDirectory;
    
}

- (BOOL)deleteDoc {
    
    NSError *error;
    NSString *docPath = [self getFilePathToSaveData];
    NSString *dataPath = [docPath stringByAppendingPathComponent:kDataFile];
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];
    return success;
}


@end
