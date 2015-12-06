//
//  FilterDetailCell.h
//  DenDomDom
//
//  Created by Thien Banh on 11/1/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterDetailCellDelegate <NSObject>

- (void)filterDetailCell_SwitchPressAtIndex:(NSInteger)sIndex withValue:(BOOL)sSwitch;

@end

@interface FilterDetailCell : UITableViewCell

@property (nonatomic, weak) id<FilterDetailCellDelegate>mDelegate;

- (void)setUpWithSwitchPress:(NSInteger)sIndex withName:(NSString*)sName;
- (void)setSwitch:(BOOL)isOn;
@end
