//
//  LPHPageController.m
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPHPageController.h"
#import "UIViewController+Items.h"

static CGFloat _duration = 2.5;

@interface LPHPageController () <UIScrollViewDelegate, LPHPageBarDelegate>

@end

@implementation LPHPageController{
    UIScrollView *_scrollView;
    BOOL _isSelectedScroll;
}

#pragma mark - UiViewController

- (void)loadView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pageBar = [[LPHPageBar alloc] initWithFrame:CGRectZero];
    _pageBar.delegate = self;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)reloadViews {
    if (_scrollView) {//TODO释放子控制器的presented指针
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
        }
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSMutableArray<LPHPageBarItem *> *items = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        //vc.hPageController = self;//TODO
        vc.view.frame = CGRectMake(self.view.bounds.size.width * idx, 0, 0, 0);
        [_scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        if (!vc.pageBarItem) {
            vc.pageBarItem = [[LPHPageBarItem alloc] init];
        }
        [items addObject:vc.pageBarItem];
    }];
    
    _pageBar.topViewRect = _topView.frame;
    _pageBar.items = items;
    [self.view addSubview:_pageBar];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat topOffset = _topView.bounds.size.height + _pageBar.bounds.size.height;
    CGFloat bottomOffset = _bottomView.bounds.size.height;
    _scrollView.frame = CGRectMake(0, topOffset,
                                   self.view.bounds.size.width,
                                   self.view.bounds.size.height - topOffset - bottomOffset);
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _viewControllers.count, 0);
}

#pragma mark - Accessors

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    if (_viewControllers) {
        _selectedIndex = 0;
        [self reloadViews];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _scrollView.contentOffset = CGPointMake(selectedIndex * self.view.bounds.size.width, 0);
}

- (void)setTopView:(UIView *)topView {
    if (_topView) {
        [_topView removeFromSuperview];
    }
    _topView = topView;
    _topView.frame = CGRectMake(0, 0, self.view.bounds.size.width, _topView.bounds.size.height);
    _pageBar.topViewRect = _topView.frame;
    [self.view addSubview:_topView];
}

- (void)setBottomView:(UIView *)bottomView {
    if (_bottomView) {
        [_bottomView removeFromSuperview];
    }
    _bottomView = bottomView;
    _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - _bottomView.bounds.size.height,
                                   self.view.bounds.size.width,
                                   _bottomView.bounds.size.height);
    [self.view addSubview:_bottomView];
}

#pragma mark - Public

- (void)reloadPageBarViews {
    if (_pageBar) {
        [_pageBar reloadViews];
    }
}

#pragma mark - LPHPageBarDelegate

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration {
    _isSelectedScroll = YES;
    _duration = duration;
    self.selectedIndex = section;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    CGFloat refrenceOffset = _selectedIndex * self.view.bounds.size.width;
    CGFloat offsetScale = (scrollView.contentOffset.x - refrenceOffset) / self.view.bounds.size.width;
    if (fmodf(offsetScale, 1) != 0) {
        _isSelectedScroll = NO;
    }
    if (_isSelectedScroll) {
        _selectedIndex += offsetScale;;
    } else {
        _pageBar.offsetScale = offsetScale;
        if (fabs(offsetScale) >= 1) {
            _selectedIndex += (NSInteger)offsetScale;
        }
    }
}

@end
