//
//  STicketFight.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STicketFight.h"
#import "SOnlineShop_ClassInfoList_sub.h"
#import "SFightGroups.h"
#import "SGoodsInfor.h"
#import "SNPageView.h"
#import "STicketFight_NewContent.h"

#import "SGroupBuyGroupBuyIndex.h"//拼团购
#import "SPreBuyPreBuyIndex.h"//无界预购
#import "STicketBuyTicketBuyIndex.h"//票券区
#import "SIntegralBuyIntegralBuyIndex.h"//无界商店
#import "SCountryCountryGoods.h"//国家馆
//倒计时
#import "OYCountDownManager.h"

#import "SGoodsInfor_first.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

#import "PDGUserProtcolView.h"
#import "SGoodsGoodsList.h"
@interface STicketFight ()
{
    STicketFight_NewContent * content;
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * cate_id;
    
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
    NSArray *contryArr;
    NSMutableArray * adsArr;
    
    
}
@property (strong, nonatomic) IBOutlet UIView *mClassView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation STicketFight

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    // 启动倒计时管理
    [kCountDownManager start];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_type isEqualToString:@"1"]) {
        self.title = @"票券区";
    } else if ([_type isEqualToString:@"2"]) {
        self.title = @"拼单购";
    } else if ([_type isEqualToString:@"4"]) {
        self.title = @"无界预购";
    } else if ([_type isEqualToString:@"5"]) {
        self.title = _country_name;
    } else if ([_type isEqualToString:@"3"]) {
        self.title = @"积分商店";
    }else if ([_type isEqualToString:@"11"]) {
        self.title = @"互清库存";
    }
    else{
         self.title = @"爆款专区";
    }
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    /*
     *拼单购时,发出通知,用于停止文字滚动的动画,否则会出现CPU占用率剧增的问题
     */
    if ([_type isEqualToString:@"2"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupGoodListNoticeAnimatStatus" object:nil userInfo:@{@"GroupGoodListNoticeAnimatStatus":@0}];
    }

}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI {
    __block STicketFight * gSelf = self;
    [MBProgressHUD showMessage:nil toView:self.view];
    if ([_type isEqualToString:@"1"]) {
        //票券区
        STicketBuyTicketBuyIndex * list = [[STicketBuyTicketBuyIndex alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        [list sTicketBuyTicketBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            STicketBuyTicketBuyIndex * list = (STicketBuyTicketBuyIndex *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGroupBuyGroupBuyIndex * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
//                if (index == 0) {
//                    [gSelf.navigationController popViewControllerAnimated:YES];
//                } else {
//
//                }
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    //                        SGoodsInfor * info = [[SGoodsInfor alloc] init];
                    //                        info.goods_id = goods_id;
                    //                        info.goods_type = @"票券区";
                    //                        info.hidesBottomBarWhenPushed = YES;
                    //                        [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                       //   info.goods_type = @"票券区";
                    info.goods_id = goods_id;
                    info.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"2"]) {
        //拼团购
        SGroupBuyGroupBuyIndex * list = [[SGroupBuyGroupBuyIndex alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        [list sGroupBuyGroupBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyGroupBuyIndex * list = (SGroupBuyGroupBuyIndex *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGroupBuyGroupBuyIndex * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
//                if (index == 0) {
//                    [gSelf.navigationController popViewControllerAnimated:YES];
//                } else {
//
//                }
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = @"拼单购";
                    info.a_id=a_id;
                    info.hidesBottomBarWhenPushed = YES;
                    info.PopGoodsInforBlock = ^{
                      //发出通知,开始通知消息的轮播
                        /*
                         *从拼单购商品详情页返回时,开启通知消息的滚动动画
                         */
                        if ([_type isEqualToString:@"2"]) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupGoodListNoticeAnimatStatus" object:nil userInfo:@{@"GroupGoodListNoticeAnimatStatus":@1}];
                        }
                    };
                    [self.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"3"]) {
        //无界商店
        SIntegralBuyIntegralBuyIndex * list = [[SIntegralBuyIntegralBuyIndex alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        [list sIntegralBuyIntegralBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyIntegralBuyIndex * list = (SIntegralBuyIntegralBuyIndex *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGroupBuyGroupBuyIndex * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
//                if (index == 0) {
//                    [gSelf.navigationController popViewControllerAnimated:YES];
//                } else {
//
//                }
//
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.goods_type = @"无界商店";
//                    info.goods_id = goods_id;
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = @"无界商店";
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"4"]) {
        //无界预购
        SPreBuyPreBuyIndex * list = [[SPreBuyPreBuyIndex alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        [list sPreBuyPreBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreBuyPreBuyIndex * list = (SPreBuyPreBuyIndex *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SPreBuyPreBuyIndex * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                
//                if (index == 0) {
//                    [gSelf.navigationController popViewControllerAnimated:YES];
//                } else {
//                    
//                }
//
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.goods_id = goods_id;
//                    info.goods_type = @"无界预购";
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = @"无界预购";
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"5"]) {
        //国家馆
        SCountryCountryGoods * list = [[SCountryCountryGoods alloc] init];
        list.cate_id = @"";
        list.country_id = _country_id;
        list.p = @"1";
        [list sCountryCountryGoodsSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCountryCountryGoods * list = (SCountryCountryGoods *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SPreBuyPreBuyIndex * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                
//                if (index == 0) {
//                    [gSelf.navigationController popViewControllerAnimated:YES];
//                } else {
//
//                }
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    class_sub.country_id = _country_id;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.goods_id = goods_id;
//                    info.goods_type = @"进口馆";
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = NULL;
                    info.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    if ([_type isEqualToString:@"10"]) {
        //爆款专区
        SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        list.is_active=@"5";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGoodsGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SGoodsGoodsList * list = (SGoodsGoodsList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGoodsGoodsList * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                //                if (index == 0) {
                //                    [gSelf.navigationController popViewControllerAnimated:YES];
                //                } else {
                //
                //                }
                //
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    //                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
                    //                    info.goods_type = @"无界商店";
                    //                    info.goods_id = goods_id;
                    //                    info.hidesBottomBarWhenPushed = YES;
                    //                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = NULL;
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
            
            
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"11"]) {
        //互清库存
        SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        list.is_active=@"7";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGoodsGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SGoodsGoodsList * list = (SGoodsGoodsList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGoodsGoodsList * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[STicketFight_NewContent class]];
            }
            
            SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                //                if (index == 0) {
                //                    [gSelf.navigationController popViewControllerAnimated:YES];
                //                } else {
                //
                //                }
                //
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = _type;
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    //                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
                    //                    info.goods_type = @"无界商店";
                    //                    info.goods_id = goods_id;
                    //                    info.hidesBottomBarWhenPushed = YES;
                    //                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = NULL;
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                
                content.STicketFight_NewContent_bannerView = ^{
                    if (![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
                        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                        infor.merchant_id = url_merchant_id;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                    if (![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
                        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                        info.goods_id = url_goods_id;
                        info.overType = NULL;
                        info.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:info animated:YES];
                        return;
                    }
                    if (![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
                        SMessageInfor * infor = [[SMessageInfor alloc] init];
                        infor.type = @"广告链接";
                        infor.code_Url = url_href;
                        infor.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                };
                
            }];
            
            
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}

- (void)initRefresh
{
    __block STicketFight * blockSelf = self;
    content.mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    content.mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    
    if ([_type isEqualToString:@"1"]) {
        //票券区
        STicketBuyTicketBuyIndex * list = [[STicketBuyTicketBuyIndex alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sTicketBuyTicketBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            STicketBuyTicketBuyIndex * list = (STicketBuyTicketBuyIndex *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.ticket_buy_list];
                [content.mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.ticket_buy_list.count) {
                    
                    [arr addObjectsFromArray:list.data.ticket_buy_list];
                    [content.mCollect.mj_footer endRefreshing];
                } else {
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:list.data.ads.picture forKey:@"picture"];
            url_merchant_id = list.data.ads.merchant_id;
            url_goods_id = list.data.ads.goods_id;
            url_href = list.data.ads.href;
            [adsArr addObject:dic];
            [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"2"]) {
        //拼团购
        SGroupBuyGroupBuyIndex * list = [[SGroupBuyGroupBuyIndex alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGroupBuyGroupBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyGroupBuyIndex * list = (SGroupBuyGroupBuyIndex *)data;
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.group_buy_list];
                [content.mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.group_buy_list.count) {
                    
                    [arr addObjectsFromArray:list.data.group_buy_list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:list.data.ads.picture forKey:@"picture"];
            url_merchant_id = list.data.ads.merchant_id;
            url_goods_id = list.data.ads.goods_id;
            url_href = list.data.ads.href;
            [adsArr addObject:dic];
            
            /*
             *滚动通知消息数据的拼接
             */
            NSMutableArray * noticeTempArr = [NSMutableArray array];
            for (SGroupBuyGroupBuyIndex * noticeModel in list.data.group_buy_msg) {
                [noticeTempArr addObject:noticeModel.msg];
            }
            content.noticeArr = [noticeTempArr copy];
            [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
           
#pragma mark - 将协议倒计时展示出来
            if ([list.data.is_show_group_buy_rule isEqualToString:@"1"] && (page == 1)) {
                [self showUserProtcolMethod:list.data.group_buy_rule];
            }
            
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"3"]) {
        //无界预购
        SIntegralBuyIntegralBuyIndex * list = [[SIntegralBuyIntegralBuyIndex alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralBuyIntegralBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyIntegralBuyIndex * list = (SIntegralBuyIntegralBuyIndex *)data;
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.integral_buy_list];
                [content.mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.integral_buy_list.count) {
                    
                    [arr addObjectsFromArray:list.data.integral_buy_list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:list.data.ads.picture forKey:@"picture"];
            url_merchant_id = list.data.ads.merchant_id;
            url_goods_id = list.data.ads.goods_id;
            url_href = list.data.ads.href;
            [adsArr addObject:dic];
            [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"4"]) {
        //无界预购
        SPreBuyPreBuyIndex * list = [[SPreBuyPreBuyIndex alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sPreBuyPreBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreBuyPreBuyIndex * list = (SPreBuyPreBuyIndex *)data;
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.pre_buy_list];
                [content.mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.pre_buy_list.count) {
                    
                    [arr addObjectsFromArray:list.data.pre_buy_list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            //倒计时
            [kCountDownManager reload];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:list.data.ads.picture forKey:@"picture"];
            url_merchant_id = list.data.ads.merchant_id;
            url_goods_id = list.data.ads.goods_id;
            url_href = list.data.ads.href;
            [adsArr addObject:dic];
            [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"5"]) {
        //国家馆
        SCountryCountryGoods * list = [[SCountryCountryGoods alloc] init];
        list.cate_id = cate_id;
        list.country_id = _country_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sCountryCountryGoodsSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCountryCountryGoods * list = (SCountryCountryGoods *)data;
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
                contryArr=[NSArray arrayWithArray:list.data.two_cate_list];
                adsArr = [[NSMutableArray alloc] init];
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                [dic setObject:list.data.ads.picture forKey:@"picture"];
                [adsArr addObject:dic];
                [content.mCollect.mj_footer resetNoMoreData];
                
            } else {
                if (list.data.list.count) {
                    
                    [arr addObjectsFromArray:list.data.list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
           
            url_merchant_id = list.data.ads.merchant_id;
            url_goods_id = list.data.ads.goods_id;
            url_href = list.data.ads.href;
          
            [content showModel:arr andTwo_cate_list:contryArr andBanner:adsArr andMyType:_type];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    if ([_type isEqualToString:@"10"]) {
        
        SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        list.is_active=@"5";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGoodsGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGoodsGoodsList * list = (SGoodsGoodsList *)data;
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
                [content.mCollect.mj_footer resetNoMoreData];
                    url_merchant_id = list.data.ads.merchant_id;
                   url_goods_id = list.data.ads.goods_id;
                  url_href = list.data.ads.href;
                
            } else {
                if (list.data.list.count) {
                    
                    [arr addObjectsFromArray:list.data.list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
          //  NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            if (list!=nil) {
                if (list.data.ads.picture != nil) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:list.data.ads.picture forKey:@"picture"];
                    [adsArr addObject:dic];
                    
                [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
                }
             
            }
        
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"11"]) {
        
        SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        list.is_active=@"7";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGoodsGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGoodsGoodsList * list = (SGoodsGoodsList *)data;
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
                [content.mCollect.mj_footer resetNoMoreData];
                url_merchant_id = list.data.ads.merchant_id;
                url_goods_id = list.data.ads.goods_id;
                url_href = list.data.ads.href;
                
            } else {
                if (list.data.list.count) {
                    
                    [arr addObjectsFromArray:list.data.list];
                    [content.mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mCollect.mj_header endRefreshing];
            [content.mCollect reloadData];
            
            NSMutableArray * adsArr = [[NSMutableArray alloc] init];
            //  NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            if (list!=nil) {
                if (list.data.ads.picture != nil) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:list.data.ads.picture forKey:@"picture"];
                    [adsArr addObject:dic];
                    
                    [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:_type];
                }
                
            }
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}

-(void)showUserProtcolMethod:(id)data{
//    if(!SWNOTEmptyArr(data)){
//        return;
//    }
  PDGUserProtcolView *pdgView = [PDGUserProtcolView instancePDGProtcolView];
    [pdgView configerData:data];
    [self.view addSubview:pdgView];
    pdgView.frame = self.view.bounds;
    //点击确定后的回调
    pdgView.block = ^{
        //sGroupBuyRuleSuccess
        [SGroupBuyGroupBuyIndex sGroupBuyRuleSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            if ([code isEqualToString:@"1"]) {
                NSLog(@"---%@",message);
            }
        } andFailure:^(NSError *error) {
            
        }];
    };
}


@end
