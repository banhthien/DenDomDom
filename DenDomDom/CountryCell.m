//
//  CountryCell.m
//  DenDomDom
//
//  Created by Thien Banh on 1/3/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell
{
    
    __weak IBOutlet UILabel *oCountryLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWithName:(NSString*)sName
{
    oCountryLabel.text = sName;
}
@end
