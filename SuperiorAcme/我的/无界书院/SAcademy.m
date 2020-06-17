//
//  SAcademy.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAcademy.h"
#import "SNPageView.h"
#import "SAcademy_NewContent.h"

#import "SAcademyAcademyIndex.h"
#import "SMessageInfor.h"
#import "SOnlineShopInfor.h"

@interface SAcademy ()
{
    SAcademy_NewContent * content;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * ac_type_id;//分类ID 若不写默认显示推荐文章
}
@end

@implementation SAcademy

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
    
    SAcademyAcademyIndex * list = [[SAcademyAcademyIndex alloc] init];
    list.ac_type_id = @"";
    list.p = @"1";
    [list sAcademyAcademyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SAcademyAcademyIndex * list = (SAcademyAcademyIndex *)data;
        
        
        SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
        //类型name
        NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
        NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
        for (SAcademyAcademyIndex * list_type in list.data.ac_type_list) {
            [typeArr_name addObject:list_type.type_name];
            [typeArr_id addObject:list_type.type_id];
        }
        //类型class
        NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
        for (int i = 0; i < typeArr_name.count; i++) {
            [typeArr_class addObject:[SAcademy_NewContent class]];
        }
        pageView.subViews = typeArr_class;
        pageView.titles = typeArr_name;
        pageView.titleWidth = 100;
        pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
        pageView.sliderColor = WordColor;
        pageView.defaultSelectedIndex = 0;
        pageView.topTitleViewColor = [UIColor whiteColor];
        pageView.goundNormalColor = [UIColor whiteColor];
        pageView.customTag = 100;
        __block SAcademy * gSelf = self;
        [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
            if (index > 1) {
                [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
            }
            content = subView;
            page = 1;
            ac_type_id = typeArr_id[index];
            [gSelf initRefresh];
            [gSelf showModel];
            content.SAcademy_NewContent_ShowModelAgain = ^{
                page = 1;
                ac_type_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
            };
            content.SAcademy_NewContent_infor = ^(NSString *academy_id) {
                SMessageInfor * info = [[SMessageInfor alloc] init];
                info.academy_id = academy_id;
                [gSelf.navigationController pushViewController:info animated:YES];
            };
        }];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)initRefresh
{
    __block SAcademy * blockSelf = self;
    content.mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    content.mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    SAcademyAcademyIndex * list = [[SAcademyAcademyIndex alloc] init];
    list.ac_type_id = ac_type_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sAcademyAcademyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SAcademyAcademyIndex * list = (SAcademyAcademyIndex *)data;
        
        
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.academy_list];
            [content.mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.academy_list.count) {
                
                [arr addObjectsFromArray:list.data.academy_list];
                [content.mTable.mj_footer endRefreshing];
                
            } else {
                
                [content.mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [content.mTable.mj_header endRefreshing];
        [content.mTable reloadData];
        [content showModel:arr andBanner:list.data.bannerList];
        
        content.SAcademy_NewContent_bannerView = ^{
            SAcademyAcademyIndex * list_banner = list.data.bannerList.firstObject;
            if (![list_banner.merchant_id isEqualToString:@""] && ![list_banner.merchant_id  isEqualToString:@"0"]) {
                SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                infor.merchant_id = list_banner.merchant_id;
                infor.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:infor animated:YES];
                return;
            }
            if (![list_banner.goods_id isEqualToString:@""] && ![list_banner.goods_id isEqualToString:@"0"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = list_banner.goods_id;
                info.overType = NULL;
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
                return;
            }
            if (![list_banner.href isEqualToString:@""] && ![list_banner.href isEqualToString:@"0"]) {
                SMessageInfor * infor = [[SMessageInfor alloc] init];
                infor.type = @"广告链接";
                infor.code_Url = list_banner.href;
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(content.mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"无界书院";
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


@end
