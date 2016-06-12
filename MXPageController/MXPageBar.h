//
//  MXPageBar.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXPageBarItem;
@class MXPageController;

@protocol MXPageBarDelegate <NSObject>

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration;

@end

@interface MXPageBar : UIView

@property (nonatomic, strong) NSArray<MXPageBarItem* > *items;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, assign) CGRect topViewRect;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat indicatorHeight;

@property (nonatomic, assign) CGFloat offsetScale;

@property (nonatomic, weak) id<MXPageBarDelegate> delegate;

@property (nonatomic, weak) MXPageController *pageController;

- (void)reloadViews;

- (void)reloadItems;

@end
