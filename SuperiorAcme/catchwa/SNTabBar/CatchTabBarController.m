//
//  SNTabBarController.m
//  SNTabBarVC
//
//  Created by wangsen on 16/3/26.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "CatchTabBarController.h"
#import "SNTabBarConst.h"
#import "SNTabBar.h"
#import "SNTabBarItem.h"

#import "WAFirstView.h"
#import "WAMine.h"
#import "WAMoney.h"

#import "SuperiorAcme_Url.h"
#import "WAMineFriend.h"
/*
 *添加自定义的TabBar,并替换TabBarController中自带的TabBar
 */
#import "SNVersionOneTabBar.h"

@interface CatchTabBarController () <SNTabBarDelegate>
@property (nonatomic, strong) SNTabBar * snTabBar;
@end

@implementation CatchTabBarController
{
    
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
    WAFirstView * vc1 = [[WAFirstView alloc] init];
    vc1.tabBarItem.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"首页未选中"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"首页选中"];
    
    WAMineFriend * vc2 = [[WAMineFriend alloc] init];
    vc2.type=@"1";
    vc2.tabBarItem.title = @"分享";
    vc2.tabBarItem.image = [UIImage imageNamed:@"发现未选中"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"发现选中"];

    WAMoney * vc4 = [[WAMoney alloc] init];

    
    WAMine * vc5 = [[WAMine alloc] init];
    vc5.tabBarItem.title = @"我的";
    vc5.tabBarItem.image = [UIImage imageNamed:@"c我的未选中"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"c我的选中"];
    
    
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [nav1.navigationBar setBarTintColor:navigationColor];
    nav1.navigationBar.tintColor = [UIColor whiteColor];
    nav1.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [nav2.navigationBar setBarTintColor:navigationColor];
    nav2.navigationBar.tintColor = [UIColor whiteColor];
    nav2.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    [nav5.navigationBar setBarTintColor:navigationColor];
    nav5.navigationBar.tintColor = [UIColor whiteColor];
    nav5.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self presentViewController:nav5 animated:YES completion:nil];
    
    self.itemImageScale = 0.6;
    self.tabBarBgColor = [UIColor blackColor];
    self.normalItemColor = [UIColor blackColor];
    self.selectedItemColor = [UIColor blackColor];
    self.itemFont = [UIFont systemFontOfSize:10];
    self.defaultSelectedIndex = 0;
    
    self.viewControllers = @[nav1,nav2,nav4,nav5];
    [self createMoreBtnView];
}
- (void)createMoreBtnView {
    moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = self.tabBar.subviews[1].frame;
    
    frame.size.width = ScreenW / 4.0;
    moreBtn.frame = frame;
    moreBtn.backgroundColor = [UIColor clearColor];
    [self.snTabBar.subviews[2] addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    moreBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake((moreBtn.frame.size.width - 25) / 2, 49 - 15 - 4 - 25, 25, 25)];
    [moreBtn addSubview:moreBtnImage];
    moreBtnImage.image = [UIImage imageNamed:@"银两未选中"];
    
    moreBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49 - 15 -2, moreBtn.frame.size.width, 15)];
    [moreBtn addSubview:moreBtnLabel];
    moreBtnLabel.text = @"银两";
    moreBtnLabel.textColor = WordColor_sub_sub;
    moreBtnLabel.font = [UIFont systemFontOfSize:10];
    moreBtnLabel.textAlignment = NSTextAlignmentCenter;
    
    //    //创建更多按钮视图
    //    commonMoreView = [[NSBundle mainBundle] loadNibNamed:@"CommonMoreView" owner:self options:nil].firstObject;
    //    commonMoreView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TAB_BAR_HEIGHT);
    //    [self.view addSubview:commonMoreView];
    //    __weak typeof(self) moreSelf = self;
    //    commonMoreView.moreBtnBlock = ^(UIViewController *vc) {
    //        [moreSelf moreBtnEvent:(vc)];
    //    };
    //    commonMoreView.closeMoreView = ^{
    //        [moreSelf moreBtnClick];
    //    };
    //    commonMoreView.hidden = YES;
}
- (void)moreBtnClick {
    //    commonMoreView.hidden = !commonMoreView.isHidden;
    //    moreBtnImage.image = commonMoreView.isHidden ? [UIImage imageNamed:@"更多选中"] : [UIImage imageNamed:@"红色关闭"];
    //    moreBtnLabel.text = commonMoreView.isHidden ? @"更多" : @"关闭";
    
    WAMoney * vc4 = [[WAMoney alloc] init];
    vc4.presentingView=YES;
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    [nav4.navigationBar setBarTintColor:navigationColor];
    nav4.navigationBar.tintColor = [UIColor whiteColor];
    nav4.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self presentViewController:nav4 animated:YES completion:nil];
}
/**
 处理更多按钮view中的点击事件
 
 @param vc 要push的控制器
 */
- (void)moreBtnEvent:(UIViewController *)vc {
    if (vc == nil) return;
    //    if ([vc isMemberOfClass:[SWelfareAgency class]] && [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
    //        SLand * land = [[SLand alloc] init];
    //        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
    //        land.modalPresent = YES;
    //        [self presentViewController:landNav animated:YES completion:nil];
    //        land.SLand_showModel = ^{
    //            //            [self showModel];
    //        };
    //        return;
    //    }
    [self moreBtnClick];
    [self.selectedViewController pushViewController:vc animated:YES];
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    self.snTabBar.itemImageScale = self.itemImageScale;
    self.snTabBar.tabBarBgColor = self.tabBarBgColor;
    self.snTabBar.normalItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.snTabBar.selectedItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    //   self.snTabBar.selectedItemColor = [UIColor colorWithRed:255/255.0 green:66/255.0 blue:158/255.0 alpha:1.0];
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
