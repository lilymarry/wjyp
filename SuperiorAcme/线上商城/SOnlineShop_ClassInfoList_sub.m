//
//  SOnlineShop_ClassInfoList_sub.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_ClassInfoList_sub.h"
#import "SOnlineShop_ClassView.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SGoodsInfor.h"
#import "SNPageView.h"
#import "STicketFight_NewContent.h"

#import "STicketBuyThreeList.h"//1
#import "SGroupBuyThreeList.h"//2
#import "SIntegralBuyThreeList.h"//3
#import "SPreBuyThreeList.h"//4
#import "SCountryThreeList.h"//5
#import "SGoodsThreeList.h"//7

#import "SGoodsInfor_first.h"



@interface SOnlineShop_ClassInfoList_sub ()
{
    STicketFight_NewContent * content;
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * three_cate_id;//三级分类id (如不填默认全部)
}

@property (nonatomic, copy) NSString *searchType;
@property (nonatomic, copy) NSString *para_order;
@property (nonatomic, copy) NSString *para_fliter;
@end

@implementation SOnlineShop_ClassInfoList_sub

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(content.mCollect, self);
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = _short_name;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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
    
    if ([_cate_type isEqualToString:@"1"]) {
        //票券区
        STicketBuyThreeList * list = [[STicketBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = @"";
        list.p = @"1";
        [list sTicketBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            STicketBuyThreeList * list = (STicketBuyThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (STicketBuyThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                
                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.goods_id = goods_id;
//                    info.goods_type = @"票券区";
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    //        info.goods_type = @"票券区";
                    info.goods_id = goods_id;
                    info.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"2"]) {
        //拼团购
        SGroupBuyThreeList * list = [[SGroupBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = @"";
        list.p = @"1";
        [list sGroupBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyThreeList * list = (SGroupBuyThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGroupBuyThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = @"拼单购";
                    info.a_id=a_id;
                    info.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"3"]) {
        //无界商店
        SIntegralBuyThreeList * list = [[SIntegralBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = @"";
        list.p = @"1";
        [list sIntegralBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyThreeList * list = (SIntegralBuyThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SIntegralBuyThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = @"无界商店";
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"4"]) {
        //无界预购
        SPreBuyThreeList * list = [[SPreBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = @"";
        list.p = @"1";
        [list sPreBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreBuyThreeList * list = (SPreBuyThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SPreBuyThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
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
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"5"]) {
        //进口馆
        SCountryThreeList * list = [[SCountryThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.country_id = _country_id;
        list.three_cate_id = @"";
        list.p = @"1";
        [list sCountryThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCountryThreeList * list = (SCountryThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SCountryThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
                    info.goods_id = goods_id;
                    info.goods_type = @"进口馆";
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
   
    if ([_cate_type isEqualToString:@"7"]||[_cate_type isEqualToString:@"10"]||[_cate_type isEqualToString:@"11"]) {
         MJWeakSelf;
        //6的子分类
        SGoodsThreeList * list = [[SGoodsThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = @"";
        list.p = @"1";
        if ([_cate_type isEqualToString:@"10"]) {
            list.is_active=@"5";
        }
        if ([_cate_type isEqualToString:@"11"]) {
            list.is_active=@"7";
        }
        [list sGoodsThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGoodsThreeList * list = (SGoodsThreeList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SGoodsThreeList * list_type  in list.data.three_cate_list) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.three_cate_id];
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
            if (_class_num != 0) {
                pageView.defaultSelectedIndex = _class_num;
                [pageView.topScrollView setContentOffset:CGPointMake((_class_num - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
            } else {
                pageView.defaultSelectedIndex = 0;
            }
            pageView.goundNormalColor = [UIColor whiteColor];
            pageView.topTitleViewColor = [UIColor whiteColor];
            __block SOnlineShop_ClassInfoList_sub * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }

                content = subView;
                page = 1;
                three_cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];
                    
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.overType = NULL;
                    info.hidesBottomBarWhenPushed = YES;
                    [gSelf.navigationController pushViewController:info animated:YES];
                };
                content.STicketFight_NewContent_ShowModelAgain = ^{
                    page = 1;
                    [gSelf initRefresh];
                    [gSelf showModel];
                };
                
                content.fliterViewBlock = ^(NSString *searchType, NSString *para_order, NSString *para_fliter) {
                    weakSelf.searchType = searchType;
                    weakSelf.para_fliter = para_fliter;
                    weakSelf.para_order = para_order;
                    [weakSelf showModel];
                };
            }];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
}

- (void)initRefresh
{
    __block SOnlineShop_ClassInfoList_sub * blockSelf = self;
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
    
    if ([_cate_type isEqualToString:@"1"]) {
        //票券区
        STicketBuyThreeList * list = [[STicketBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sTicketBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            STicketBuyThreeList * list = (STicketBuyThreeList *)data;
            
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
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"2"]) {
        //拼团购
        SGroupBuyThreeList * list = [[SGroupBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGroupBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            SGroupBuyThreeList * list = (SGroupBuyThreeList *)data;
            
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
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"3"]) {
        //无界商店
        SIntegralBuyThreeList * list = [[SIntegralBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyThreeList * list = (SIntegralBuyThreeList *)data;
            
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
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"4"]) {
        //无界预购
        SPreBuyThreeList * list = [[SPreBuyThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sPreBuyThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreBuyThreeList * list = (SPreBuyThreeList *)data;
            
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
            [content.mCollect reloadData];
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"5"]) {
        //进口馆
        SCountryThreeList * list = [[SCountryThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.country_id = _country_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sCountryThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCountryThreeList * list = (SCountryThreeList *)data;
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
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
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_cate_type isEqualToString:@"7"]||[_cate_type isEqualToString:@"10"]||[_cate_type isEqualToString:@"11"]) {
        //6的子分类
        SGoodsThreeList * list = [[SGoodsThreeList alloc] init];
        list.two_cate_id = _two_cate_id;
        list.three_cate_id = three_cate_id;
        list.p = [@(page) stringValue];
        list.searchType = _searchType;
        list.psort = _para_order;
        list.price = _para_fliter;
        
        if ([_cate_type isEqualToString:@"10"]) {
             list.is_active = @"5";
        }
        if ([_cate_type isEqualToString:@"11"]) {
            list.is_active = @"7";
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGoodsThreeListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGoodsThreeList * list = (SGoodsThreeList *)data;

            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
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
            [content showSevenModel:arr andMyType:_cate_type andCateType:@"7"];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
@end
