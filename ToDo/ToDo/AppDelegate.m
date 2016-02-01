//
//  AppDelegate.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    SettingVC *setVC = [[SettingVC alloc]init];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainVC = [board instantiateViewControllerWithIdentifier:@"mainNavID"];
//    [mainVC.navigationBar setBackgroundColor:[UIColor blackColor]];
//    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
//    bgImageView.image = [UIImage imageNamed:@"navigationbar_bg"];
//    [mainVC.navigationBar addSubview:bgImageView];
//    [mainVC.navigationBar sendSubviewToBack:bgImageView];
#if 0
    //设置YRVC
    _YRVC = [[YRSideViewController alloc] init];
    _YRVC.rootViewController = mainVC;
    _YRVC.leftViewController = setVC;
    _YRVC.leftViewShowWidth = 200;
    //默认开启可滑动展示
    [_YRVC setNeedSwipeShowMenu:NO];
    //默认关闭动画效果
    [_YRVC setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
       //使用简单平移效果
        rootView.frame = CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
#endif
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
