//
//  MXPageController.m
//  MXPageControllerDemo
//
//  Created by 徐亚非 on 16/6/12.
//  Copyright © 2015年 maxthon. All rights reserved.
//

#import "MXPageController.h"
#import "UIViewController+Page.h"

static CGFloat _duration = 0.25;

@interface MXPageController () <UIScrollViewDelegate, MXPageBarDelegate>

@end

@implementation MXPageController{
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
    
    _pageBar = [[MXPageBar alloc] initWithFrame:CGRectZero];
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
    
    NSMutableArray<MXPageBarItem *> *items = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        vc.pageController = self;
        vc.view.frame = CGRectMake(self.view.bounds.size.width * idx, 0, 0, 0);
        [_scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        if (!vc.pageBarItem) {
            vc.pageBarItem = [[MXPageBarItem alloc] init];
        }
        [items addObject:vc.pageBarItem];
    }];
    _pageBar.pageController = self;
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
    [_viewControllers[_selectedIndex] pageViewWillAppear:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_viewControllers[_selectedIndex] pageViewDidAppear:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_viewControllers[_selectedIndex] pageViewWillDisappear:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_viewControllers[_selectedIndex] pageViewDidDisappear:NO];
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
    NSMutableArray<MXPageBarItem *> *items = [NSMutableArray array];
    for (UIViewController *vc in _viewControllers) {
        [items addObject:vc.pageBarItem];
    }
    _pageBar.items = items;
}

#pragma mark - MXPageBarDelegate

- (void)didSelectedAtSection:(NSInteger)section withDuration:(NSTimeInterval)duration {
    _isSelectedScroll = YES;
    _duration = duration;
    
    [_viewControllers[_selectedIndex] pageViewWillDisappear:NO];
    UIViewController *previousController = _viewControllers[_selectedIndex];
    [self performWithDelay:_duration completion:^{
        [previousController pageViewDidDisappear:NO];
    }];
    
    self.selectedIndex = section;
    
    [_viewControllers[_selectedIndex] pageViewWillAppear:NO];
    UIViewController *nextController = _viewControllers[_selectedIndex];
    [self performWithDelay:_duration completion:^{
        [nextController pageViewDidAppear:NO];
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
        [_viewControllers[_selectedIndex] pageViewWillDisappear:YES];
        NSInteger offset = offsetScale / fabs(offsetScale) * ceil(fabs(offsetScale));
        [_viewControllers[_selectedIndex + offset] pageViewWillAppear:YES];
        _isScrollBegin = NO;
    }
    
    if (_isSelectedScroll) {
        _selectedIndex += offsetScale;
    } else {
        _pageBar.offsetScale = offsetScale;
        if (fabs(offsetScale) >= 1) {
            [_viewControllers[_selectedIndex] pageViewDidDisappear:YES];
            _selectedIndex += (NSInteger)offsetScale;
            [_viewControllers[_selectedIndex] pageViewDidAppear:YES];
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
