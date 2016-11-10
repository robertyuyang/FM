//
//  TrackListTableViewController.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "TrackListTableViewController.h"
#import "TrackListTableViewCell.h"
#import "Track.h"
#import "TrackPlayViewController.h"

@interface TrackListTableViewController ()

@end

@implementation TrackListTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Track* track = [self.tracks objectAtIndex: indexPath.row];
    if(track != nil) {
        
       
        TrackPlayViewController* trackPlayVC = [TrackPlayViewController sharedInstance];
        
        trackPlayVC.track = track;
        trackPlayVC.title = track.title;
        [self.navigationController pushViewController:trackPlayVC animated:YES];
    }
}
#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TrackCell"];
    if(cell == nil) {
        cell = [[TrackListTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"TrackCell"];
    }
   
    Track* track = [self.tracks objectAtIndex: indexPath.row];
    
    if(track == nil) {
        return nil;
    }
    cell.titleLabel.text = track.title;
    [cell.titleLabel sizeToFit];
    cell.durationLabel.text = [NSString stringWithFormat: @"%.2d:%.2d",track.duration / 60, track.duration % 60];
    [cell.durationLabel sizeToFit];

    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
