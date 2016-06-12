//
//  AppDelegate.m
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2016年 maxthon. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [_window makeKeyAndVisible];
    return YES;
}

@end
