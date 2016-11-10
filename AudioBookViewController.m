//
//  AudioBookViewController.m
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "AudioBookViewController.h"
#import "UIView+Location.h"
#import "SGFocusImageFrame.h"
#import "AlbumListTableViewController.h"
#import "AlbumTableViewCell.h"

#import <MediaPlayer/MediaPlayer.h>

#import "AlbumInfoNavViewController.h"
#import "AlbumInfoViewController.h"
#import "ContentService.h"
#import "Album.h"

static const CGFloat kBannerHeight = 230.0;
static const NSString* kTag = @"有声小说";

@interface AudioBookViewController ()


@property (nonatomic, strong) AlbumListTableViewController* albumListVC;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray* albums;


@end

@implementation AudioBookViewController




- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self loadAlbums];
    [self setUpTableView];
    [self setUpBanner];
    
   
    //[self downloadImageFor:nil WithUrl:nil];
}

- (void)setUpBanner {
   
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSArray *imagesURLStrings = @[
                                  @"http://fdfs.xmcdn.com/group25/M06/13/F6/wKgJMVgYBXTC3R21AAH_2JCgK8M509.jpg",
                                  @"http://fdfs.xmcdn.com/group22/M07/14/1D/wKgJLlgYBg_RbllUAAJOFZddpuQ717.jpg",
                                  @"http://fdfs.xmcdn.com/group22/M0A/14/1E/wKgJLlgYBjuhRD6PAAH9tJILALI116.jpg"
                                  ];
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] initWithCapacity:[imagesURLStrings count]];
    for(NSString* url in imagesURLStrings){
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:url]]];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"title1"
                                                                   image:image
                                                                     tag:0];
        [itemArray addObject:item];
    }
    SGFocusImageFrame *bottomImageFrame =
    [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kBannerHeight)
                                    delegate:self
                             focusImageItemsArrray: [itemArray copy]];
/*
    SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:@"title1" image:[UIImage imageNamed:@"banner1"] tag:0];
    SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithTitle:@"title2" image:[UIImage imageNamed:@"banner2"] tag:1];
    SGFocusImageItem *item3 = [[SGFocusImageItem alloc] initWithTitle:@"title3" image:[UIImage imageNamed:@"banner3"] tag:2];
    SGFocusImageItem *item4 = [[SGFocusImageItem alloc] initWithTitle:@"title4" image:[UIImage imageNamed:@"banner4"] tag:4];
    
    SGFocusImageFrame *bottomImageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kBannerHeight) delegate:self focusImageItems:item1, item2, item3, item4, nil];
 
*/
    bottomImageFrame.autoScrolling = YES;
    [self.view addSubview:bottomImageFrame];
    return;
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:demoContainerView];
    
}


- (void)loadAlbums {
    self.albums = [[ContentService sharedObject] getAlbumsByTag: kTag];
    
}

- (void)setUpTableView {
    
    CGRect rect = CGRectMake(0, kBannerHeight, self.view.width, self.view.height);
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"AlbumList" bundle:nil];
    if(storyboard == nil) {
        return;
    }
    //self.albumListVC = [storyboard instantiateInitialViewController];
    self.albumListVC = [storyboard instantiateViewControllerWithIdentifier: @"AlbumListTableViewVC"];
   
    if(self.albumListVC == nil) {
        return;
    }
    
    [self addChildViewController:self.albumListVC];
    
    self.albumListVC.tableView.frame = rect;
    [self.view addSubview: self.albumListVC.tableView];
    
   
    self.albumListVC.tableView.delegate = self;
    self.albumListVC.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumInfoViewController* albumInfoVC = [[AlbumInfoViewController alloc] init];
    albumInfoVC.album = self.albums[indexPath.row];
    albumInfoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    albumInfoVC.title = albumInfoVC.album.title;
    
    AlbumInfoNavViewController* navVC = [[AlbumInfoNavViewController alloc] initWithRootViewController:albumInfoVC];

    [self presentViewController:navVC animated:NO completion:nil];
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (void) downloadImageFor: (UIImageView*) imageView WithUrl: (NSString*) url {
    NSURL* imgUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imgUrl cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:3.0];
    //NSURLRequest* request = [NSURLRequest requestWithURL:imgUrl];
    NSURLSessionConfiguration* sessionConf = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession* sessoin = [NSURLSession sessionWithConfiguration:sessionConf];
    NSURLSessionDataTask* task = [sessoin downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error) {
            UIImage* image = [UIImage imageWithData: [NSData dataWithContentsOfURL: location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        }
    }];
    
    /*
    NSURLSessionDataTask *task = [sessoin dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil) {
            return;
        }
        UIImage* image = [UIImage imageWithData:data];
        [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];

            //dipatch_async(dispatch_get_main_queue(), ^{
            //    imageView.image = [UIImage imageWithData: data];
            //});
    }];
   */
    [task resume];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier: @"AlbumCell"];
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"AlbumCell"];
    }
    
    Album* currentAlbum = [self.albums objectAtIndex: indexPath.row];
    if(currentAlbum) {
        NSURL* url = [NSURL URLWithString:currentAlbum.imgUrl];
        NSError* error = [[NSError alloc] init];
        NSData* data = [NSData dataWithContentsOfURL:url options:kNilOptions error:&error];
        UIImage* image = [UIImage imageWithData: data];
        cell.image.image = image;
        
        
       // [self downloadImageFor:cell.image WithUrl:currentAlbum.imgUrl];
        //cell.image.image = image;
        cell.title.text = currentAlbum.title;
        cell.intro.text = currentAlbum.intro;
        cell.tracks.text = [NSString stringWithFormat: @"%d个曲目", [currentAlbum.tracks count]];
    }
    return cell;
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
