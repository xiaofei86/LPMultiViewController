//
//  MXPageBar_Private.h
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/13.
//  Copyright © 2016年 maxthon. All rights reserved.
//

#import "MXPageBar.h"
#import "MXPageController.h"
#import "MXPageBarItem.h"

@protocol MXPageBarDelegate <NSObject>

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration;

@end

@interface MXPageBar ()

@property (nonatomic, weak) id<MXPageBarDelegate> delegate;

@property (nonatomic, weak) MXPageController *pageController;
@property (nonatomic, strong) NSArray<MXPageBarItem *> *items;

@end
