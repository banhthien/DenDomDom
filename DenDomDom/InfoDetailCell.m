//
//  InfoDetailCell.m
//  DenDomDom
//
//  Created by Thien Banh on 11/29/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "InfoDetailCell.h"

@interface InfoDetailCell()
{
    
    __weak IBOutlet UILabel *oNameLabel;
    __weak IBOutlet UILabel *oInfoLabel;
}
@end

@implementation InfoDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setUpCellWithName:(NSString*)sName withInfo:(NSString*)sInfo
{
    oNameLabel.text = sName;
    oInfoLabel.text = sInfo;
}

@end
