//
//  AlbumTableViewCell.h
//  MyFM
//
//  Created by mac on 10/31/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (weak, nonatomic) IBOutlet UILabel *tracks;


-(void) setCellImage: (UIImage*) image;
@end
