//
//  AlbumInfoViewController.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "AlbumInfoViewController.h"
#import "UIView+Location.h"
#import "FDSlideBar.h"
#import "TrackListTableViewController.h"


@interface AlbumInfoViewController ()

@property (nonatomic, strong) FDSlideBar* slideBar;
@end

static const CGFloat kImageWidth = 120.0;
@implementation AlbumInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setUpSlideBar];
    [self setUpViews];
}



// Set up a slideBar and add it into view
- (void)setUpSlideBar {
    self.navigationController.navigationBar.hidden = YES;
   // FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    FDSlideBar *sliderBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width , 46)];
   
    sliderBar.itemWidth = self.view.width / 2;
    sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    
    sliderBar.itemsTitle = @[@"详情", @"曲目"];
    
    // Set some style to the slideBar
    sliderBar.itemColor = [UIColor blackColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    // Add the callback with the action that any item be selected
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
     //   [self.scrollView scrollRectToVisible:
      //   CGRectMake(self.view.width * idx, 0, self.scrollView.width, self.scrollView.height)
      //  animated:YES ];
    }];
    [self.view addSubview:sliderBar];
    self.slideBar = sliderBar;
}


- (void)setUpViews {

    self.view.backgroundColor = [UIColor whiteColor];
   
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
   
    CGFloat width = self.view.width;
    CGFloat y = self.navigationController.navigationBar.height + rectStatus.size.height + 20;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - kImageWidth) / 2, y, kImageWidth, kImageWidth )];
    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:self.album.imgUrl]]];
  
    imageView.image = image;
    [self.view addSubview: imageView];
   
   
//tableview
    CGFloat top = imageView.bottom + 80;
    
 
    CGRect rect = CGRectMake(0, top, self.view.width,  self.view.height - top);
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"AlbumList" bundle: nil];
    TrackListTableViewController* trackListVC = [storyboard instantiateViewControllerWithIdentifier: @"TrackListTableViewVC"];
    [self addChildViewController: trackListVC];
    
    trackListVC.tracks = self.album.tracks;
    trackListVC.tableView.frame = rect;
    
    [self.view addSubview: trackListVC.tableView];
    
    
    //UILabel* authorNameLabel = [[UILabel alloc] init];
    //authorNameLabel.text = self.album.
}
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
