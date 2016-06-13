//
//  MXPageBarItem.m
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import "MXPageBarItem.h"
#import "MXPageBar.h"
#import "MXPageBarItem_Private.h"

@implementation MXPageBarItem

@synthesize title = _title;
@synthesize width = _width;
@synthesize customView = _customView;
@synthesize indicatorWidth = _indicatorWidth;
@synthesize showBadge = _showBadge;

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _width = 0;
        _indicatorWidth = 0;
        _customView = nil;
        _pageBar = nil;
        _showBadge = NO;
        _title = [NSString string];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                    itemWidth:(CGFloat)itemWidth
               indicatorWidth:(CGFloat)indicatorWidth
                    showBadge:(BOOL)showBadge {
    self = [super init];
    if (self) {
        _title = title;
        _width = itemWidth;
        _indicatorWidth = indicatorWidth;
        _showBadge = showBadge;
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView
                    indicatorWidth:(CGFloat)indicatorWidth {
    self = [super init];
    if (self) {
        _width = customView.frame.size.width;
        _indicatorWidth = indicatorWidth;
    }
    return self;
}

#pragma mark - Accessor

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_pageBar) {
        [_pageBar updateItems];
    }
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _width = itemWidth;
    if (_pageBar) {
        [_pageBar updateView];
    }
}

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    if (_pageBar) {
        [_pageBar updateView];
    }
}

- (void)setShowBadge:(BOOL)showBadge {
    _showBadge = showBadge;
    if (_pageBar) {
        [_pageBar updateView];
    }
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    if (_pageBar) {
        [_pageBar updateView];
    }
}

@end
