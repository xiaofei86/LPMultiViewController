//
//  ViewController.m
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "ViewController.h"
#import "TabViewController1.h"
#import "TabViewController2.h"
#import "TabViewController3.h"
#import "TabViewController4.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"LPHPageController";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TabViewController1 *tabViewController1 = [[TabViewController1 alloc] init];
    TabViewController2 *tabViewController2 = [[TabViewController2 alloc] init];
    TabViewController3 *tabViewController3 = [[TabViewController3 alloc] init];
    TabViewController4 *tabViewController4 = [[TabViewController4 alloc] init];
    
    tabViewController1.pageBarItem = [[LPHPageBarItem alloc] initWithTitle:@"tabViewController1"];
    tabViewController2.pageBarItem = [[LPHPageBarItem alloc] initWithTitle:@"viewController2"];
    tabViewController3.pageBarItem = [[LPHPageBarItem alloc] initWithTitle:@"controller3"];
    tabViewController4.pageBarItem = [[LPHPageBarItem alloc] initWithTitle:@"4"];
    
    tabViewController1.pageBarItem.showBadge = YES;
    tabViewController2.pageBarItem.showBadge = NO;
    tabViewController3.pageBarItem.showBadge = YES;
    tabViewController4.pageBarItem.showBadge = NO;
    
    self.pageBar.tintColor = [UIColor orangeColor];
    
    self.viewControllers = @[tabViewController1, tabViewController2, tabViewController3, tabViewController4];
}

@end
