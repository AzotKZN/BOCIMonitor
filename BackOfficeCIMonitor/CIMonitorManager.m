//
//  CIMonitorManager.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 03.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "CIMonitorManager.h"
#import "AFNetworking.h"

#import "DataCIMonitor.h"

@interface CIMonitorManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@end


@implementation CIMonitorManager

+ (CIMonitorManager*) sharedManager {
    
    static CIMonitorManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CIMonitorManager alloc] init];
    });
    
    return manager;
}


-(id)init
{
    self = [super init];
    if (self) {
        NSURL* url = [NSURL URLWithString:@"http://ci-monitor.soft-artel.com"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        
        
    }
    return self;
}

- (void)getResponseCIMonitoronSuccess:(void(^)(NSDictionary* platformData)) success
                            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure
{
    
    [self.requestOperationManager
     GET:@"/getLastBuild.php?type=all"
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *responseDict = responseObject;
         NSArray *platforms = ((NSDictionary *)responseDict[@"data"]).allKeys;
         NSMutableDictionary *objectsArray = [NSMutableDictionary new];
         
         for (NSString *platform in platforms)
         {
             NSMutableArray *platformObject = [NSMutableArray new];
             NSArray *platformData = responseDict[@"data"][platform][@"column"];
             
             for (NSArray *arrDataCIMonitor in platformData)
             {
                 for (NSDictionary *dictDataCIMonitor in arrDataCIMonitor)
                 {
                     DataCIMonitor* data = [[DataCIMonitor alloc] initWithServerResponse:dictDataCIMonitor];
                     [platformObject addObject:data];
                 }
             }
             
             [objectsArray setObject:platformObject forKey:platform];
         }
         
         if (success)
         {
             success(objectsArray);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}


@end
