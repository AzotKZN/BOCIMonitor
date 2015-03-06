//
//  ViewController.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 02.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "ViewController.h"
#import "CIMonitorManager.h"
#import "dataCIMonitor.h"
#import "CiDataTableViewCell.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableDictionary* branchCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray array];
    self.branchCount = [[NSMutableDictionary alloc]initWithCapacity:10];
    [self getCIDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - API
- (void) getCIDataFromServer {
    [[CIMonitorManager sharedManager] getResponseCIMonitoronSuccess:^(NSArray *platformData, NSMutableDictionary *platformsBranchCount) {
        [self.dataArray addObjectsFromArray:platformData];
        [self.branchCount setDictionary:platformsBranchCount];
        
        NSLog(@"Done platformData %@", platformData);
        NSLog(@"Done platformsBranchCount %@", platformsBranchCount);

        [self.tableView reloadData];
        
        } onFailure:^(NSError *error, NSInteger statusCode) {
            NSLog(@"Fail");
        }];
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"TEST";
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
    if([self.dataArray count] > 0 && [self.dataArray count] > indexPath.row){
    dataCIMonitor* object = [self.dataArray objectAtIndex:indexPath.row];
    cell.buildNumber.text = object.build;
    }
    return cell;
       
}


@end
