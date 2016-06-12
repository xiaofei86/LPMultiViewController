//
//  UIViewController+Items.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LPHPageBarItem.h"
#import "LPHPageBar.h"
#import "LPHPageController.h"

@interface UIViewController (Items)

@property (nonatomic, strong) LPHPageBarItem *pageBarItem;
@property (nonatomic, assign) LPHPageController *hPageController;

- (void)pageViewWillAppear:(BOOL)animated;
- (void)pageViewDidAppear:(BOOL)animated;
- (void)pageViewWillDisappear:(BOOL)animated;
- (void)pageViewDidDisappear:(BOOL)animated;

@end
