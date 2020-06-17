//
//  SLimited.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimited.h"
#import "SGoodsInfor_first.h"
#import "SNPageView.h"
#import "SLimited_NewContent.h"

#import "SLimitBuyLimitBuyIndex.h"
#import "SLimitBuyRemindMe.h"
//倒计时
#import "OYCountDownManager.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
@interface SLimited ()
{
    SLimited_NewContent * content;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * stage_id;//场次id (默认是当前时间所在场次)
}
@end

@implementation SLimited

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
    adjustsScrollViewInsets_NO(content.mCollect, self);

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"限量购";
    
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
    
    SLimitBuyLimitBuyIndex * list = [[SLimitBuyLimitBuyIndex alloc] init];
    list.stage_id = @"";
    list.p = @"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sLimitBuyLimitBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SLimitBuyLimitBuyIndex * list = (SLimitBuyLimitBuyIndex *)data;
        
        //类型name
        NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
        NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
        NSMutableArray * typeArr_status = [[NSMutableArray alloc] init];
        for (SLimitBuyLimitBuyIndex * list_type in list.data.stage_list) {
            [typeArr_name addObject:[NSString stringWithFormat:@"%@\n%@",list_type.start_time,list_type.status]];
            [typeArr_id addObject:list_type.stage_id];
            [typeArr_status addObject:list_type.status];
        }
        //类型class
        NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
        for (int i = 0; i < typeArr_name.count; i++) {
            [typeArr_class addObject:[SLimited_NewContent class]];
        }
        
        SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleSquareFill];
        pageView.subViews = typeArr_class;
        pageView.titles = typeArr_name;
        pageView.titleWidth = ScreenW/3;
        pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
        pageView.titleSelectedColor = [UIColor whiteColor];
        pageView.titleNormalColor = [UIColor whiteColor];
        pageView.sliderColor = [UIColor redColor];
        NSInteger nowIndex = 0;
        for (int i = 0; i < typeArr_status.count; i++) {
            if ([typeArr_status[i] hasSuffix:@"中"]) {
                nowIndex = i;
            }
        }
        pageView.defaultSelectedIndex = nowIndex;
        pageView.goundNormalColor = [UIColor clearColor];
        pageView.topTitleViewColor = WordColor;
        __block SLimited * gSelf = self;
        [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
            if (index > 1) {
                [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * ScreenW/3 - ScreenW/2/2 + ScreenW/3/1.3, 0) animated:YES];
            }
            
            content = subView;
            
            stage_id = typeArr_id[index];
            page = 1;
            [self initRefresh:typeArr_status[index]];
            [self showModel:typeArr_status[index]];
            
            
            
            content.SLimited_NewContent_showModel = ^{
                page = 1;
                [gSelf initRefresh:typeArr_status[index]];
                [gSelf showModel:typeArr_status[index]];
            };
            content.SLimited_NewContent_infor = ^(NSString *goods_id) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = goods_id;
                info.overType = @"限量购";
                info.hidesBottomBarWhenPushed = YES;
                [gSelf.navigationController pushViewController:info animated:YES];
              
            };
            content.SLimited_NewContent_set = ^(NSString *limit_buy_id) {
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置提醒?" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    SLimitBuyRemindMe * remindMe = [[SLimitBuyRemindMe alloc] init];
                    remindMe.limit_buy_id = limit_buy_id;
                    [MBProgressHUD showMessage:nil toView:gSelf.view];
                    [remindMe sLimitBuyRemindMeSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideAllHUDsForView:gSelf.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:gSelf.view];
                        } else {
                            [MBProgressHUD showError:message toView:gSelf.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideAllHUDsForView:gSelf.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                    }];
                }]];
                [gSelf presentViewController:alertController animated:YES completion:nil];
            };
            
        }];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

- (void)initRefresh:(NSString *)status
{
    __block SLimited * blockSelf = self;
    content.mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel:status];
        
    }];
    content.mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel:status];
    }];
}
- (void)showModel:(NSString *)status {
    SLimitBuyLimitBuyIndex * list = [[SLimitBuyLimitBuyIndex alloc] init];
    list.stage_id = stage_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sLimitBuyLimitBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SLimitBuyLimitBuyIndex * list = (SLimitBuyLimitBuyIndex *)data;
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.limitBuyList];
            [content.mCollect.mj_footer resetNoMoreData];
        } else {
            if (list.data.limitBuyList.count) {
                
                [arr addObjectsFromArray:list.data.limitBuyList];
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
        [adsArr addObject:dic];
        
        [content showModel:arr andBanner:adsArr andContent:status];
        
        content.SLimited_NewContent_bannerView = ^{
            if (![list.data.ads.merchant_id isEqualToString:@""] && ![list.data.ads.merchant_id  isEqualToString:@"0"]) {
                SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                infor.merchant_id = list.data.ads.merchant_id;
                infor.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:infor animated:YES];
                return;
            }
            if (![list.data.ads.goods_id isEqualToString:@""] && ![list.data.ads.goods_id isEqualToString:@"0"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = list.data.ads.goods_id;
                info.overType = NULL;
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
                return;
            }
            if (![list.data.ads.href isEqualToString:@""] && ![list.data.ads.href isEqualToString:@"0"]) {
                SMessageInfor * infor = [[SMessageInfor alloc] init];
                infor.type = @"广告链接";
                infor.code_Url = list.data.ads.href;
                infor.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:infor animated:YES];
                return;
            }
        };
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
