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
    //    self.timeStamp = [responseObject objectForKey:@"bTS"];
        NSString* urlString = [responseObject objectForKey:@"iconUser"];
        if (urlString) {
            self.iconUser = [NSURL URLWithString:urlString];
        }
        self.branchType = [responseObject objectForKey:@"bBranchType"];
        self.buildStatus = [responseObject objectForKey:@"jStatus"];
        NSString* commiter = [responseObject objectForKey:@"bCommiter"];
        if (commiter) {
        [[NSScanner scannerWithString:commiter] scanUpToString:@" <" intoString:&commiter];
        self.commiter = commiter;
        }
        
        NSString * timeStampString = [responseObject objectForKey:@"bTS"];
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"dd.MM.yy hh:mm"];
        self.timeStamp = [_formatter stringFromDate:date];
    }
    
    return self;
}

@end
