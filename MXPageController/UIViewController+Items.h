//
//  UIViewController+Items.h
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
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
