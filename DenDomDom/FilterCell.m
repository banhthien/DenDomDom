//
//  TableViewCell.m
//  DenDomDom
//
//  Created by Thien Banh on 10/29/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()
{
    
    __weak IBOutlet UILabel *oNameLabel;
    __weak IBOutlet UILabel *oStatusLabel;
}

@end

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWith:(NSString*)sName withStatus:(NSString*)sStatus
{
    oNameLabel.text = sName;
    if (sStatus.length > 0) {
        oStatusLabel.text = sStatus;
    }
    else
    {
        oStatusLabel.text = @"Tất cả";
    }
}

@end
