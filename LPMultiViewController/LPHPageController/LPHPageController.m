//
//  LPHPageController.m
//  LPMultiViewControllerDemo
//
//  Created by XuYafei on 15/11/9.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPHPageController.h"
#import "UIViewController+Items.h"

static CGFloat _duration = 0.25;

@interface LPHPageController () <UIScrollViewDelegate, LPHPageBarDelegate>

@end

@implementation LPHPageController{
    UIScrollView *_scrollView;
    BOOL _isSelectedScroll;
    BOOL _isScrollBegin;
}

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _isScrollBegin = YES;
    }
    return self;
}

#pragma mark - UiViewController

- (void)loadView {
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
    _scrollView.scrollsToTop = NO;
    [self.view addSubview:_scrollView];
    
    NSMutableArray<LPHPageBarItem *> *items = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        vc.hPageController = self;
        vc.view.frame = CGRectMake(self.view.bounds.size.width * idx, 0, 0, 0);
        [_scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        if (!vc.pageBarItem) {
            vc.pageBarItem = [[LPHPageBarItem alloc] init];
        }
        [items addObject:vc.pageBarItem];
    }];
    _pageBar.hPageController = self;
    _pageBar.topViewRect = _topView.frame;
    _pageBar.items = items;
    [self.view addSubview:_pageBar];
    
    if (_bottomView) {
        [self.view bringSubviewToFront:_bottomView];
    }
    if (_topView) {
        [self.view bringSubviewToFront:_topView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self reloadFrame];
}

- (void)reloadFrame {
    _pageBar.center = CGPointMake(_pageBar.center.x, _topView.frame.size.height + _pageBar.frame.size.height * (0.5 - _offsetScale));
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_pageBar.frame),
                                   self.view.bounds.size.width,
                                   self.view.bounds.size.height - CGRectGetMaxY(_pageBar.frame) - _bottomView.bounds.size.height);
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _viewControllers.count, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_viewControllers[_selectedIndex] lp_viewWillAppear:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_viewControllers[_selectedIndex] lp_viewDidAppear:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_viewControllers[_selectedIndex] lp_viewWillDisappear:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_viewControllers[_selectedIndex] lp_viewDidDisappear:NO];
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

- (void)setOffsetScale:(CGFloat)offsetScale {
    _offsetScale = offsetScale;
    [self reloadFrame];
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    _scrollView.scrollEnabled = _scrollEnable;
    _pageBar.userInteractionEnabled = _scrollEnable;
}

#pragma mark - Public

- (void)reloadPageBarViews {
    if (_pageBar) {
        [_pageBar reloadViews];
        [self reloadFrame];
    }
}

- (void)reloadPageBarItems {
    NSMutableArray<LPHPageBarItem *> *items = [NSMutableArray array];
    for (UIViewController *vc in _viewControllers) {
        [items addObject:vc.pageBarItem];
    }
    _pageBar.items = items;
}

#pragma mark - LPHPageBarDelegate

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration {
    _isSelectedScroll = YES;
    _duration = duration;
    
    [_viewControllers[_selectedIndex] lp_viewWillDisappear:NO];
    UIViewController *previousController = _viewControllers[_selectedIndex];
    [self performWithDelay:_duration completion:^{
        [previousController lp_viewDidDisappear:NO];
    }];
    
    self.selectedIndex = section;
    
    [_viewControllers[_selectedIndex] lp_viewWillAppear:NO];
    UIViewController *nextController = _viewControllers[_selectedIndex];
    [self performWithDelay:_duration completion:^{
        [nextController lp_viewDidAppear:NO];
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    CGFloat refrenceOffset = _selectedIndex * self.view.bounds.size.width;
    CGFloat offsetScale = (scrollView.contentOffset.x - refrenceOffset) / self.view.bounds.size.width;
    if (fmodf(offsetScale, 1) != 0) {
        _isSelectedScroll = NO;
    }
    if (_isScrollBegin) {
        [_viewControllers[_selectedIndex] lp_viewWillDisappear:YES];
        NSInteger offset = offsetScale / fabs(offsetScale) * ceil(fabs(offsetScale));
        [_viewControllers[_selectedIndex + offset] lp_viewWillAppear:YES];
        _isScrollBegin = NO;
    }
    
    if (_isSelectedScroll) {
        _selectedIndex += offsetScale;
    } else {
        _pageBar.offsetScale = offsetScale;
        if (fabs(offsetScale) >= 1) {
            [_viewControllers[_selectedIndex] lp_viewDidDisappear:YES];
            _selectedIndex += (NSInteger)offsetScale;
            [_viewControllers[_selectedIndex] lp_viewDidAppear:YES];
            _isScrollBegin = YES;
        }
    }
    
    [self.view endEditing:YES];
}

#pragma mark - RunLoop

- (void)performWithDelay:(CGFloat)delay completion:(void (^)(void))block {
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end
