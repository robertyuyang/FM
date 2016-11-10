//
//  AlbumTableViewCell.m
//  MyFM
//
//  Created by mac on 10/31/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "AlbumTableViewCell.h"

@implementation AlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setCellImage: (UIImage*) image {
    self.image.image = image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
