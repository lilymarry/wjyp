//
//  SNTabBarController.m
//  SNTabBarVC
//
//  Created by wangsen on 16/3/26.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SNTabBarController.h"
#import "SNTabBarConst.h"
#import "SNTabBar.h"
#import "SNTabBarItem.h"

#import "SOnlineShop.h"
#import "SLineShop.h"
#import "SMore.h"
#import "SShopCar.h"
#import "SMine.h"

/*
 *添加自定义的TabBar,并替换TabBarController中自带的TabBar
 */
#import "SNVersionOneTabBar.h"

@interface SNTabBarController () <SNTabBarDelegate>
@property (nonatomic, strong) SNTabBar * snTabBar;
@end

@implementation SNTabBarController
{
    CommonMoreView *commonMoreView;
    UIButton *moreBtn;
    UIImageView * moreBtnImage;
    UILabel * moreBtnLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //图片比例
    self.itemImageScale = 0.7f;
    self.defaultSelectedIndex = 0;
    
    /*
     *替换系统默认的TabBar为自定义的TabBar
     */
    [self setValue:[[SNVersionOneTabBar alloc] init] forKey:@"tabBar"];
    
    //创建tabBar
    [self createSNTabBar];
    
    //创建子控制器
    [self CreatChildController];
    
}

- (void)createSNTabBar {
    self.snTabBar = [[SNTabBar alloc] initWithFrame:self.tabBar.bounds];
    self.snTabBar.delegate = self;
    [self.tabBar addSubview:self.snTabBar];
}

-(void)CreatChildController{
    SOnlineShop * vc1 = [[SOnlineShop alloc] init];
    vc1.tabBarItem.title = @"线上商城";
    vc1.tabBarItem.image = [UIImage imageNamed:@"线上商城默认"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"线上商城选中"];
    
    SLineShop * vc2 = [[SLineShop alloc] init];
    vc2.tabBarItem.title = @"线下店铺";
    vc2.tabBarItem.image = [UIImage imageNamed:@"线下商城默认"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"线下商城选中"];
    
    SMore * vc3 = [[SMore alloc] init];
    
    SShopCar * vc4 = [[SShopCar alloc] init];
    vc4.tabBarItem.title = @"购物车";
    vc4.tabBarItem.image = [UIImage imageNamed:@"购物车默认"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"购物车选中"];
    
    SMine * vc5 = [[SMine alloc] init];
    vc5.tabBarItem.title = @"我的";
    vc5.tabBarItem.image = [UIImage imageNamed:@"我的默认"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"我的选中"];
    
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    self.itemImageScale = 0.6;
    self.tabBarBgColor = [UIColor blackColor];
    self.normalItemColor = [UIColor blackColor];
    self.selectedItemColor = [UIColor blackColor];
    self.itemFont = [UIFont systemFontOfSize:10];
    self.defaultSelectedIndex = 0;
    
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    
    //创建更多按钮及相关视图
    [self createMoreBtnView];
}

- (void)createMoreBtnView {
    moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = self.tabBar.subviews[1].frame;
    
    frame.size.width = ScreenW / 5.0;
    moreBtn.frame = frame;
    moreBtn.backgroundColor = [UIColor clearColor];
    [self.snTabBar.subviews[2] addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    moreBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake((moreBtn.frame.size.width - 25) / 2, 49 - 15 - 4 - 25, 25, 25)];
    [moreBtn addSubview:moreBtnImage];
    moreBtnImage.image = [UIImage imageNamed:@"更多选中"];
    
    moreBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49 - 15 -2, moreBtn.frame.size.width, 15)];
    [moreBtn addSubview:moreBtnLabel];
    moreBtnLabel.text = @"更多";
    moreBtnLabel.textColor = WordColor_sub_sub;
    moreBtnLabel.font = [UIFont systemFontOfSize:10];
    moreBtnLabel.textAlignment = NSTextAlignmentCenter;
    
    //创建更多按钮视图
    commonMoreView = [[NSBundle mainBundle] loadNibNamed:@"CommonMoreView" owner:self options:nil].firstObject;
    commonMoreView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TAB_BAR_HEIGHT);
    [self.view addSubview:commonMoreView];
    __weak typeof(self) moreSelf = self;
    commonMoreView.moreBtnBlock = ^(UIViewController *vc) {
        [moreSelf moreBtnEvent:(vc)];
    };
    commonMoreView.closeMoreView = ^{
        [moreSelf moreBtnClick];
    };
    commonMoreView.hidden = YES;
}
- (void)moreBtnClick {
    commonMoreView.hidden = !commonMoreView.isHidden;
    moreBtnImage.image = commonMoreView.isHidden ? [UIImage imageNamed:@"更多选中"] : [UIImage imageNamed:@"红色关闭"];
    moreBtnLabel.text = commonMoreView.isHidden ? @"更多" : @"关闭";
}
/**
 处理更多按钮view中的点击事件
 
 @param vc 要push的控制器
 */
- (void)moreBtnEvent:(UIViewController *)vc {
    if (vc == nil) return;
    if ([vc isMemberOfClass:[SWelfareAgency class]] && [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            //            [self showModel];
        };
        return;
    }
    [self moreBtnClick];
    [self.selectedViewController pushViewController:vc animated:YES];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    self.snTabBar.itemImageScale = self.itemImageScale;
    self.snTabBar.tabBarBgColor = self.tabBarBgColor;
    self.snTabBar.normalItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.snTabBar.selectedItemColor = [UIColor redColor];
    self.snTabBar.itemFont = self.itemFont;
    [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController * vc = obj;
        UIImage * normalImage = vc.tabBarItem.image;
        UIImage * selectedImage = vc.tabBarItem.selectedImage;
        NSString * title = vc.tabBarItem.title;
        [self.snTabBar sn_addNormalImage:normalImage selectedImage:selectedImage itemTitle:title];
        [self addChildViewController:vc];
        SNTabBarItem * tabBarItem = (SNTabBarItem *)[self.snTabBar viewWithTag:idx + kItemStartTag];
        tabBarItem.tabBarItem = vc.tabBarItem;
    }];
    self.snTabBar.defaultSelectedIndex = self.defaultSelectedIndex;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //清除原有的tabBarItem
    [self removeOriginControls];
    
}

- (void)removeOriginControls {
    for (id obj in self.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    //隐藏多按钮
    commonMoreView.hidden = NO;
    [self moreBtnClick];
    
    self.snTabBar.selectedItem.selected = NO;
    SNTabBarItem * tabBarItem = self.snTabBar.items[selectedIndex];
    tabBarItem.selected = YES;
    self.snTabBar.selectedItem = tabBarItem;
}

#pragma mark - SNTabBarDelegate
- (void)tabBar:(SNTabBar *)tabBar item:(SNTabBarItem *)tabBarItem selectedIndex:(NSInteger)index {
    self.selectedIndex = index;
}

@end
