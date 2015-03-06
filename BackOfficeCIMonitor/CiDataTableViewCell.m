//
//  CiDataTableViewCell.m
//  BackOfficeCIMonitor
//
//  Created by Азат on 05.03.15.
//  Copyright (c) 2015 Azat Minvaliev. All rights reserved.
//

#import "CiDataTableViewCell.h"

@implementation CiDataTableViewCell
@synthesize buildNumber;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      //  [buildNumber release];
        }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
