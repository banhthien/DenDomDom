//
//  CommentCell.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()
{
    
    __weak IBOutlet UIImageView *oAvatarImage;
    __weak IBOutlet UILabel *oUserNameLabel;
    __weak IBOutlet UILabel *oCommentLabel;
    __weak IBOutlet UILabel *oTimeLabel;
}
@end

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    oAvatarImage.clipsToBounds = YES;
    oAvatarImage.layer.cornerRadius = oAvatarImage.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
