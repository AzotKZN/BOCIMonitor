//
//  ViewController.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 02.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "ViewController.h"
#import "CIMonitorManager.h"
#import "DataCIMonitor.h"
#import "CiDataTableViewCell.h"

@interface ViewController ()

@property (nonatomic) NSArray *sectionNames;
@property (nonatomic) NSDictionary* dataDict;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getCIDataFromServer];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:60.0f
                                                         target:self
                                                       selector:@selector(getCIDataFromServer)
                                                       userInfo:nil
                                                        repeats:YES];
}

#pragma mark - API

- (void) getCIDataFromServer
{
    [[CIMonitorManager sharedManager] getResponseCIMonitoronSuccess:^(NSDictionary *platformData)
     {
         self.sectionNames = platformData.allKeys;
         self.dataDict = platformData;
         
         [self.tableView reloadData];
         
     } onFailure:^(NSError *error, NSInteger statusCode)
     {
         NSLog(@"Fail %@ ", error);
     }];
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSDictionary *)self.dataDict[self.sectionNames[section]]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionNames[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    //поиск ячейки
    CiDataTableViewCell *cell = (CiDataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //если ячейка не найдена - создаем новую
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CIDataTableViewCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *sectionName = self.sectionNames[indexPath.section];
    
    
    DataCIMonitor* object = self.dataDict[sectionName][indexPath.row];
    cell.buildNumber.text = object.build;
    cell.bCommiter.text = object.commiter;
    cell.bBranchType.text = object.branchType;
    cell.jStatus.text = object.buildStatus;
    if ([object.buildStatus  isEqual: @"SUCCESS"]) {
        cell.backgroundColor = [UIColor greenColor];
    } else if ([object.buildStatus  isEqual: @"FAILURE"])
    {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    cell.bTS.text = object.timeStamp;
    return cell;
}

@end
