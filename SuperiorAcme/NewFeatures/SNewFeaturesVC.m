//
//  SNewFeaturesVC.m
//  ShoesCloud
//
//  Created by wangsen on 15/12/7.
//  Copyright © 2015年 GYM. All rights reserved.
//

#import "SNewFeaturesVC.h"
#import "SNTabBarController.h"//标签栏
#import "SOnlineShop.h"//线上商城
#import "SLineShop.h"//线下商城
#import "SMore.h"//更多
#import "SShopCar.h"//购物车
#import "SMine.h"//我的

@interface SNewFeaturesVC () <UIScrollViewDelegate>
{
    NSArray * _imagesArray;
    UIPageControl * _pageControl;
    
    UIButton * _goInHomeButton;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SNewFeaturesVC

- (void)viewWillAppear:(BOOL)animated {
//    [MobClick beginLogPageView:@"引导页"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白

}
- (void)viewWillDisappear:(BOOL)animated
{
//    [MobClick endLogPageView:@"引导页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _goInHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goInHomeButton.frame = CGRectMake(ScreenW, ScreenH/2 - 25, 50, 44);
    _goInHomeButton.alpha = 0.6;
    [_goInHomeButton setImage:[UIImage imageNamed:@"goInHome"] forState:UIControlStateNormal];
    [self.view addSubview:_goInHomeButton];
    
    _scrollView.delegate = self;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000f green:0.412f blue:0.243f alpha:1.00f];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:_pageControl];
    
//    if (ScreenH <= 480) {
//        _imagesArray = @[@"4S引导页1",@"4S引导页2",@"4S引导页3",@"4S引导页4"];
//    } else if (ScreenH <= 568) {
//        _imagesArray = @[@"5S引导页1",@"5S引导页2",@"5S引导页3",@"5S引导页4"];
//    } else if (ScreenH <= 667) {
//        _imagesArray = @[@"6引导页1",@"6引导页2",@"6引导页3",@"6引导页4"];
//    } else if (ScreenH <= 736) {
//        _imagesArray = @[@"6Plus引导页1",@"6Plus引导页2",@"6Plus引导页3",@"6Plus引导页4"];
//    }
    _imagesArray = @[@"引导页01",@"引导页02",@"引导页03",@"引导页04"];
    
    for (NSInteger i = 0;  i < _imagesArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + ScreenW * i, 0, ScreenW , ScreenH)];
        imageView.image = [UIImage imageNamed:_imagesArray[i]];
        [_scrollView addSubview:imageView];
        if (i == 3) {
            //滑动
            UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGoInHome:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:pan];
            
            //点击
            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
            [imageView addGestureRecognizer:singleTap];
        }
    }
    _scrollView.contentSize = CGSizeMake(ScreenW * _imagesArray.count, 0);
    
    _pageControl.numberOfPages = _imagesArray.count;
    CGSize _pageControlSize = [_pageControl sizeForNumberOfPages:_imagesArray.count];
    _pageControl.frame = CGRectMake(ScreenW/2, ScreenH - ScreenH*0.1, _pageControlSize.width, _pageControlSize.height);
    _pageControl.hidden = YES;//隐藏
}

#pragma mark - 点击
- (void)onClickImage {
//    SOnlineShop * vc1 = [[SOnlineShop alloc] init];
//    vc1.tabBarItem.title = @"线上商城";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"线上商城默认"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"线上商城选中"];
//
//    SLineShop * vc2 = [[SLineShop alloc] init];
//    vc2.tabBarItem.title = @"线下店铺";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"线下商城默认"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"线下商城选中"];
//
//    SMore * vc3 = [[SMore alloc] init];
//    vc3.tabBarItem.title = @"更多";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"更多选中"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"更多选中"];
//
//    SShopCar * vc4 = [[SShopCar alloc] init];
//    vc4.tabBarItem.title = @"购物车";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"购物车默认"];
//    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"购物车选中"];
//
//    SMine * vc5 = [[SMine alloc] init];
//    vc5.tabBarItem.title = @"我的";
//    vc5.tabBarItem.image = [UIImage imageNamed:@"我的默认"];
//    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"我的选中"];
    
    SNTabBarController * tabBarController = [[SNTabBarController alloc] init];

//    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
//    nav1.delegate = tabBarController;
//    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//    nav2.delegate = tabBarController;
//    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
//    nav3.delegate = tabBarController;
//    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
//    nav4.delegate = tabBarController;
//    UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
//    nav5.delegate = tabBarController;
//
//
//    tabBarController.itemImageScale = 0.6;
//    tabBarController.tabBarBgColor = [UIColor blackColor];
//    tabBarController.normalItemColor = [UIColor blackColor];
//    tabBarController.selectedItemColor = [UIColor blackColor];
//    tabBarController.itemFont = [UIFont systemFontOfSize:10];
//    tabBarController.defaultSelectedIndex = 0;
//
//    tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.view.window.rootViewController = tabBarController;
}

#pragma mark - 滑动
- (void)panGoInHome:(UIPanGestureRecognizer *)pan {
    
    CGFloat panX = [pan translationInView:pan.view].x;
    if (panX <= -50) {
        panX = -50;
    }
    CGRect buttonFrame = _goInHomeButton.frame;
    buttonFrame.origin.x = ScreenW+panX;
    _goInHomeButton.frame = buttonFrame;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (panX <= - 25) {
            [UIView animateWithDuration:0.28 animations:^{
                CGRect buttonFrame = _goInHomeButton.frame;
                buttonFrame.origin.x = ScreenW-50;
                _goInHomeButton.frame = buttonFrame;
            } completion:^(BOOL finished) {
                
//                SOnlineShop * vc1 = [[SOnlineShop alloc] init];
//                vc1.tabBarItem.title = @"线上商城";
//                vc1.tabBarItem.image = [UIImage imageNamed:@"线上商城默认"];
//                vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"线上商城选中"];
//
//                SLineShop * vc2 = [[SLineShop alloc] init];
//                vc2.tabBarItem.title = @"线下店铺";
//                vc2.tabBarItem.image = [UIImage imageNamed:@"线下商城默认"];
//                vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"线下商城选中"];
//
//                SMore * vc3 = [[SMore alloc] init];
//                vc3.tabBarItem.title = @"更多";
//                vc3.tabBarItem.image = [UIImage imageNamed:@"更多选中"];
//                vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"更多选中"];
//
//                SShopCar * vc4 = [[SShopCar alloc] init];
//                vc4.tabBarItem.title = @"购物车";
//                vc4.tabBarItem.image = [UIImage imageNamed:@"购物车默认"];
//                vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"购物车选中"];
//
//                SMine * vc5 = [[SMine alloc] init];
//                vc5.tabBarItem.title = @"我的";
//                vc5.tabBarItem.image = [UIImage imageNamed:@"我的默认"];
//                vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"我的选中"];
//
//                UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
//                UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//                UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
//                UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
//                UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
                
                SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
                
//                tabBarController.itemImageScale = 0.6;
//                tabBarController.tabBarBgColor = [UIColor blackColor];
//                tabBarController.normalItemColor = [UIColor blackColor];
//                tabBarController.selectedItemColor = [UIColor blackColor];
//                tabBarController.itemFont = [UIFont systemFontOfSize:10];
//                tabBarController.defaultSelectedIndex = 0;
//                
//                tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
                self.view.window.rootViewController = tabBarController;
            }];
        } else {
            [UIView animateWithDuration:0.28 animations:^{
                CGRect buttonFrame = _goInHomeButton.frame;
                buttonFrame.origin.x = ScreenW;
                _goInHomeButton.frame = buttonFrame;
            }];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x/ScreenW;
}

@end
