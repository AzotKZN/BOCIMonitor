//
//  ViewController.h
//  BackOfficeCIMonitor
//
//  Created by Азат on 02.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSTimer *refreshTimer;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSTimer *refreshTimer;
@end

