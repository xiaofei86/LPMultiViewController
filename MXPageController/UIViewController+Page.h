//
//  UIViewController+Page.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MXPageBarItem.h"
#import "MXPageBar.h"
#import "MXPageController.h"

@interface UIViewController (Items)

@property (nonatomic, strong) MXPageBarItem *pageBarItem;
@property (nonatomic, weak) MXPageController *pageController;

- (void)pageViewWillAppear:(BOOL)animated;
- (void)pageViewDidAppear:(BOOL)animated;
- (void)pageViewWillDisappear:(BOOL)animated;
- (void)pageViewDidDisappear:(BOOL)animated;

@end
