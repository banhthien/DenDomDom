//
//  TFNoDataTableViewCell.m
//  ShopOnline
//
//  Created by Long Dang on 10/8/15.
//  Copyright © 2015 tflat. All rights reserved.
//

#import "TFNoDataTableViewCell.h"

@implementation TFNoDataTableViewCell
{
    __weak IBOutlet UILabel *oTitleLabel;
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

- (void)setUpCellWithText:(NSString *)sText
{
    oTitleLabel.text = sText;
}

@end
