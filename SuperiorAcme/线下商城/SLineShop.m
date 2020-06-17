//
//  SLineShop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50
#import "SLineShop.h"
#import "SLineShop_top.h"
#import "SNBannerView.h"
#import "SLineShop_header.h"
#import "SLineShop_footer.h"
#import "SLineShopCell.h"
#import "SSearch.h"
#import "SOnlineShop_seachView.h"
#import "SMessage.h"
#import "SScanCode.h"
#import "SLineShop_infor.h"
#import "STicketFight.h"
#import "SWelfareAgency.h"
#import "SListedIncubation.h"
#import "SGoodsInfor_first.h"
#import "SPurchase.h"
#import "SOfflineStoreOfflineStore.h"
#import "SOffLineNearbyStoreListModel.h"
#import "SIndexIndex.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
#import "SUserUserCenter.h"
#import "SPayForMerchantController.h"
#import "SOrderCompleteController.h"
#import "UBNearByShopCell.h"
#import "UBNearByShopDiscountTicketCell.h"
#import "UBShopDetailController.h"
#import "SMemberOrder.h"
#import "SAAPIHelper.h"
#import "UBTypeEntryController.h"
#import "SlineDetailWebController.h"
#import "SOrderCenter_list.h"
@interface SLineShop () <UITableViewDelegate,UITableViewDataSource,SNBannerViewDelegate,EMChatManagerDelegate>
{
    UIButton * rightWinBtn;
    BOOL typppp;//NO显示2个 YES显示 5个
    SLineShop_top * top;
    UILabel * mess_count;
    NSArray * bannerArr;
    NSArray * picture_three_merchant_id;
    NSArray * picture_three_goods_id;
    NSArray * picture_three_href;
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
    NSUInteger page;
    
    //NSString *sid;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

/*
 *添加判断是否允许keyWindow添加mess_count的状态属性
 */
@property (nonatomic, assign) BOOL isAddMess_count;

@property (nonatomic, strong) NSMutableArray * NearByShopList;
@property (nonatomic, strong) NSMutableArray * toplist;
@end

static NSString * NearByShopCellID = @"NearByShopCellID";
static NSString * NearByShopDiscountTicketCellID = @"NearByShopDiscountTicketCellID";

@implementation SLineShop

- (void)viewDidLoad {
    [super viewDidLoad];
   
    page = 1;
    [self createNav];
//    [_mTable registerNib:[UINib nibWithNibName:@"SLineShopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SLineShopCell"];
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([UBNearByShopCell class]) bundle:nil] forCellReuseIdentifier:NearByShopCellID];
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([UBNearByShopDiscountTicketCell class]) bundle:nil] forCellReuseIdentifier:NearByShopDiscountTicketCellID];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    top =  [[SLineShop_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /600*400 + 10 + 100 + 10 + ScreenW/3*1 + ScreenW/1242*400 + 10 + 50)];
    _mTable.tableHeaderView = top;
    
    top.downView.hidden = YES;  //+ 100 隐藏地图那块儿
    top.frame = CGRectMake(0, 0, ScreenW, ScreenW /600*400 + 10 + 10 + ScreenW/3*1 + ScreenW/1242*400 + 10 + 200);
    
    //下拉刷新数据
    [self initRefresh];
    
    //SMemberOrder
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushToMemberOrderVC)
                                                 name:@"pushToMemberOrderVC"
                                               object:nil];
   
    
    MJWeakSelf;
    top.typyEntryBlcok = ^(UBTypeModel *typeModel) {
        UBTypeEntryController *entryVC = [UBTypeEntryController instanceWithTypeModel:typeModel];
        entryVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:entryVC animated:YES];
    };
    
}

- (void)pushToMemberOrderVC{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SMemberOrder*memberOrderVC = [SMemberOrder new];
        memberOrderVC.coming = YES;
        memberOrderVC.type = @"线下商铺";
        [self.navigationController pushViewController:memberOrderVC animated:YES];
    });
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     *当当前控制器的视图将要显示的时候,允许keyWindow添加mess_count
     */
    _isAddMess_count = YES;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    //tabBar-->重置、防止重影
    for (id obj in self.tabBarController.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
    [self scrollViewDidScroll:_mTable];
    [TopWindow show];

}
- (void)viewDidAppear:(BOOL)animated {
    
    
    /*
     * 修复点击更多按钮后,窗口无内容显示的问题(是因为keyWindow被修改的原因)
     * 重新设置应用的keyWindow
     */
    if (![UIApplication sharedApplication].windows.firstObject.keyWindow) {
        [[UIApplication sharedApplication].windows.firstObject makeKeyWindow];
    }
    
    //开始侧滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //判断侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    rightWinBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - NavigationBarTitleViewMargin, 20, NavigationBarTitleViewMargin, 44)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:rightWinBtn];
    [rightWinBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//        _mCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    _mCollection.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
//    _mCollection.scrollIndicatorInsets = _mCollection.contentInset;
    
    [mess_count removeFromSuperview];
    //获取当前未读消息数
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        
        [mess_count removeFromSuperview];
        SIndexIndex * list = (SIndexIndex *)data;
        
        [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger totalUnreadCount = 0;
        for (EMConversation *conversation in conversations) {
            totalUnreadCount += conversation.unreadMessagesCount;
        }
        [mess_count removeFromSuperview];
        
        /*//旧代码
        if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
            if (ScreenW > 375) {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
            } else {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25, STATUS_BAR_HEIGHT, 15, 15)];
            }

            mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
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
            if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25, STATUS_BAR_HEIGHT, 15, 15)];
                }
                
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
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
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token != nil) {
        //购物车个数
        SUserUserCenter * center = [[SUserUserCenter alloc] init];
        [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
            SUserUserCenter * center = (SUserUserCenter *)data;
            UIViewController * vc = self.tabBarController.viewControllers[3];
            vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",[center.data.cart_num integerValue]];
            
        } andFailure:^(NSError *error) {
        }];
    }
    
    [self showModel];
    [self GetNearByMerchantList];
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    if ([NSStringFromClass([self.navigationController.viewControllers.lastObject class]) isEqualToString:@"SLineShop"]) {
        [self viewDidAppear:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *当当前控制器的视图将要"不显示"的时候,不允许keyWindow添加mess_count
     */
    _isAddMess_count = NO;
    
    [self.navigationController.navigationBar lt_reset];
    [rightWinBtn removeFromSuperview];
    [mess_count removeFromSuperview];
    
    
}

- (void)initRefresh
{
    __block SLineShop * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          page=1;
        [blockSelf showModel];
      
        [self GetNearByMerchantList];
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self GetNearByMerchantList];
    }];
}
- (void)showModel {
    if(!top.datas){
        [SAAPIHelper recommending_businessType_completion:^(BOOL isSuccess, NSString *message, id result) {
            if (isSuccess) {
                top.datas = result;
            }
        }];
    }
    
    
    SOfflineStoreOfflineStore * store = [[SOfflineStoreOfflineStore alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [store sOfflineStoreOfflineStoreSuccess:^(NSString *code, NSString *message, id data) {
       [_mTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SOfflineStoreOfflineStore * store = (SOfflineStoreOfflineStore *)data;
        //轮播图
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /600*400) delegate:self model:store.data.banner URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [top.barnnerView addSubview:banner];
        bannerArr = store.data.banner;
        
        if (store.data.brand.count == 1) {
            SOfflineStoreOfflineStore * store_first = store.data.brand.firstObject;
            [top.sec_oneImage sd_setImageWithURL:[NSURL URLWithString:store_first.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            picture_three_merchant_id = @[
                                         store_first.merchant_id == nil ? @"" : store_first.merchant_id
                                          ];
            picture_three_goods_id = @[
                                       store_first.goods_id == nil ? @"" : store_first.goods_id
                                       ];
            picture_three_href = @[
                                   store_first.href == nil ? @"" : store_first.href
                                   ];
        }
        if (store.data.brand.count == 2) {
            SOfflineStoreOfflineStore * store_first = store.data.brand.firstObject;
            [top.sec_oneImage sd_setImageWithURL:[NSURL URLWithString:store_first.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            SOfflineStoreOfflineStore * store_second = store.data.brand[1];
            [top.sec_twoImage sd_setImageWithURL:[NSURL URLWithString:store_second.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            picture_three_merchant_id = @[
                                          store_first.merchant_id == nil ? @"" : store_first.merchant_id,
                                          store_second.merchant_id == nil ? @"" : store_second.merchant_id
                                          ];
            picture_three_goods_id = @[
                                       store_first.goods_id == nil ? @"" : store_first.goods_id,
                                       store_second.goods_id == nil ? @"" : store_second.goods_id
                                       ];
            picture_three_href = @[
                                   store_first.href == nil ? @"" : store_first.href,
                                   store_second.href == nil ? @"" : store_second.href
                                   ];

        }
        if (store.data.brand.count == 3) {
            SOfflineStoreOfflineStore * store_first = store.data.brand.firstObject;
            [top.sec_oneImage sd_setImageWithURL:[NSURL URLWithString:store_first.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            SOfflineStoreOfflineStore * store_second = store.data.brand[1];
            [top.sec_twoImage sd_setImageWithURL:[NSURL URLWithString:store_second.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            SOfflineStoreOfflineStore * store_third = store.data.brand[2];
            [top.sec_threeImage sd_setImageWithURL:[NSURL URLWithString:store_third.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            picture_three_merchant_id = @[
                                          store_first.merchant_id == nil ? @"" : store_first.merchant_id,
                                          store_second.merchant_id == nil ? @"" : store_second.merchant_id,
                                          store_third.merchant_id == nil ? @"" : store_third.merchant_id
                                          ];
            picture_three_goods_id = @[
                                       store_first.goods_id == nil ? @"" : store_first.goods_id,
                                       store_second.goods_id == nil ? @"" : store_second.goods_id,
                                       store_third.goods_id == nil ? @"" : store_third.goods_id
                                       ];
            picture_three_href = @[
                                   store_first.href == nil ? @"" : store_first.href,
                                   store_second.href == nil ? @"" : store_second.href,
                                   store_third.href == nil ? @"" : store_third.href
                                   ];

        }
        
        [top.sec_oneBtn setTag:0];
        [top.sec_oneBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.sec_twoBtn setTag:1];
        [top.sec_twoBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.sec_threeBtn setTag:2];
        [top.sec_threeBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        SOfflineStoreOfflineStore * store_ads = store.data.ads.firstObject;
        [top.ads_Image sd_setImageWithURL:[NSURL URLWithString:store_ads.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        url_merchant_id = store_ads.merchant_id;
        url_goods_id = store_ads.goods_id;
        url_href = store_ads.href;
        [top.imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    } andFailure:^(NSError *error) {
        [_mTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

-(void)GetNearByMerchantList{
    SOffLineNearbyStoreListModel * store = [[SOffLineNearbyStoreListModel alloc] init];
    store.lng = GET_LNG;
    store.lat = GET_LAT;
    store.p = [@(page) stringValue];

    [store sOfflineStoreOfflineStoreListSuccess:^(NSString *code, NSString *message, id data,id topList) {
        [self.mTable.mj_footer endRefreshing];
        [self.mTable.mj_header endRefreshing];
        if (1 == page) {
            [self.NearByShopList removeAllObjects];
            self.NearByShopList = nil;
            //优质商家
     //       if ([Url_header isEqualToString:@"test2"]) {
                self.toplist=[(NSArray *)topList mutableCopy];
                self.NearByShopList = [(NSArray *)topList mutableCopy];
                [self.NearByShopList addObjectsFromArray:[(NSArray *)data mutableCopy]];
       //     }
//            else
//            {
//                  self.NearByShopList = [(NSArray *)data mutableCopy];
//            }
          
        }else{
            if (SWNOTEmptyArr((NSArray *)data)) {
             [self.NearByShopList addObjectsFromArray:[(NSArray *)data mutableCopy]];
             //   [_mTable.mj_footer endRefreshing];
            
            }else{
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
            
        }
       // NSLog(@"AAAA %@", self.NearByShopList);
         [self.mTable reloadData];
      
      
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}


#pragma mark - 轮播广告
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    SOfflineStoreOfflineStore * home = bannerArr[index];
    if (home.merchant_id != nil && ![home.merchant_id isEqualToString:@""] && ![home.merchant_id isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = home.merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (home.goods_id != nil && ![home.goods_id isEqualToString:@""] && ![home.goods_id isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = home.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (home.href != nil && ![home.href isEqualToString:@""] && ![home.href isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = home.href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    
}
#pragma mark - 三广告活动
- (void)imageBtnThreeClick:(UIButton *)btn {
    if (picture_three_merchant_id[btn.tag] != nil && ![picture_three_merchant_id[btn.tag] isEqualToString:@""] && ![picture_three_merchant_id[btn.tag] isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = picture_three_merchant_id[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (picture_three_goods_id[btn.tag] != nil && ![picture_three_goods_id[btn.tag] isEqualToString:@""] && ![picture_three_goods_id[btn.tag] isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = picture_three_goods_id[btn.tag];
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (picture_three_href[btn.tag] != nil && ![picture_three_href[btn.tag] isEqualToString:@""] && ![picture_three_href[btn.tag] isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = picture_three_href[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
}
- (void)imageBtnClick {
    if (url_merchant_id != nil && ![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = url_merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (url_goods_id != nil && ![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = url_goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (url_href != nil && ![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
        
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = url_href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 60, 44);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-13,0,0);
    lefthBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-13,0,0);

    self.navigationItem.leftBarButtonItem = leftBtnItem;
    lefthBtn.titleLabel.numberOfLines=1;
    [lefthBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [lefthBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"] forState:UIControlStateNormal];
    lefthBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0,-15);
    [rightBtn setImage:[UIImage imageNamed:@"导航栏消息"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-25);
    [rightBtn_sub setImage:[UIImage imageNamed:@"导航栏扫一扫"] forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
    
    SOnlineShop_seachView * searchView = [[SOnlineShop_seachView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 30)];
    self.navigationItem.titleView = searchView;
    searchView.backgroundColor = [UIColor clearColor];
    searchView.groundView.layer.masksToBounds = YES;
    searchView.groundView.layer.cornerRadius = 3;
    [searchView.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 定位
- (void)lefthBtnClick {

//    SPurchase * purchase = [[SPurchase alloc] init];
//    purchase.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:purchase animated:YES];
    
//    SPayForMerchantController * vc = [[SPayForMerchantController alloc] init];
//    SOrderCompleteController * vc = [[SOrderCompleteController alloc] init];
//    vc.url = @"";
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 搜索
- (void)searchBtnClick{
    [mess_count removeFromSuperview];
    
    SSearch * search = [[SSearch alloc] init];
    search.searchType = SearchType_underline;
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark - 消息
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
//            [self showModel];
        };
        return;
    }
    [mess_count removeFromSuperview];
    SMessage * mess = [[SMessage alloc] init];
    mess.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mess animated:YES];
}
#pragma mark - 扫一扫
- (void)rightBtn_subClick {
    
    [mess_count removeFromSuperview];
    SScanCode * code = [[SScanCode alloc] init];
    code.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:code animated:YES];
}

/*
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (typppp == NO) {
//        return 2;
//    }
//    return 5;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 130;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    SLineShop_header * header = [[SLineShop_header alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
//    header.SLineShop_header_selectBtn = ^{
//
//        [mess_count removeFromSuperview];
//        SLineShop_infor * infor = [[SLineShop_infor alloc] init];
//        infor.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:infor animated:YES];
//    };
//
//    for (UIView * view in header.starView.subviews) {
//        [view removeFromSuperview];
//    }
//    for (int i = 0; i < 5; i++) {
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 2.5, 15, 15)];
//        [header.starView addSubview:imageView];
//
//        imageView.image = [UIImage imageNamed:@"星星黄"];
//    }
//    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"距您4.5km"];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
//    header.addressNum.attributedText = AttributedStr;
//
//    return header;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 140;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    SLineShop_footer * footer = [[SLineShop_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 140)];
//    
//    return footer;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 30;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    SLineShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SLineShopCell" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    if (indexPath.row == 0) {
//        cell.openBtn.hidden = NO;
//    } else {
//        cell.openBtn.hidden = YES;
//    }
//
//    if (typppp == NO) {
//        [cell.openBtn setImage:[UIImage imageNamed:@"灰色下箭头"] forState:UIControlStateNormal];
//    } else {
//        [cell.openBtn setImage:[UIImage imageNamed:@"灰色上箭头"] forState:UIControlStateNormal];
//    }
//
//    return cell;
//}
//- (void)openBtnClick {
//    //查看更多
//    if (typppp == NO) {
//        typppp = YES;
//    } else {
//        typppp = NO;
//    }
//    [_mTable reloadData];
//}
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.NearByShopList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    SOffLineNearbyStoreListModel * model = self.NearByShopList[section];
    return model.RowCount;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section];
    if (indexPath.row == 0) {
        UBNearByShopCell * cell = [tableView dequeueReusableCellWithIdentifier:NearByShopCellID forIndexPath:indexPath];
        cell.nearByStoreModel = model;
        return cell;
    }else{
        UBNearByShopDiscountTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:NearByShopDiscountTicketCellID forIndexPath:indexPath];
        if (model.user_id>0&&model.show_type ==1) {
          
            cell.discountTicketTipLabel.hidden=NO;
            cell.aviliableDiscountTicketLabel.hidden=NO;
            cell.showMoreDiscountTicketBtn.hidden=NO;
        }
        else
        {
            cell.discountTicketTipLabel.hidden=YES;
            cell.aviliableDiscountTicketLabel.hidden=YES;
            cell.showMoreDiscountTicketBtn.hidden=YES;
        }
        SOffLineNearbyStoreListModel * ticketModel = model.ticket[indexPath.row - 1];
        cell.nearByStoreTikcetModel = ticketModel;
        cell.ShowMoreDiscountTicketBlock = ^(BOOL isCLick){
            model.RowCount = isCLick?model.ticket.count + 1:2;
            ticketModel.isClick = isCLick;
            [tableView reloadData];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 85;
    }else{
        return 35;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section];
    if (indexPath.row!= 0) {
        if (model.user_id>0&&model.show_type ==1) {
            return UITableViewAutomaticDimension;
        }
        else
        {
             return 0;
        }
    }
    return UITableViewAutomaticDimension;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.toplist.count>0) {
        if (0 == section) {
            return [[NSBundle mainBundle] loadNibNamed:@"UBNearByShopHeaderView" owner:nil options:nil].firstObject;
        }else{
            return [UIView new];
        }
   }

    else
    {
        if (0 == section) {
            return [[NSBundle mainBundle] loadNibNamed:@"UBNearByShopFooterView" owner:nil options:nil].firstObject;
        }else{
            return [UIView new];
        }
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 49.0;
    }else{
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.toplist.count-1==section) {
          return [[NSBundle mainBundle] loadNibNamed:@"UBNearByShopFooterView" owner:nil options:nil].firstObject;
    }
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    
    if (self.toplist.count-1==section) {
        return 49;
    }
     return 1;
    
}
- (void)WebDetailClickWithSid:(NSString *)sid {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
        };
        return;
    }
    else
    {
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length==0) {
            invite_code=@"";
        }
        
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/os_type/1", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        
        NSString *urlStr=nil;
        
        if (invite_code.length>0) {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@/invite_code/%@.html",detail_Base_url,sid,invite_code];
        }
        else
        {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@.html",detail_Base_url,sid];
        }
        
        
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=urlStr;
        conter.fag=@"3";
        conter.hidesBottomBarWhenPushed=YES;
       
        [self.navigationController pushViewController:conter animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mess_count removeFromSuperview];
    SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section];

    if ([model.goods_num integerValue] >0 ) {
   //     if ([Url_header isEqualToString:@"test2"]) {
         //   sid=model.s_id;
            [self WebDetailClickWithSid:model.s_id];
    //    }
       
    }
    else
    {
        UBShopDetailController *detailVC = [UBShopDetailController instanceWithMerchant_id:model.s_id];
          detailVC.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:detailVC animated:YES];
   }
//    SLineShop_infor * infor = [[SLineShop_infor alloc] init];
//    infor.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:infor animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //        home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
        top.bannerTopImage.hidden = YES;
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        top.bannerTopImage.hidden = NO;
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(ScreenW /600*400)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=ScreenW /600*400){
        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}
@end
