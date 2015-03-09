//
//  dataCIMonitor.h
//  BackOfficeCIMonitor
//
//  Created by Азат on 03.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerObject.h"

@interface DataCIMonitor : ServerObject

@property (strong, nonatomic) NSString* build;
@property (strong, nonatomic) NSString* timeStamp;
@property (strong, nonatomic) NSURL* iconUser;
@property (strong, nonatomic) NSString* branchType;
@property (strong, nonatomic) NSString* buildStatus;


@end
