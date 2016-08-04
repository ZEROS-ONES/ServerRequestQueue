//
//  ViewController.m
//  ServerRequestQueue
//
//  Created by Sandeep Kumar penchala on 7/31/16.
//  Copyright © 2016 Sandeep Kumar penchala. All rights reserved.
//

#import "ViewController.h"
#import "ServerRequestsQueue.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ServerRequestsQueue *queue = [ServerRequestsQueue sharedQueue];
    ServerRequest *req1 = [[ServerRequest alloc] init];
    [queue enqueue:req1];
    ServerRequest *req2 = [[ServerRequest alloc] init];
    [queue enqueue:req2];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
