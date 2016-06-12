//
//  MXPageBarItem.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXPageBar;

@interface MXPageBarItem : NSObject

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

@property (nonatomic, weak) MXPageBar *pageBar;

@end
