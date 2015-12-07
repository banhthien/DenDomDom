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

    __weak IBOutlet UILabel *oNameLabel;
    __weak IBOutlet UIImageView *oImageView;
    __weak IBOutlet UILabel *oSchoolLabel;
    
    __weak IBOutlet UILabel *oDayLabel;
    __weak IBOutlet UILabel *oMouthLabel;
    __weak IBOutlet UILabel *oYearLabel;
    __weak IBOutlet UILabel *oMinValueLabel;
    __weak IBOutlet UILabel *oMaxValueLabel;
    __weak IBOutlet UIView *oTimeView;
    __weak IBOutlet UIButton *oShareButton;
    // PROPERTY
    NSInteger mIndex;
}
- (IBAction)actionSharePress:(id)sender;
@end

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
    mIndex = 0;
    oShareButton.layer.borderColor = [RGB(217, 133, 59) CGColor];
    oShareButton.layer.borderWidth = 1;
    oShareButton.layer.cornerRadius = 3;
    oTimeView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWithScholarship:(id)sScholarship
{
    Scholarship *tScholar = sScholarship;
    oNameLabel.text = tScholar.mName;
    oMinValueLabel.text = [NSString stringWithFormat:@"Số tiền nhỏ nhất %ld",(long)tScholar.mMinValue];
    oMaxValueLabel.text = [NSString stringWithFormat:@"Số tiền lớn nhất %ld",(long)tScholar.mMaxValue];
    
    NSDate  *tDayEnd      = [NSDate dateWithTimeIntervalSince1970:tScholar.mDateEndRegister/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:tDayEnd];
    oYearLabel.text =[NSString stringWithFormat:@"%ld", (long)components.year];
    oMouthLabel.text =[NSString stringWithFormat:@"%ld", (long)components.month];
    oDayLabel.text =[NSString stringWithFormat:@"%ld", (long)components.day];
}

- (IBAction)actionSharePress:(id)sender
{
    [self.mDelegate homeCell_SharePressWithIndex:mIndex];
}
@end
