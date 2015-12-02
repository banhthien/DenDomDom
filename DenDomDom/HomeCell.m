//
//  HomeCell.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "HomeCell.h"
#import "Scholarship.h"

@interface HomeCell()
{
    // OUTLET
    __weak IBOutlet UIImageView *oLogoImage;
    __weak IBOutlet UILabel *oNameLabel;
    __weak IBOutlet UIImageView *oImageView;
    __weak IBOutlet UILabel *oInfoLabel;
    
    // PROPERTY
    NSInteger mIndex;
}
- (IBAction)actionSharePress:(id)sender;
@end

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
    mIndex = 0;
    oLogoImage.clipsToBounds = YES;
    oLogoImage.layer.cornerRadius = oLogoImage.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWithScholarship:(id)sScholarship
{
    Scholarship *tScholar = sScholarship;
    oNameLabel.text = tScholar.mName;
    oInfoLabel.text = tScholar.mDescription;
}

- (IBAction)actionSharePress:(id)sender
{
    [self.mDelegate homeCell_SharePressWithIndex:mIndex];
}
@end
