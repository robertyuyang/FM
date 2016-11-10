//
//  TrackListTableViewCell.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "TrackListTableViewCell.h"

@implementation TrackListTableViewCell

-(void)setTitleLabel:(UILabel *)titleLabel {
    _titleLabel = titleLabel;
    [_titleLabel sizeToFit];
}

-(void)setDurationLabel:(UILabel *)durationLabel {
    _durationLabel = durationLabel;
    [_durationLabel sizeToFit];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
