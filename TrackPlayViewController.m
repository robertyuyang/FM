//
//  TrackPlayViewController.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "TrackPlayViewController.h"
#import <UIKit/UIkit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DOUAudioStreamer.h"
#import "audioFileURL.h"

@interface TrackPlayViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *Progress;

@property (nonatomic, strong) DOUAudioStreamer* player;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) NSMutableDictionary* nowPlayingInfo;
@end

@implementation TrackPlayViewController



+(TrackPlayViewController*) sharedInstance {
    static TrackPlayViewController* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"AlbumList" bundle:nil];
        TrackPlayViewController* trackPlayVC = [storyboard instantiateViewControllerWithIdentifier:@"PlayerVC"];
        instance = trackPlayVC;
    });
    return instance;
}


-(void)setNowPlayingInfo:(NSMutableDictionary *)nowPlayingInfo {
    _nowPlayingInfo = nowPlayingInfo;
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:self.track.imgUrl]]];
    
    [self playAudio];
    // Do any additional setup after loading the view.
}

-(void) play {
    
    [self.player play];
    NSMutableDictionary* nowPlayingInfo = self.nowPlayingInfo;
    
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = @(1);
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(self.player.currentTime);
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    self.nowPlayingInfo = nowPlayingInfo;
 
    
}
-(void) pause {
     [self.player pause];
    
    NSMutableDictionary* nowPlayingInfo = self.nowPlayingInfo;
    
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = @(0);
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(self.player.currentTime);
    self.nowPlayingInfo = nowPlayingInfo;
}
-(void) stop {
    
}
-(void) next {
    
}

- (IBAction)onPlayClick:(UIButton *)sender {
    [self play];
}
- (IBAction)onPauseClick:(UIButton *)sender {
    [self pause];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if([keyPath isEqualToString: @"duration"]) {
        [self updateCurrentTime: self.player.currentTime andDuration:self.player.duration];
    }
}


-(void)updateProgressBar: (NSTimeInterval) currentTime
             andDuration:(NSTimeInterval) duration {
    self.Progress.maximumValue = 1;
    self.Progress.minimumValue = 0;
    self.Progress.value = currentTime / duration;
}


-(void)updateCurrentTime: (NSTimeInterval) currentTime
             andDuration:(NSTimeInterval) duration {
  
    [self updateProgressBar: currentTime andDuration:duration];
    
    NSMutableDictionary* nowPlayingInfo = self.nowPlayingInfo;
    //nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackProgress] = @(currentTime / duration);
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = @(duration);
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(currentTime);
    self.nowPlayingInfo = nowPlayingInfo;
    
    NSLog(@"%lf/%lf", currentTime, duration);
}

- (void) playAudio {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    audioFileURL* audioFile = [[audioFileURL alloc] initWithUrl: self.track.url];
    self.player = [DOUAudioStreamer streamerWithAudioFile: audioFile];
    
    [self.player play];
  
    [self.player addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:nil];
   
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer *timer) {
        [self updateProgressBar:self.player.currentTime andDuration:self.player.duration];
        }
     ];
 
    
    self.nowPlayingInfo =
     [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            self.track.title,MPMediaItemPropertyTitle,
                           self.track.author.name,MPMediaItemPropertyArtist,
                           @(1),MPNowPlayingInfoPropertyPlaybackRate,
                           [[MPMediaItemArtwork alloc]initWithImage:self.imageView.image],
                           MPMediaItemPropertyArtwork,
      nil];
    
    
};


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
