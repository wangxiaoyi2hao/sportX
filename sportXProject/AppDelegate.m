//
//  AppDelegate.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "AppDelegate.h"
#import "MineViewController.h"
#import "MessageViewController.h"
#import "OutSignViewController.h"
#import "SportXViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UITabBarController*tabControl=[[UITabBarController alloc]init];
    SportXViewController*home=[[SportXViewController alloc]init];
    home.tabBarItem.title=@"发现";
    home.tabBarItem.image=[UIImage imageNamed:@""];
    OutSignViewController*web=[[OutSignViewController alloc]init];
    web.tabBarItem.title=@"关注";
    web.tabBarItem.image=[UIImage imageNamed:@""];
//    MessageViewController*center=[[MessageViewController alloc]init];
//    center.tabBarItem.title=@"消息";
//    center.tabBarItem.image=[UIImage imageNamed:@"tab_me.png"];
    MineViewController*setting=[[MineViewController alloc]init];
    setting.tabBarItem.title=@"我";
    setting.tabBarItem.image=[UIImage imageNamed:@""];
    tabControl.delegate=self;
    tabControl.viewControllers=@[home,web,setting];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:tabControl];
    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    if([[UIDevice currentDevice].systemVersion floatValue]>=7.0){
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    _window.rootViewController=nav;
    [_window makeKeyAndVisible];

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
