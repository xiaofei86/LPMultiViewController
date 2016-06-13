//
//  MXPageBar.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import "MXPageProtocal.h"

@interface MXPageBar : UIView <MXPageBarProtocal>

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, assign) CGRect topViewRect;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat indicatorHeight;

@end
