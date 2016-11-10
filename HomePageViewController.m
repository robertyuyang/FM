//
//  HomePageViewController.m
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "HomePageViewController.h"

#import "UIView+Location.h"

#import "FDSlideBar.h"
#import "AudioBookViewController.h"
#import "TalkShowViewController.h"

#import "ContentService.h"




@interface HomePageViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) FDSlideBar *slideBar;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSArray* childVCArray;
//@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ContentService sharedObject] loadData];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self setUpSlideBar];
    [self setUpScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private


- (void)setUpScrollView {
    AudioBookViewController* audioBookVC = [[AudioBookViewController alloc] init];
    TalkShowViewController* talkShowVC = [[TalkShowViewController alloc] init];
    [self addChildViewController:audioBookVC];
    [self addChildViewController:talkShowVC];
   
   
    
    self.childVCArray = [NSArray arrayWithObjects: audioBookVC, talkShowVC, nil];
   
    CGFloat x = 0;
    CGFloat y = self.slideBar.bottom;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - y;
    self.scrollView = [[UIScrollView alloc] initWithFrame:
                       CGRectMake(x, y, width, height)];
   
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake([self.childVCArray count] * width, height);
    
    [self.scrollView addSubview: audioBookVC.view];
    [self.scrollView addSubview: talkShowVC.view];
    
    int index = 0;
    for(UIViewController* vc in self.childVCArray){
        vc.view.frame = CGRectMake(index * width, 0, width, height);
        index++;
    }
    
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
}


// Set up a slideBar and add it into view
- (void)setUpSlideBar {
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
   
    sliderBar.itemWidth = self.view.width / 2;
    sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    
    // Init the titles of all the item
    sliderBar.itemsTitle = @[@"有声小说", @"相声评书"];
    
    // Set some style to the slideBar
    sliderBar.itemColor = [UIColor whiteColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    // Add the callback with the action that any item be selected
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [self.scrollView scrollRectToVisible:
         CGRectMake(self.view.width * idx, 0, self.scrollView.width, self.scrollView.height)
        animated:YES ];
    }];
    [self.view addSubview:sliderBar];
    _slideBar = sliderBar;
}

    
   
#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger idx = self.scrollView.contentOffset.x / scrollView.width;
    //NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    
    // Select the relating item when scroll the tableView by paging.
    [self.slideBar selectSlideBarItemAtIndex:idx];
}

@end
