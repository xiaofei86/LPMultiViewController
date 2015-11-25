//
//  LPHPageBarItem.h
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPHPageBar;

@interface LPHPageBarItem : NSObject

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title
                    itemWidth:(CGFloat)itemWidth
               indicatorWidth:(CGFloat)indicatorWidth
                    showBadge:(BOOL)showBadge;

- (instancetype)initWithCustomView:(UIView *)customView
                    indicatorWidth:(CGFloat)indicatorWidth;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat indicatorWidth;
@property (nonatomic, assign) BOOL showBadge;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, assign) LPHPageBar *pageBar;

@end
