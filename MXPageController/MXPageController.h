//
//  MXPageController.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import "MXPageProtocal.h"

@interface MXPageController : UIViewController <MXPageControllerProtocal>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;

@end
