//
//  LPHPageBar.h
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPHPageBarItem;
@class LPHPageController;

@protocol LPHPageBarDelegate <NSObject>

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration;

@end

@interface LPHPageBar : UIView

@property (nonatomic, strong) NSArray<LPHPageBarItem* > *items;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, assign) CGRect topViewRect;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat indicatorHeight;

@property (nonatomic, assign) CGFloat offsetScale;

@property (nonatomic, assign) id<LPHPageBarDelegate> delegate;

@property (nonatomic, assign) LPHPageController *hPageController;

- (void)reloadViews;

- (void)reloadItems;

@end
