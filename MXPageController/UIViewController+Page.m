//
//  UIViewController+Page.m
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import "UIViewController+Page.h"
#import <objc/runtime.h>

@implementation UIViewController (Items)

static const void *pageBarItemKey = &pageBarItemKey;
static const void *pageControllerKey = &pageControllerKey;

@dynamic pageBarItem;
@dynamic pageController;

- (MXPageBarItem *)pageBarItem {
    return objc_getAssociatedObject(self, pageBarItemKey);
}

- (void)setPageBarItem:(MXPageBarItem *)pageBarItem {
    objc_setAssociatedObject(self, pageBarItemKey, pageBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MXPageController *)pageController {
    return objc_getAssociatedObject(self, pageControllerKey);
}

- (void)setPageController:(MXPageController *)pageController {
    objc_setAssociatedObject(self,pageControllerKey, pageController, OBJC_ASSOCIATION_ASSIGN);
}

- (void)pageViewWillAppear:(BOOL)animated {
    
}

- (void)pageViewDidAppear:(BOOL)animated {
    
}

- (void)pageViewWillDisappear:(BOOL)animated {
    
}

- (void)pageViewDidDisappear:(BOOL)animated {
    
}

@end
