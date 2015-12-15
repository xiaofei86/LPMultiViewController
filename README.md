# LPMultiViewController

如果基于CocoaTouch进行iOS开发，那UIViewController基本控制着App中几乎所有的交互。但是，UIViewController只能控制单个View，App不可能只由单个View构成。在多视图的App中，必须要有控制器来同时控制多个View，以便实现他们之间的切换和跳转。UIKit供了UINavigationController和UITabBarCotroller来满足这样的需求。基本所有的APP都会同时用到这两种控制器，可见其重要性和普遍性。但是对于一些不常用的场景，苹果可能并不打算提供对应的控制器。LPMultiViewController（视图集控制器）打算补充一些常用（但并不是每个APP都能用到）的控制器。

经过对主流APP的分析，暂时总结出来了三个需要补充的控制器，LPHPageViewController、LPVPageViewController和LPSideBarController。

LPHPageViewController为横向滑动翻页的控制器

LPVPageViewController为纵向滑动翻页的控制器

LPSideBarController为侧向滑动展开隐藏分区的控制器

暂时只实现LPHPageViewController（类似于安卓的ViewPager）。效果如下。

注：如果图片不能显示请尝试将VPN设为全局模式，也可以关闭VPN通过备用链接查看

[备用链接](http://b.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=2f14d669af773912c0268669c822f725/37d12f2eb9389b5096d570868335e5dde7116e38.jpg)

<img src = "https://github.com/xiaofei86/LPMultiViewController/raw/master/Images/1.gif" width = 373>

[备用链接](http://g.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=e99cfd267f310a55c024ddfc877e3294/caef76094b36acaf3077f1297ad98d1000e99c4b.jpg)

<img src = "https://github.com/xiaofei86/LPMultiViewController/raw/master/Images/2.png" width = 373>

#Design Pattern
设计模式参照了UINavigationController和UITabBarCotroller。即通过category结合runtime的关联对象给UIViewController加property “pageBarItem”，然后通过controller的item控制LPHPageViewController上的pageBar的属性。

通过关联controller中的scrollView和pageBar中的scrollView，实现pageBar中指示器的联动和字体颜色的渐变。

pageBar中的每一个tab宽度会进行自适应。当最大的字体宽度（加上边距）乘以tab数，如果超过屏幕宽度，则每个tab的宽度为字体宽度。如果不超过屏幕宽度，则会将每个tab的宽度等分屏幕宽度。如果用户在对应的controller里设置其中任意一个或多个tab的宽度，就算满足“最大的字体宽度乘以tab数不超过屏幕宽度”也不会进行等分，而是以用户设置的为准，并且没有设置的会根据字体去自适应。

指示器的宽度默认与tab相同。用户也可以单独设置。

架构基本与UINavigationController、UITabBarCotroller一致。用法对比如下。

	self.hPageController.pageBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];

	self.navigationItem.title = @"LPHPageController";
    self.pageBarItem.title = @"LPHPageController";
    
    self.viewControllers = @[tabViewController1, tabViewController2];//LPHPageController
    self.viewControllers = @[tabViewController1, tabViewController2];//UITabBarCotroller
    
    self.selectedIndex = 0;//LPHPageController
    self.selectedIndex = 0;//UITabBarCotroller
    
#How to use
具体使用于UITabBarCotroller相似。通过子类化LPHPageController并在init方法中给self.viewControllers赋值就可以了。pageBar的样式分别在每个controller中通过pageBarItem定制。

controller可定制的单个tab样式有如下这些。

	@property (nonatomic, strong) NSString *title;
	@property (nonatomic, assign) CGFloat itemWidth;
	@property (nonatomic, assign) CGFloat indicatorWidth;
	@property (nonatomic, assign) BOOL showBadge;//红色通知标示
	@property (nonatomic, strong) UIView *customView;//如果设置了customView其他参数将无效，整个tab就显示customView。
	
只能通过self.pageBar统一设置的tab样式有如下这些。

	@property (nonatomic, strong) UIColor *textColor;
	@property (nonatomic, strong) UIFont *itemFont;
	@property (nonatomic, assign) CGFloat itemHeight;
	@property (nonatomic, assign) CGFloat indicatorHeight;
	@property (nonatomic, assign) CGFloat offsetScale;//指示器从当前tab向下个tab的偏移、缩放及渐变的比例。范围[0,1]。
	
LPHPageController可供设置的property有如下这些。

	@property (nonatomic, strong) LPHPageBar *pageBar;
	@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
	@property (nonatomic, strong) UIView *bottomView;//不跟随滑动的尾部视图，在页面最底
	@property (nonatomic, strong) UIView *topView;//不跟随滑动的头部视图，在pageBar之上
	@property (nonatomic, assign) NSUInteger selectedIndex;
	- (void)reloadViews;
	- (void)reloadPageBarViews;
	
具体使用方法课参照Demo。

---
>*已在二个APP中使用*
