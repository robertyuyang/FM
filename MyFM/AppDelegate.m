//
//  AppDelegate.m
//  MyFM
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarControllers.h"

#import "TrackPlayViewController.h"
#import "HomePageViewController.h"
#import "DiscoveryViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    MainTabBarControllers* mainVC = [[MainTabBarControllers alloc] init];
   
    
    
    HomePageViewController* homePageVC = [[HomePageViewController alloc] init];
    homePageVC.tabBarItem.title = @"首页";
    DiscoveryViewController* discoveryVC = [[DiscoveryViewController alloc] init];
    discoveryVC.tabBarItem.title = @"发现";
    MineViewController* mineVC = [[MineViewController alloc] init];
    mineVC.tabBarItem.title = @"我的";
   
    mainVC.viewControllers = @[homePageVC, discoveryVC, mineVC];
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void) remoteControlReceivedWithEvent:(UIEvent *)event {
   
    TrackPlayViewController* trackPlayVC = [TrackPlayViewController sharedInstance];
    
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [trackPlayVC play];
            break;
        case UIEventSubtypeRemoteControlPause:
            [trackPlayVC pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [trackPlayVC next];
            break;
        case UIEventSubtypeRemoteControlStop:
            [trackPlayVC stop];
            break;
        default:
            break;
    }
}

@end
