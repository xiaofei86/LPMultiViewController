//
//  LPHPageController.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPHPageBarItem;
@class LPHPageBar;

@interface LPHPageController : UIViewController

@property (nonatomic, strong) LPHPageBar *pageBar;

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, assign) CGFloat offsetScale;

@property (nonatomic, assign) BOOL scrollEnable;

- (void)reloadViews;

- (void)reloadPageBarViews;

- (void)reloadPageBarItems;

@end
