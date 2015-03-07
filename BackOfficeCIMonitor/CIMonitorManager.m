//
//  CIMonitorManager.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 03.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "CIMonitorManager.h"
#import "AFNetworking.h"

#import "dataCIMonitor.h"

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

-(void) getResponseCIMonitoronSuccess:(void(^)(NSArray* platformData, NSMutableDictionary* platformsBranchCount)) success
                            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure
                    {
    NSArray* platforms = [NSArray arrayWithObjects:@"android", @"ios", @"web", @"chrome", nil]; // перечисление платформ
                        
    [self.requestOperationManager
     GET:@"/getLastBuild.php?type=all"
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         NSMutableArray* objectsArray2 = [NSMutableArray array];



        // NSMutableArray* platformsBranchCount = [NSMutableArray array];

         NSMutableDictionary *platformsBranchCount = [[NSMutableDictionary alloc]initWithCapacity:10];
         int* count = 0;
         for (int j = 0; j <= 3; j++) {
             count = 0;
             NSArray* dictsArray = [[[responseObject objectForKey:@"data"] objectForKey:platforms[j]] objectForKey:@"column"]; // подставляем название платформы
             for (int i = 0; i <= 3; i++){
                 //dataCIMonitor* data;
                 for (NSDictionary* dict in dictsArray[i]) {
                     dataCIMonitor* data = [[dataCIMonitor alloc] initWithServerResponse:dict];
                     count += 1;
                     [objectsArray addObject:data];
                     [platformsBranchCount setObject:data forKey:platforms[j]];
                 }
                 NSLog(@"objectsArray = %@", objectsArray);
                 [objectsArray2 addObject:objectsArray.copy];
                // [objectsArray2 addObject:objectsArray];
                 NSLog(@"objectsArray2 = %@", objectsArray2);
                 [objectsArray removeAllObjects];

             } //В цикле проходимся по непустым данным, передаем их на обработку
             
             [platformsBranchCount setObject:[NSNumber numberWithInt:count] forKey:platforms[j]];
         }
        
         if (success) {
             NSLog(@"objectsArray2.count = %lu", (unsigned long)objectsArray2.count);
             
             success(objectsArray2, platformsBranchCount);
             
             
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}


@end
