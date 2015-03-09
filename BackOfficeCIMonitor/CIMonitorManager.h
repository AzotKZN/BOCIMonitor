//
//  CIMonitorManager.h
//  BackOfficeCIMonitor
//
//  Created by Азат on 03.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataCIMonitor;

@interface CIMonitorManager : NSObject

+ (CIMonitorManager*) sharedManager;

-(void) getResponseCIMonitoronSuccess:(void(^)(NSDictionary* platformData)) success
                            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end
