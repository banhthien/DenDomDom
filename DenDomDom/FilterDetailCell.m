//
//  FilterDetailCell.m
//  DenDomDom
//
//  Created by Thien Banh on 11/1/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FilterDetailCell.h"


@interface FilterDetailCell()
{
    
    //OUTLET
    __weak IBOutlet UILabel *oPropertyName;
    __weak IBOutlet UISwitch *oSwitch;
    
    //PROPERTY
    NSInteger mIndex;
}
- (IBAction)actionSwitch:(id)sender;
@end

@implementation FilterDetailCell

- (void)awakeFromNib {
    // Initialization code
    [oSwitch setOn:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpWithSwitchPress:(NSInteger)sIndex withName:(NSString*)sName isSwithOn:(BOOL)sIsOn
{
    [oSwitch setOn:sIsOn];
    oPropertyName.text = sName;
    mIndex = sIndex;
}

- (IBAction)actionSwitch:(id)sender {
    [self.mDelegate filterDetailCell_SwitchPressAtIndex:mIndex withValue:oSwitch.isOn];
}
@end
