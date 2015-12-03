//
//  LeftSlideCell.m
//  DenDomDom
//
//  Created by Thien Banh on 10/28/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "LeftSlideCell.h"

@interface LeftSlideCell()
{
    __weak IBOutlet UIImageView *oImageCell;
    __weak IBOutlet UILabel *oScholarshipLabel;
}
@end

@implementation LeftSlideCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWith:(NSString*)sURL name:(NSString*)sName
{
    [oImageCell setImage:[UIImage imageNamed:sURL]];
    oScholarshipLabel.text = sName;
}
@end
