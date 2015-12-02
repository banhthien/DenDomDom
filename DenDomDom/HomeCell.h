//
//  HomeCell.h
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCellDelegate <NSObject>

- (void)homeCell_SharePressWithIndex:(NSInteger)sIndex;

@end

@interface HomeCell : UITableViewCell

@property (nonatomic, weak) id<HomeCellDelegate>mDelegate;

- (void)setUpCellWithScholarship:(id)sScholarship;
@end
