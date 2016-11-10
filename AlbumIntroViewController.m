//
//  AlbumIntroViewController.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "AlbumIntroViewController.h"
#import "UIView+Location.h"
@interface AlbumIntroViewController ()

@end

@implementation AlbumIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpViews{
    UILabel* introLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 5, self.view.width - 20 * 2, 50)];
    introLabel.text = self.album.intro;

    [introLabel sizeToFit];
    [self.view addSubview: introLabel];
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
