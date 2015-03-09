//
//  dataCIMonitor.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 03.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "DataCIMonitor.h"


@implementation DataCIMonitor

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];

    if (self) {
        self.build = [responseObject objectForKey:@"aBuild"];
        self.timeStamp = [responseObject objectForKey:@"bTS"];
        NSString* urlString = [responseObject objectForKey:@"iconUser"];
        if (urlString) {
            self.iconUser = [NSURL URLWithString:urlString];
        }
        self.branchType = [responseObject objectForKey:@"bBranchType"];
        self.buildStatus = [responseObject objectForKey:@"jStatus"];
    }
    
    return self;
}

@end
