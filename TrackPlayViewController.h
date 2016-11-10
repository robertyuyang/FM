//
//  TrackPlayViewController.h
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"

@interface TrackPlayViewController : UIViewController

@property (nonatomic, strong) Track* track;

-(void) play;
-(void) pause;
-(void) stop;
-(void) next;

+(TrackPlayViewController*) sharedInstance;
@end
