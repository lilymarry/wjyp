//
//  SLineShop_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/28.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT ScreenW/69*26 - 64 - 64

#import "SLineShop_infor.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SLineShop_infor_Top.h"
#import "SLineShop_infor_leftCell.h"
#import "SLineShop_infor_rightCell.h"
#import "SSearch.h"
#import "AShare.h"
#import "SLineShop_inforSub.h"
#import "SLineShop_infor_rightTop.h"
#import "SLineShop_infor_CouponView.h"
#import "SGoodsInfor.h"
#import "SShopCar.h"
#import "SOrderConfirm.h"

#import "SNPageView.h"
#import "SLineShop_infor_Left.h"
#import "SLineShop_infor_Right.h"
#import "SLineShop_infor_Left_subContent.h"

@interface SLineShop_infor () <UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIButton * rightBtn_sub;
    BOOL collect_isno;//NO未收藏 YES已收藏
    SLineShop_infor_Left * leftContent;
    SLineShop_infor_Right * rightContent;
}

@property (strong, nonatomic) IBOutlet UIScrollView *thisNewScoll;
@property (strong, nonatomic) IBOutlet UIView *thisNewScoll_ContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisNewScoll_ContentView_HHH;
@property (strong, nonatomic) IBOutlet UIButton *noticeBtn;//公告
@property (strong, nonatomic) IBOutlet UILabel *topTime;
@property (strong, nonatomic) IBOutlet UILabel *topPrice;
@property (strong, nonatomic) IBOutlet UILabel *topDistance;
@property (strong, nonatomic) IBOutlet UIButton *topShopBtn;
@property (strong, nonatomic) IBOutlet UIView *topSearchView;
@property (strong, nonatomic) IBOutlet UIButton *topSearchBtn;
@end

@implementation SLineShop_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _thisNewScoll_ContentView_HHH.constant = ScreenW/69*26 - 64 + ScreenH;
    _thisNewScoll.delegate = self;
    _topTime.layer.masksToBounds = YES;
    _topTime.layer.cornerRadius = 12.5;
    
    _topPrice.layer.masksToBounds = YES;
    _topPrice.layer.cornerRadius = 12.5;
    
    _topShopBtn.layer.masksToBounds = YES;
    _topShopBtn.layer.cornerRadius = 3;
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"距您4.5km"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
    _topDistance.attributedText = AttributedStr;
    
    _topSearchView.layer.masksToBounds = YES;
    _topSearchView.layer.cornerRadius = 3;
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, ScreenW/69*26 + 50, ScreenW, ScreenH - 64 - 50) p_style:PageViewStyleLine];
    pageView.subViews = @[[SLineShop_infor_Left class],[SLineShop_infor_Right class]];
    pageView.titles = @[@"流转商品",@"自营商品"];
    pageView.titleWidth = ScreenW/2;
    pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.customTag = 200;
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SLineShop_infor * gSelf = self;
    [pageView showInView:_thisNewScoll_ContentView action:^(id subView, UIButton *btn, NSInteger index) {
        if (index == 0) {
            //流转商品
            leftContent = subView;
            leftContent.SLineShop_infor_Left_ScollDelegate = ^(CGFloat y) {
                if (y > 0) {
                    [_thisNewScoll setContentOffset:CGPointMake(0, ScreenW/69*26 - 64) animated:NO];
                }
            };
            //优惠券
            leftContent.SLineShop_infor_Left_showR = ^{
                [gSelf couponBtnClick];
            };
            //商品详情
            leftContent.SLineShop_infor_Left_infor = ^(NSString *goods_id) {
                SGoodsInfor * info = [[SGoodsInfor alloc] init];
                info.hidesBottomBarWhenPushed = YES;
                [gSelf.navigationController pushViewController:info animated:YES];
            };
        }
        if (index == 1) {
            //自营商品
            rightContent = subView;
            rightContent.SLineShop_infor_Right_ScrollDelegate = ^(CGFloat y) {
                if (y > 0) {
                    [_thisNewScoll setContentOffset:CGPointMake(0, ScreenW/69*26 - 64) animated:NO];
                }
            };
            rightContent.SLineShop_infor_Right_goCar = ^{
                SShopCar * shopCar = [[SShopCar alloc] init];
                shopCar.type = YES;
                [gSelf.navigationController pushViewController:shopCar animated:YES];
            };
            rightContent.SLineShop_infor_Right_Submit = ^{
                SOrderConfirm * con = [[SOrderConfirm alloc] init];
                con.hidesBottomBarWhenPushed = YES;
                [gSelf.navigationController pushViewController:con animated:YES];
            };
            rightContent.SLineShop_infor_Right_coupon = ^{
                [gSelf couponBtnClick];
            };
        }
    }];
    
    

    //公告
    [_noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //搜索
    [_topSearchBtn addTarget:self action:@selector(topSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //店铺信息
    [_topShopBtn addTarget:self action:@selector(topShopBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_thisNewScoll, self);

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白

    [self scrollViewDidScroll:_thisNewScoll];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //                home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
        
        self.title = @"好收成超市";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    } else {
        self.title = @"";
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"白色分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    
    [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
    rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn_sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    collect_isno = NO;//默认没有收藏
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer,rightBtnItem,rightBtnItem_sub];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 分享
- (void)rightBtnClick {
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    backGroundView.backgroundColor = WordColor_sub_sub_sub;
//    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [self.view addSubview:view];
    
    AShare * shareVC = [[AShare alloc] init];
//    shareVC.thisUrl = share_url;
//    shareVC.thisImage = share_img;
//    shareVC.thisTitle = share_title;
//    shareVC.thisContent = _shareContentTV.text;
//    shareVC.thisType = @"2";
//    shareVC.id_val = share_id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
//        [backGroundView removeFromSuperview];
//        [view removeFromSuperview];
    };
}
#pragma mark - 收藏
- (void)rightBtn_subClick {
    if (collect_isno == NO) {
        [rightBtn_sub setImage:[UIImage imageNamed:@"黄色桃心"] forState:UIControlStateNormal];
        [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
        
        collect_isno = YES;
    } else {
        [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
        [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
        
        collect_isno = NO;
    }
}

#pragma mark - 公告
- (void)noticeBtnClick {
    SLineShop_infor_CouponView * coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
    coup.thisTitle.text = @"活动公告";
    [coup showNotice:@"线下商城公告内容"];
    coup.SLineShop_infor_CouponView_Back = ^{
        [coup removeFromSuperview];
    };
}
#pragma mark - 店铺信息
- (void)topShopBtnClick {
    SLineShop_inforSub * inforSub = [[SLineShop_inforSub alloc] init];
    [self.navigationController pushViewController:inforSub animated:YES];
}
#pragma mark - 店内搜索
- (void)topSearchBtnClick  {
    SSearch * search = [[SSearch alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark - 优惠券
- (void)couponBtnClick {
    SLineShop_infor_CouponView * coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
    coup.SLineShop_infor_CouponView_Back = ^{
        [coup removeFromSuperview];
    };
}

@end
