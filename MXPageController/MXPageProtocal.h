//
//  MXPageProtocal.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/13.
//  Copyright © 2016年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXPageBarProtocal;

@protocol MXPageBarItemProtocal <NSObject>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat indicatorWidth;
@property (nonatomic, assign) BOOL showBadge;
@property (nonatomic, strong) UIView *customView;

@end

@protocol MXPageBarProtocal <NSObject>

@property (nonatomic, assign) CGFloat offset;

- (void)updateView;
- (void)updateItems;

@end

@protocol MXPageControllerProtocal <NSObject>

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) BOOL scrollEnable;
@property (nonatomic, strong) UIView<MXPageBarProtocal> *pageBar;

- (void)updateView;
- (void)updatePageBar;
- (void)updatePageBarItems;

@end
