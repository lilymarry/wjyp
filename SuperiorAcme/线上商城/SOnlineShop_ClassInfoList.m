//
//  SOnlineShop_ClassInfoList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_ClassInfoList.h"
#import "SOnlineShop_seachView.h"
#import "SOnlineShop_InfoListView.h"
#import "SOnlineShopCell.h"
#import "SOnlineShop_ClassView.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShop_ClassInfoList_sub.h"
#import "SOnlineShop_ClassInfoList_more.h"
#import "SSearch.h"
#import "SMessage.h"
#import "SNBannerView.h"
#import "SGoodsInfor.h"
#import "SNPageView.h"
#import "STicketFight_NewContent.h"

#import "SGoodsGoodsList.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
#import "SIndexIndex.h"

@interface SOnlineShop_ClassInfoList () <EMChatManagerDelegate>
{
    SOnlineShop_seachView * searchView;
    SOnlineShop_InfoListView * top;
    STicketFight_NewContent * content;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * cate_id;
    
    UILabel * mess_count;
}

/*
 *添加判断是否允许keyWindow添加mess_count的状态属性
 */
@property (nonatomic, assign) BOOL isAddMess_count;

/*
 *保存广告图片的数组
 */
@property (nonatomic, strong) NSMutableArray * adsArr;


@end

@implementation SOnlineShop_ClassInfoList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    cate_id = _model_cate_id;

    [self createNav];
    [self createUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     *当当前控制器的视图将要显示的时候,允许keyWindow添加mess_count
     */
    _isAddMess_count = YES;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(content.mCollect, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
    
}
- (void)viewDidAppear:(BOOL)animated {
    //获取当前未读消息数
    [mess_count removeFromSuperview];
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        
        [mess_count removeFromSuperview];
        SIndexIndex * list = (SIndexIndex *)data;
        
        /*//旧代码
        if ([list.data.msg_tip integerValue] != 0 && ![list.data.msg_tip isEqualToString:@""]) {
            if (ScreenW > 375) {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45, STATUS_BAR_HEIGHT, 15, 15)];
            } else {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
            }
            EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
            [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
            mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + [conversation unreadMessagesCount]];
            mess_count.font = [UIFont systemFontOfSize:10];
            mess_count.textColor = [UIColor whiteColor];
            mess_count.backgroundColor = [UIColor orangeColor];
            mess_count.textAlignment = NSTextAlignmentCenter;
            mess_count.layer.masksToBounds = YES;
            mess_count.layer.cornerRadius = 7.5;
            [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
        }
         */
        
        /*
         *根据"_isAddMess_count"的状态,来判断是否允许keyWindow添加mess_count
         */
        if (_isAddMess_count) {
            if ([list.data.msg_tip integerValue] != 0 && ![list.data.msg_tip isEqualToString:@""]) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
                }
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
                [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + [conversation unreadMessagesCount]];
                mess_count.font = [UIFont systemFontOfSize:10];
                mess_count.textColor = [UIColor whiteColor];
                mess_count.backgroundColor = [UIColor orangeColor];
                mess_count.textAlignment = NSTextAlignmentCenter;
                mess_count.layer.masksToBounds = YES;
                mess_count.layer.cornerRadius = 7.5;
                [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
            }
        }
        
        
    } andFailure:^(NSError *error) {
    }];
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    [self viewDidAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *当当前控制器的视图将要"不显示"的时候,不允许keyWindow添加mess_count
     */
    _isAddMess_count = NO;
    
    [self.navigationController.navigationBar lt_reset];
    [mess_count removeFromSuperview];
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"消息黑色"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"消息" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    searchView = [[SOnlineShop_seachView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 3;
    self.navigationItem.titleView = searchView;
    searchView.groundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchView.searchTitle.textColor = WordColor;
    searchView.thisImage.image = [UIImage imageNamed:@"黑色放大镜"];
    [searchView.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 搜索
- (void)searchBtnClick{
    SSearch * search = [[SSearch alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 消息
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self showModel];
        };
        return;
    }
    SMessage * mess = [[SMessage alloc] init];
    [self.navigationController pushViewController:mess animated:YES];
}
- (void)createUI {
    
    SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
    list.cate_id = cate_id;
    list.p = @"1";
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
        pageView.titles = typeArr_name;
        pageView.subViews = typeArr_class;
        pageView.titleWidth = 100;
        pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
        pageView.sliderColor = WordColor;
        pageView.defaultSelectedIndex = _indexPath;
        [pageView.topScrollView setContentOffset:CGPointMake( (_indexPath - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
        pageView.topTitleViewColor = [UIColor whiteColor];
        pageView.goundNormalColor = [UIColor whiteColor];
        __block SOnlineShop_ClassInfoList * gSelf = self;
        [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

//            if (index == 0) {
//                [gSelf.navigationController popViewControllerAnimated:YES];
//            } else {

                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                
                content.STicketFight_NewContent_class = ^(NSString *two_cate_id, NSString *short_name) {
                    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
                    class_sub.cate_type = @"7";
                    class_sub.two_cate_id = two_cate_id;
                    class_sub.short_name = short_name;
                    [gSelf.navigationController pushViewController:class_sub animated:YES];
                };
                content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                    
                    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                    info.goods_id = goods_id;
                    info.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:info animated:YES];
                    
//                    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//                    info.goods_type = @"商品详情";
//                    info.goods_id = goods_id;
//                    info.hidesBottomBarWhenPushed = YES;
//                    [gSelf.navigationController pushViewController:info animated:YES];

                };
//            }
            
        }];
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    

}

- (void)initRefresh
{
    __block SOnlineShop_ClassInfoList * blockSelf = self;
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
    SGoodsGoodsList * list = [[SGoodsGoodsList alloc] init];
    list.cate_id = cate_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sGoodsGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SGoodsGoodsList * list = (SGoodsGoodsList *)data;
        
//        NSMutableArray * adsArr = [[NSMutableArray alloc] init];
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:list.data.ads.picture forKey:@"picture"];
//        [adsArr addObject:dic];

        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.list];
            [content.mCollect.mj_footer resetNoMoreData];
            
            
            /*
             *设置二级分类和广告的数据展示
             */
            [self SetDataForContentViewWithData:list];
            
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
//        [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:adsArr andMyType:@"6"];
//        content.STicketFight_NewContent_bannerView = ^{
//            if (![list.data.ads.merchant_id isEqualToString:@""] && ![list.data.ads.merchant_id  isEqualToString:@"0"]) {
//                SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
//                infor.merchant_id = list.data.ads.merchant_id;
//                infor.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:infor animated:YES];
//                return;
//            }
//            if (![list.data.ads.goods_id isEqualToString:@""] && ![list.data.ads.goods_id isEqualToString:@"0"]) {
//                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
//                info.goods_id = list.data.ads.goods_id;
//                info.overType = NULL;
//                info.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:info animated:YES];
//                return;
//            }
//            if (![list.data.ads.href isEqualToString:@""] && ![list.data.ads.href isEqualToString:@"0"]) {
//                SMessageInfor * infor = [[SMessageInfor alloc] init];
//                infor.type = @"广告链接";
//                infor.code_Url = list.data.ads.href;
//                infor.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:infor animated:YES];
//                return;
//            }
//        };
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

/*
 *设置二级分类和广告的数据展示
 */
-(void)SetDataForContentViewWithData:(SGoodsGoodsList *)list{
    /*
     *保存第一次请求数据时,获取到的banner的图片
     *在切换标题时,清空之前的数据
     */
    if (!self.adsArr) {
        self.adsArr = [[NSMutableArray alloc] init];
    }
    [self.adsArr removeAllObjects];
    if (list.data.ads.picture != nil) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:list.data.ads.picture forKey:@"picture"];
        [self.adsArr addObject:dic];
    }
    
    /*
     *只在第一次加载数据的时候,设置banner和two_cate_list
     */
    [content showModel:arr andTwo_cate_list:list.data.two_cate_list andBanner:self.adsArr andMyType:@"6"];
    
    /*
     *广告点击的回调
     */
    __weak typeof(self) WeakSelf = self;
    content.STicketFight_NewContent_bannerView = ^{
        if (![list.data.ads.merchant_id isEqualToString:@""] && ![list.data.ads.merchant_id  isEqualToString:@"0"]) {
            SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
            infor.merchant_id = list.data.ads.merchant_id;
            infor.hidesBottomBarWhenPushed = YES;
            [WeakSelf.navigationController pushViewController:infor animated:YES];
            return;
        }
        if (![list.data.ads.goods_id isEqualToString:@""] && ![list.data.ads.goods_id isEqualToString:@"0"]) {
            SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
            info.goods_id = list.data.ads.goods_id;
            info.overType = NULL;
            info.hidesBottomBarWhenPushed = YES;
            [WeakSelf.navigationController pushViewController:info animated:YES];
            return;
        }
        if (![list.data.ads.href isEqualToString:@""] && ![list.data.ads.href isEqualToString:@"0"]) {
            SMessageInfor * infor = [[SMessageInfor alloc] init];
            infor.type = @"广告链接";
            infor.code_Url = list.data.ads.href;
            infor.hidesBottomBarWhenPushed = YES;
            [WeakSelf.navigationController pushViewController:infor animated:YES];
            return;
        }
    };
}
@end
