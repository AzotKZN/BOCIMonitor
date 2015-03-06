//
//  CiDataTableViewCell.h
//  BackOfficeCIMonitor
//
//  Created by Азат on 05.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CiDataTableViewCell : UITableViewCell {
    UILabel *buildNumber;

}
@property (nonatomic, retain) IBOutlet UILabel *buildNumber;

@end
