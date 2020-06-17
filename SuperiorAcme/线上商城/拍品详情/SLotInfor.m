//
//  SLotInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLotInfor.h"
#import "SLotInfor_oneCell.h"
#import "SLotInfor_twoCell.h"
#import "SLotInfor_top.h"
#import "SNBannerView.h"
#import "SLotInfor_header.h"
#import "SLotInfor_submit.h"
#import "SAuctionAuctionInfo.h"

#import "SGoodsInfor_nav.h"
#import "SLotInfor_newCell.h"
#import "SGoodsInfor_first_oneCell.h"
#import "SGoodsInfor_first_fourCell.h"
#import "SOnlineShopCell.h"
#import "SLotInfor_newOneView.h"
#import "SLotInfor_newTwoView.h"
#import "SGoodsExplain.h"
#import "SUserCollectAddCollect.h"
#import "SUserCollectDelOneCollect.h"
#import "AShare.h"
#import "SPromotion_OPEN.h"
#import "DatePicker_Country.h"
#import "SOnlineShop_ClassInfoList_sub.h"
#import "SOnlineShopInfor.h"
#import "SAuctionOrderAuct.h"//保证金判断
#import "SPay.h"
#import "SOrderConfirm.h"
#import "SAuctionOrderSetOrder.h"
#import "SAuctionRemindMe.h"//设置提醒
#import "SUserUserCenter.h"
#import "SFreightFreight.h"
#import "SEva.h"

@interface SLotInfor () <UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate>
{
    SLotInfor_top * top;
    SGoodsInfor_nav * nav;//顶部(商品、详情、评价)View
    UIButton * rightBtn_sub;
    
    NSArray * auction_log_arr;
    NSMutableArray * arr;//列表
    NSInteger  page;
    BOOL is_EndNew_Bool;//是否全部隐藏灯泡
    NSInteger is_EndNew_Bool_num;
    NSInteger auth_desc_num;//拍品描述高度
    NSArray * dj_ticket;//代金券
    NSInteger dj_ticket_num;
    
    NSString * country_logo;
    NSString * country_desc;
    NSString * country_tax;
    NSArray * goods_server;//商品服务信息
    NSString * total;//"总评论数"
    NSInteger total_num;
    NSString * user_head_pic;//"用户头像",
    NSString * nickname;//"用户昵称",
    NSString * content;//"评论内容",
    NSString * create_time;// "创建时间",
    NSArray * pictures;//评论图片列表
    NSString * logo;//"店铺logo",
    NSString * merchant_name;//"店铺名称",
    NSString * level;//"店铺等级",
    NSString * all_goods;//全部宝贝
    NSString * view_num;//"关注人数"
    NSString * goods_score;//"宝贝评分",
    NSString * merchant_score;//"卖家评分",
    NSString * shipping_score;//"物流评分"
    NSString * ticket_buy_discount;//最多可使用多少代金券
    NSString * group_price;//优惠组合价格
    NSString * integral;//赠送积分
    NSString * goods_price;//商品总价、
    NSArray * goods;//商品
    NSInteger goods_num;

    NSString * goods_desc;//"商品图文详情",//HTML格式
    NSString * package_list;//"包装清单",
    NSInteger package_list_num;
    NSString * after_sale_service;// "售后服务",
    NSInteger after_sale_service_num;
    NSString * price_desc;//价格说明
    NSInteger price_desc_num;
    NSArray * goods_common_attr;//产品规格列表
    
    NSString * nowType;//默认1:商品介绍 2:规格参数 3:包装售后
    SLotInfor_newTwoView  * header2;
    NSInteger wek_web_num;
    
    NSInteger mybid_num;
    
    NSString * collect_id;
    BOOL collect_isno;
    NSString * merchant_id;
    NSString * share_url;//分享链接
    NSString * share_img;//"分享图片",
    NSString * share_title;//分享标题
    NSString * share_content;//"分享内容"
    NSString * vouchers_desc;//代金券说明
    NSString * cate_id;//": "商品三级分类id",
    NSString * two_cate_name;//": "休闲食品",//二级分类名称
    
    BOOL first_isno;//第一次进来

    NSString * model_merchant_id;
    
    NSString * merchant_easemob_account;//": "150582059257251",//商家客服账号
    NSString * merchant_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-19/59c0ff9493ec1.png",//商家客服头像
    NSString * merchant_nickname;//": "hi po n",//客服昵称
    
    NSString * now_province;
    NSString * now_city;
    NSString * now_area;
    NSMutableAttributedString * now_freight;
    NSString * top_freight;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIButton *moveTopBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *remindImage;
@end

@implementation SLotInfor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
}
- (void)viewDidAppear:(BOOL)animated {
    if (first_isno == NO) {
        first_isno = YES;
    } else {
        [self showModel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nowType = @"1";
    total_num = 0;
    goods_num = 0;
    wek_web_num = 0;
    
    [self createNav];
    [self createUI];
    
    page = 1;
    [self initRefresh];
    now_province = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"];
    now_city = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称"];
    now_area = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称_sub"];
    [self showModel];
    
    [_leftBtn addTarget:self action:@selector(leftBtnBlock) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn addTarget:self action:@selector(rightBtnBlock) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initRefresh
{
    __block SLotInfor * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    SAuctionAuctionInfo * infor = [[SAuctionAuctionInfo alloc] init];
    infor.auction_id = _auction_id;
    infor.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sAuctionAuctionInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SAuctionAuctionInfo * infor = (SAuctionAuctionInfo *)data;
        merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
        merchant_head_pic = infor.data.mInfo.merchant_head_pic;
        merchant_nickname = infor.data.mInfo.merchant_nickname;
        collect_id = infor.data.goodsInfo.goods_id;
        merchant_id = infor.data.goodsInfo.merchant_id;
        if ([infor.data.is_collect isEqualToString:@"1"]) {
            [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
            [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
            collect_isno = YES;
        } else {
            [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
            [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
            collect_isno = NO;
        }
        share_url = infor.data.share_url;
        share_img = infor.data.share_img;
        share_title = infor.data.goodsInfo.goods_name;
        share_content = infor.data.share_content;
        vouchers_desc = infor.data.vouchers_desc;
        cate_id = infor.data.goodsInfo.cate_id;
        two_cate_name = infor.data.goodsInfo.two_cate_name;
        model_merchant_id = infor.data.goodsInfo.merchant_id;

        //轮播图
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [top.bannerView addSubview:banner];
        
        //是否临期商品
        if ([infor.data.goodsInfo.is_end isEqualToString:@"1"]) {
            top.is_end_desc.text = infor.data.goodsInfo.is_end_desc;
        } else {
            top.is_end_desc.hidden = YES;
        }
        
        //是否旧货
        if ([infor.data.goodsInfo.is_new_goods isEqualToString:@"0"]) {
            top.is_new_goods_desc.text = infor.data.goodsInfo.is_new_goods_desc;
        } else {
            top.is_new_goods_desc.hidden = YES;
        }
        if ([infor.data.goodsInfo.is_end isEqualToString:@"0"] && [infor.data.goodsInfo.is_new_goods isEqualToString:@"1"]) {
            is_EndNew_Bool = YES;
            top.is_EndNewView.hidden = YES;
            top.is_EndNewView_HHH.constant = 0;
        } else {
            is_EndNew_Bool = NO;
            
            if ([infor.data.goodsInfo.is_end isEqualToString:@"0"]) {
                top.is_end_desc.hidden = YES;
                top.is_end_desc_HHH.constant = 0;
            } else {
                top.is_new_goods_desc.hidden = YES;
                top.is_end_desc_HHH.constant = 40;
            }
        }
        is_EndNew_Bool_num = 0;
        if (is_EndNew_Bool == YES) {
            is_EndNew_Bool_num = 50;
        }
        
        CGSize size = [[NSString stringWithFormat:@"活动说明：\n%@",infor.data.goodsInfo.auct_desc] boundingRectWithSize:CGSizeMake(ScreenW - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        top.auth_desc_HHH.constant = 15 + size.height + 10;
        auth_desc_num = 15 + size.height + 10;
        
        NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"活动说明：\n%@",infor.data.goodsInfo.auct_desc]];
        [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, 5)];
        top.auth_desc.attributedText = attributedStr_dec;
        
        
        top.stage_status.text = infor.data.goodsInfo.stage_status;
        top.auct_name.text = infor.data.goodsInfo.auct_name;
        top.now_price.text = infor.data.goodsInfo.now_price;
        top.integral.text = infor.data.goodsInfo.integral;
        
        NSMutableAttributedString * attributedStr_click_num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"围观 %@ 次",infor.data.goodsInfo.click_num]];
        [attributedStr_click_num addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(3, infor.data.goodsInfo.click_num.length)];
        top.click_num.attributedText = attributedStr_click_num;
        
        NSMutableAttributedString * attributedStr_apply_num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"报名 %@ 人",infor.data.goodsInfo.apply_num]];
        [attributedStr_apply_num addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(3, infor.data.goodsInfo.apply_num.length)];
        top.apply_num.attributedText = attributedStr_apply_num;
        
        NSMutableAttributedString * attributedStr_remind_num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"设置提醒 %@ 人",infor.data.goodsInfo.remind_num]];
        [attributedStr_remind_num addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(5, infor.data.goodsInfo.remind_num.length)];
        top.remind_num.attributedText = attributedStr_remind_num;
        
        top.start_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.start_price];
        top.add_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.add_price];
        top.start_time.text = infor.data.goodsInfo.start_time;
        top.thisEnd_time.text = infor.data.goodsInfo.end_time;
        top.leave_price.text = infor.data.goodsInfo.leave_price;
        top.base_money.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.base_money];
        top.delay_time.text = infor.data.goodsInfo.delay_time;
        top.mybid.text = [NSString stringWithFormat:@"您的出价ID：%@",infor.data.mybid];
        
        if ([infor.data.mybid isEqualToString:@"0"]) {
            mybid_num = 100;
            top.mybid_oneView.hidden = YES;
            top.mybid_twoView.hidden = YES;
        } else {
            mybid_num = 0;
            top.mybid_oneView.hidden = NO;
            top.mybid_twoView.hidden = NO;
        }
        top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 580 - is_EndNew_Bool_num - 100 + auth_desc_num - mybid_num);

        //代金券
        dj_ticket = infor.data.goodsInfo.dj_ticket;

        country_logo = infor.data.goodsInfo.country_logo;
        country_desc = infor.data.goodsInfo.country_desc;
        country_tax = infor.data.goodsInfo.country_tax;
        goods_server = infor.data.goods_server;
        total = infor.data.comment.total;
        user_head_pic = infor.data.comment.body.user_head_pic;
        nickname = infor.data.comment.body.nickname;
        content = infor.data.comment.body.content;
        create_time = infor.data.comment.body.create_time;
        pictures = infor.data.comment.body.pictures;
        logo = infor.data.mInfo.logo;
        merchant_name = infor.data.mInfo.merchant_name;
        level = infor.data.mInfo.level;
        all_goods = infor.data.mInfo.all_goods;
        view_num = infor.data.mInfo.view_num;
        goods_score = infor.data.mInfo.goods_score;
        merchant_score = infor.data.mInfo.merchant_score;
        shipping_score = infor.data.mInfo.shipping_score;

        if ([total integerValue] == 0) {
            total_num = 250;
        }
        
        goods_desc = infor.data.goodsInfo.goods_desc;
        package_list = infor.data.goodsInfo.package_list;
        after_sale_service = infor.data.goodsInfo.after_sale_service;
        price_desc = infor.data.price_desc;
        goods_common_attr = infor.data.goods_common_attr;
        
        CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        package_list_num = size_package_list.height + 10;
        CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        after_sale_service_num = size_after_sale_service.height + 10;
        CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        price_desc_num = size_price_desc.height + 10;
        
        auction_log_arr = infor.data.auction_log;
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:infor.data.guess_goods_list];            [_mCollect.mj_footer resetNoMoreData];
                
        } else {
            if (infor.data.guess_goods_list.count) {
                [arr addObjectsFromArray:infor.data.guess_goods_list];
                [_mCollect.mj_footer endRefreshing];
                    
            } else {
                [_mCollect.mj_footer endRefreshingWithNoMoreData];
                    
            }
        }
        [_mCollect.mj_header endRefreshing];
        [self freight_num];
        [_mCollect reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];

}
#pragma mark - 运费
- (void)freight_num {
    SFreightFreight * freight = [[SFreightFreight alloc] init];
    freight.goods_id = collect_id;
    freight.address = [NSString stringWithFormat:@"%@,%@,%@",now_province,now_city,now_area];
    [freight sFreightFreightSuccess:^(NSString *code, NSString *message, id data) {
        SFreightFreight * freight = (SFreightFreight *)data;
        
        if ([freight.data.pay isEqualToString:@"0"] || freight.data.pay == nil) {
            now_freight = [[NSMutableAttributedString alloc]initWithString:@"包邮"];
            top_freight = @"包邮";
        } else {
            now_freight = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"运费 %@元",freight.data.pay]];
            top_freight = [NSString stringWithFormat:@"运费 %@元",freight.data.pay];
            [now_freight addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, freight.data.pay.length)];
            
        }
        [_mCollect reloadData];
        
    } andFailure:^(NSError *error) {
        
    }];
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
    [rightBtn setImage:[UIImage imageNamed:@"详情分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
    rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn_sub setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 70;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    //商品
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //评价
    [nav.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nav.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
    //详情
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nav.twoBtn setTitle:@"详情" forState:UIControlStateNormal];
    //默认商品选中
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //置顶
    _moveTopBtn.hidden = YES;
    [_moveTopBtn addTarget:self action:@selector(moveTopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 置顶
- (void)moveTopBtnClick {
    [_mCollect setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark - 商品
- (void)oneBtnClick {

    [_mCollect setContentOffset:CGPointMake(0, 0) animated:YES];
    
}
#pragma mark - 评价
- (void)twoBtnClick {
    if (arr.count%2 == 0) {
        [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 450 + 64) animated:YES];
    } else {
        [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 450 + 64) animated:YES];
    }
    
    
}
#pragma mark - 详情
- (void)threeBtnClick {
    if (arr.count%2 == 0) {
        [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 + 64) animated:YES];
    } else {
        [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 + 64) animated:YES];
    }
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
    shareVC.thisUrl = share_url;
    shareVC.thisImage = share_img;
    shareVC.thisTitle = share_title;
    shareVC.thisContent = share_content;
    shareVC.thisType = @"1";
    shareVC.id_val = collect_id;
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
    
    if (collect_isno == NO) {
        SUserCollectAddCollect * collect = [[SUserCollectAddCollect alloc] init];
        collect.type = @"1";
        collect.id_val = collect_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [collect sUserCollectAddCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else {
        SUserCollectDelOneCollect * delCollect = [[SUserCollectDelOneCollect alloc] init];
        delCollect.type = @"1";
        delCollect.id_val = collect_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [delCollect sUserCollectDelOneCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    top = [[SLotInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW + 580)];
    [_mCollect addSubview:top];

 
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SLotInfor_newCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SLotInfor_newCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_oneCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_oneCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_fourCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_fourCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    //Header
    [_mCollect registerNib:[UINib nibWithNibName:@"SLotInfor_newOneView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLotInfor_newOneView"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SLotInfor_newTwoView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLotInfor_newTwoView"];
    //Footer
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView_clear"];
    
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return auction_log_arr.count;
    }
    if (section == 1) {
        if (dj_ticket.count > 2) {
            return 2;
        }
        return dj_ticket.count;
    }
    if (section == 2) {
        if ([nowType isEqualToString:@"2"]) {
            return goods_common_attr.count;
        }
        return 0;
    }
    if (section == 3) {
        return arr.count;
    }
    return 4;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {

        return UIEdgeInsetsMake(ScreenW + 580 - is_EndNew_Bool_num - 100 + auth_desc_num - mybid_num + 40, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2) {
        return 0.01;
    }
    return 5;
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        return CGSizeMake(ScreenW, 50);
    }
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (dj_ticket.count == 0) {
            CGSize size = {0.01,0.01};
            return size;
        }
        CGSize size = {0.01,60};
        return size;
    }
    if (section == 2) {
        if ([nowType isEqualToString:@"1"]) {
            CGSize size = {ScreenW,1105 - total_num - goods_num - 50 - 50 - 100 - 50 - 50 - 50 - 10 - 10 + wek_web_num};
            return size;
        }
        if ([nowType isEqualToString:@"2"]) {
            CGSize size = {ScreenW,1105 - total_num - goods_num - 50 - 50 - 100 - 50 - 50 - 50 - 10 - 10};
            return size;
        }
        CGSize size = {ScreenW,1105 - total_num - goods_num - 50 - 50 - 100 + package_list_num + after_sale_service_num + price_desc_num};
        return size;
    }

    CGSize size = {0.01,0.01};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        CGSize size = {ScreenW,50};
        return size;
    }

    CGSize size = {0.01,0.01};
    return size;
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 1) {
            SLotInfor_newOneView * header = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLotInfor_newOneView" forIndexPath:indexPath];
            if (dj_ticket.count == 0) {
                header.hidden = YES;
            } else {
                header.hidden = NO;
            }
            [header.dj_ticketBtn addTarget:self action:@selector(dj_ticketBtnClick) forControlEvents:UIControlEventTouchUpInside];

            reusableview = header;
        } else {
            header2 = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLotInfor_newTwoView" forIndexPath:indexPath];
            
            header2.send_Content.text = [NSString stringWithFormat:@"送至    %@%@%@",now_province,now_city,now_area];
            header2.pushPrice.attributedText = now_freight;
            
            [header2.country_logo sd_setImageWithURL:[NSURL URLWithString:country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            header2.country_desc.text = country_desc;
            
            if ([country_tax integerValue] == 0) {
                header2.price.hidden = YES;
            } else {
                header2.price.hidden = NO;
            }
            NSMutableAttributedString * attributedStr_cityPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"进口税  %@元/件",country_tax]];
            [attributedStr_cityPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, country_tax.length + 1)];
            header2.price.attributedText = attributedStr_cityPrice;
            
            if (goods_server.count == 0) {
                header2.goods_server_oneImage.hidden = YES;
                header2.goods_server_oneTitle.hidden = YES;
                header2.goods_server_twoImage.hidden = YES;
                header2.goods_server_twoTitle.hidden = YES;
            } else if (goods_server.count == 1) {
                header2.goods_server_oneImage.hidden = NO;
                header2.goods_server_oneTitle.hidden = NO;
                header2.goods_server_twoImage.hidden = YES;
                header2.goods_server_twoTitle.hidden = YES;
                
                SAuctionAuctionInfo * server_infor = goods_server.firstObject;
                [header2.goods_server_oneImage sd_setImageWithURL:[NSURL URLWithString:server_infor.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_oneTitle.text = server_infor.server_name;
                
            } else if (goods_server.count > 1) {
                header2.goods_server_oneImage.hidden = NO;
                header2.goods_server_oneTitle.hidden = NO;
                header2.goods_server_twoImage.hidden = NO;
                header2.goods_server_twoTitle.hidden = NO;
                
                SAuctionAuctionInfo * server_infor = goods_server.firstObject;
                [header2.goods_server_oneImage sd_setImageWithURL:[NSURL URLWithString:server_infor.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_oneTitle.text = server_infor.server_name;

                SAuctionAuctionInfo * server_infor1 = goods_server[1];
                [header2.goods_server_twoImage sd_setImageWithURL:[NSURL URLWithString:server_infor1.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_twoTitle.text = server_infor1.server_name;
            }
            
            if ([total integerValue] == 0) {
                header2.eva_topHHH.constant = 0;
                header2.eva_TitleView.hidden = YES;
                header2.eva_TitleViewHHH.constant = 0;
                header2.evaHiddenView.hidden = YES;
                header2.evaHiddenView_HHH.constant = 0;
            } else {
                header2.eva_topHHH.constant = 10;
                header2.eva_TitleView.hidden = NO;
                header2.eva_TitleViewHHH.constant = 40;
                header2.evaHiddenView.hidden = NO;
                header2.evaHiddenView_HHH.constant = 200;
            }
            
            header2.total.text = [NSString stringWithFormat:@"商品评价（%@）",total];
            [header2.headerImage sd_setImageWithURL:[NSURL URLWithString:user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            header2.nickname.text = nickname;
            header2.thisContent.text = content;
            header2.create_time.text = create_time;
            [header2 showModel:pictures];
            
            [header2.logo sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            header2.merchant_name.text = merchant_name;
            for (UIView * view in header2.starView.subviews) {
                [view removeFromSuperview];
            }
            for (int i = 0; i < [level integerValue]; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                [header2.starView addSubview:imageView];
                imageView.image = [UIImage imageNamed:@"皇冠"];
            }
            header2.all_goods.text = all_goods;
            header2.view_num.text = view_num;
            NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",goods_score]];
            [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, goods_score.length)];
            header2.num1.attributedText = attributedStr1;
            
            NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",merchant_score]];
            [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, merchant_score.length)];
            header2.num2.attributedText = attributedStr2;
            
            NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",shipping_score]];
            [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, shipping_score.length)];
            header2.num3.attributedText = attributedStr3;
            
            header2.package_list.text = package_list;
            header2.after_sale_service.text = after_sale_service;
            header2.price_desc.text = price_desc;
            
            if ([nowType isEqualToString:@"1"]) {
                [header2.down_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [header2.down_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header2.down_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
                
                if (goods_desc != nil) {
                    [header2 wk_web:goods_desc];
                }
            }
            if ([nowType isEqualToString:@"2"]) {
                [header2.down_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header2.down_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [header2.down_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
            }
            if ([nowType isEqualToString:@"3"]) {
                [header2.down_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header2.down_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header2.down_threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            if ([nowType isEqualToString:@"1"] || [nowType isEqualToString:@"2"]) {
                header2.thisWk_web.hidden = NO;
                
                header2.package_list_HHH.constant = 0;
                header2.after_sale_service_HHH.constant = 0;
                header2.price_desc_HHH.constant = 0;
                header2.package_listView.hidden = YES;
                header2.after_sale_serviceView.hidden = YES;
                header2.price_descView.hidden = YES;
                
                header2.downOne.hidden = YES;
                header2.downTwo.hidden = YES;
                header2.donwThree.hidden = YES;
                header2.downOne_HHH.constant = 0;
                header2.downTwo_HHH.constant = 0;
                header2.downThree_HHH.constant = 0;
                header2.downTwo_topHHH.constant = 0;
                header2.downThree_topHHH.constant = 0;
                
            } else if ([nowType isEqualToString:@"3"]) {
                header2.thisWk_web.hidden = YES;
                
                header2.package_list_HHH.constant = package_list_num;
                header2.after_sale_service_HHH.constant = after_sale_service_num;
                header2.price_desc_HHH.constant = price_desc_num;
                header2.package_listView.hidden = NO;
                header2.after_sale_serviceView.hidden = NO;
                header2.price_descView.hidden = NO;
                
                header2.downOne.hidden = NO;
                header2.downTwo.hidden = NO;
                header2.donwThree.hidden = NO;
                header2.downOne_HHH.constant = 50;
                header2.downTwo_HHH.constant = 50;
                header2.downThree_HHH.constant = 50;
                header2.downTwo_topHHH.constant = 10;
                header2.downThree_topHHH.constant = 10;
            }
            header2.QGoodsInfor_first_header3Reusa_HTML = ^(NSInteger num) {
                wek_web_num = num;
                [_mCollect reloadData];
            };
            //全部评价
            [header2.evaBtn addTarget:self action:@selector(evaBtnClick) forControlEvents:UIControlEventTouchUpInside];
            //商品介绍
            header2.QGoodsInfor_first_header3Reusa_downOneBtn = ^{
                nowType = @"1";
                [_mCollect reloadData];
            };
            //规格参数
            header2.QGoodsInfor_first_header3Reusa_downTwoBtn = ^{
                nowType = @"2";
                [_mCollect reloadData];
            };
            //包装售后
            header2.QGoodsInfor_first_header3Reusa_downThreeBtn = ^{
                nowType = @"3";
                [_mCollect reloadData];
            };
            [header2.priceInterBtn addTarget:self action:@selector(priceInterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //配送地区
            [header2.sendBtnClick addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
            //查看分类
            [header2.oneBtn addTarget:self action:@selector(lookTypeClick) forControlEvents:UIControlEventTouchUpInside];
            //进店逛逛
            [header2.twoBtn addTarget:self action:@selector(shopAroundClick) forControlEvents:UIControlEventTouchUpInside];
            
            reusableview = header2;

        }

    }// header;
    if (kind == UICollectionElementKindSectionFooter) {

        if (indexPath.section == 2) {
            UICollectionReusableView * footer = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            for (UIView * view in footer.subviews) {
                [view removeFromSuperview];
            }

            UILabel * footer_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
            [footer addSubview:footer_title];
            footer_title.text = @"猜你喜欢";
            footer_title.font = [UIFont systemFontOfSize:14];
            footer_title.textColor = WordColor_sub;
            footer_title.textAlignment = NSTextAlignmentCenter;

            reusableview = footer;
        } else {
            UICollectionReusableView * footer = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView_clear" forIndexPath:indexPath];

            reusableview = footer;
        }

    }
    return reusableview;
}
#pragma mark - 商家评价
- (void)evaBtnClick {
    SEva * eva = [[SEva alloc] init];
    eva.hidesBottomBarWhenPushed = YES;
    eva.type = YES;
    eva.merchant_id = merchant_id;
    [self.navigationController pushViewController:eva animated:YES];
}
#pragma mark - 说明
- (void)priceInterBtnClick:(UIButton *)btn {
    SGoodsExplain * explain = [[SGoodsExplain alloc] init];
    explain.modalPresentationStyle = UIModalPresentationOverFullScreen;
    explain.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:explain animated:YES completion:nil];
    [explain showModel:goods_server andType:@"竞拍汇" andType:@"服务说明"];
    explain.SGoodsExplainBack = ^{
        [explain dismissViewControllerAnimated:YES completion:nil];
    };
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SLotInfor_newCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SLotInfor_newCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            mCell.one.textColor = [UIColor redColor];
            mCell.two.textColor = [UIColor redColor];
            mCell.three.textColor = [UIColor redColor];
            mCell.four.textColor = [UIColor redColor];
        } else {
            mCell.one.textColor = WordColor_sub;
            mCell.two.textColor = WordColor_sub;
            mCell.three.textColor = WordColor_sub;
            mCell.four.textColor = WordColor_sub;
        }
        SAuctionAuctionInfo * infor = auction_log_arr[indexPath.row];
        mCell.one.text = infor.nickname;
        mCell.two.text = infor.log_id;
        mCell.three.text = infor.bid_price;
        mCell.four.text = infor.bid_time;
        
        
        return mCell;
    }
    if (indexPath.section == 1) {
        SGoodsInfor_first_oneCell * oneCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_oneCell" forIndexPath:indexPath];
        
        SAuctionAuctionInfo * infor = dj_ticket[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            oneCell.redR.backgroundColor = [UIColor redColor];
        }
        if ([infor.type isEqualToString:@"2"]) {
            oneCell.redR.backgroundColor = [UIColor orangeColor];
        }
        if ([infor.type isEqualToString:@"3"]) {
            oneCell.redR.backgroundColor = MyBlue;
        }
        oneCell.discount_desc.text = infor.discount_desc;
        
        return oneCell;
    }
    if (indexPath.section == 2) {
        SGoodsInfor_first_fourCell * fourCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_fourCell" forIndexPath:indexPath];
        
        SAuctionAuctionInfo * infor = goods_common_attr[indexPath.row];
        fourCell.attr_name.text = infor.attr_name;
        fourCell.attr_value.text = infor.attr_value;
        
        return fourCell;
    }

    //猜你喜欢
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    
    //批量选择按钮
    mCell.choiceBtn.hidden = YES;
    mCell.top_oneView.hidden = NO;
    mCell.top_oneView_HHH.constant = 0;//0
    mCell.goodsImage_HHH.constant = 40;//40;
    mCell.top_twoView_HHH.constant = 40;//40;
    mCell.top_twoView.hidden = YES;
    mCell.integral_num.hidden = NO;//已售xx件
    
    mCell.goods_PriceView.hidden = NO;
    mCell.goods_priceHHH.constant = 30;//30
    
    mCell.carView.hidden = YES;
    mCell.carView_HHH.constant = 0;//70
    
    mCell.houseView.hidden = YES;
    mCell.houseView_HHH.constant = 0;//90
    
    mCell.redView.hidden = YES;
    mCell.redView_HHH.constant = 0;//30
    
    mCell.timeView.hidden = YES;
    mCell.timeView_HHH.constant = 0;//30
    mCell.blueView.hidden = YES;
    mCell.blueView_HHH.constant = 0;//30
    
    mCell.goodsImage.image = [UIImage imageNamed:@"商品详情样图"];
    mCell.top_oneImage.image = [UIImage imageNamed:@"首页国家"];
    
    
    SAuctionAuctionInfo * list = arr[indexPath.row];
    [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if ([list.ticket_buy_discount integerValue] == 0) {
        mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
        mCell.top_oneTitle.text = @"不可使用代金券";
    } else {
        mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
        mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
    }
    [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.goodsTitle.text = list.goods_name;
    mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
    mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
    mCell.integral_price.text = list.integral;
    mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
    
   
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 3) {
        SAuctionAuctionInfo * list = arr[indexPath.row];
        SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
        infor.goods_id = list.goods_id;
        [self.navigationController pushViewController:infor animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenW) {
        _moveTopBtn.hidden = NO;
    } else {
        _moveTopBtn.hidden = YES;
    }

    if (arr.count%2 == 0) {
        if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64) {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = NO;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 - 20 + 64) {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = NO;
            nav.threeLine.hidden = YES;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 - 20 + 64) {
            nav.oneLine.hidden = NO;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = YES;
            [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        }
    } else {
        if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64) {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = NO;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 - 20 + 64) {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = NO;
            nav.threeLine.hidden = YES;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 - 20 + 64) {
            nav.oneLine.hidden = NO;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = YES;
            [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        }
    }
    
    if (scrollView.contentOffset.y <= 0) {
        nav.oneLine.hidden = NO;
        nav.twoLine.hidden = YES;
        nav.threeLine.hidden = YES;
        [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    }
}
#pragma mark - 代金券
- (void)dj_ticketBtnClick {
    SPromotion_OPEN * open = [[SPromotion_OPEN alloc] init];
    open.modalPresentationStyle = UIModalPresentationOverFullScreen;
    open.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:open animated:YES completion:nil];
    [open showModel:dj_ticket andType:@"比价购" andClassType:@"代金券" andTypeContent:vouchers_desc];
    open.thisTitle.text = @"可使用代金券情况";
    open.SPromotion_OPEN_Back = ^{
        [open dismissViewControllerAnimated:YES completion:nil];
    };
}
#pragma mark - 配送地区
- (void)sendBtnClick {
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];

    DatePicker_Country * pick = [[DatePicker_Country alloc] init];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];

    pick.DatePicker_Country_Back = ^{
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.DatePicker_Country_Submit = ^(NSString *one, NSString *two, NSString *three, NSString *one_id, NSString *two_id, NSString *three_id) {
        //        _twoTF.text = @"";
        //        street = @"";
        //        street_id = @"";

        header2.send_Content.text = [NSString stringWithFormat:@"送至    %@%@%@",one,two,three];
        //        province = one;
        //        city = two;
        //        area = three;
        //        province_id = one_id;
        //        city_id = two_id;
        //        area_id = three_id;
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        now_province = one;
        now_city = two;
        now_area = three;
        [self freight_num];
    };
}
#pragma mark - 查看分类
- (void)lookTypeClick {
    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
    class_sub.cate_type = @"7";
    class_sub.two_cate_id = cate_id;
    class_sub.short_name = two_cate_name;
    class_sub.class_num = 0;
    [self.navigationController pushViewController:class_sub animated:YES];
}
#pragma mark - 进店逛逛
- (void)shopAroundClick {
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = merchant_id;
    [self.navigationController pushViewController:infor animated:YES];
}
#pragma mark - 立即抢拍
- (void)leftBtnBlock {
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
    SAuctionOrderAuct * auct = [[SAuctionOrderAuct alloc] init];
    auct.auction_id = _auction_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [auct sAuctionOrderAuctSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SAuctionOrderAuct * auct = (SAuctionOrderAuct *)data;
        if ([auct.data.auc_type isEqualToString:@"1"]) {
            SLotInfor_submit * submit = [[SLotInfor_submit alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [[[UIApplication sharedApplication] keyWindow] addSubview:submit];
            submit.down_HHH.constant = 321;
            submit.SLotInfor_submit_back = ^{
                [submit removeFromSuperview];
            };
            submit.SLotInfor_submit_payMoney = ^(NSString *payMoney) {
                [submit removeFromSuperview];
                if ([payMoney floatValue] < [auct.data.min_price floatValue]) {
                    [MBProgressHUD showError:[NSString stringWithFormat:@"现在竞拍价最低%@",auct.data.min_price] toView:self.view];
                    return ;
                }
                SAuctionOrderSetOrder * setOrder = [[SAuctionOrderSetOrder alloc] init];
                setOrder.address_id = @"";
                setOrder.auction_id = _auction_id;
                setOrder.buy_type = @"1";
                setOrder.bid = auct.data.min_price;
                setOrder.order_id = @"";
                setOrder.freight = @"";
                setOrder.freight_type = @"";
                [MBProgressHUD showMessage:nil toView:self.view];
                [setOrder sAuctionOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([code isEqualToString:@"1"]) {
                        [MBProgressHUD showSuccess:message toView:self.view];
                    } else {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
            };
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SPay * pay = [[SPay alloc] init];
                pay.order_id = auct.data.order_id;
                pay.base_money = auct.data.base_money;
                pay.base_balance = auct.data.base_balance;
                pay.base_merchant_name = auct.data.merchant_name;
                pay.model_type = @"比价购保证金";
                [self.navigationController pushViewController:pay animated:YES];
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma mark - 一口价
- (void)rightBtnBlock {
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
    SOrderConfirm * com = [[SOrderConfirm alloc] init];
    com.special_type = @"比价购";
    com.merchant_id = model_merchant_id;
    com.auction_id = _auction_id;
    com.auction_isno = YES;
    com.goods_id = @"";//就要这么写，不走cart_id循环
    [self.navigationController pushViewController:com animated:YES];
}
- (IBAction)messBtn:(UIButton *)sender {
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
    
    SHyphenateList * list = [[SHyphenateList alloc] init];
    list.merchant_id = merchant_id;
    if (merchant_id == nil) {
        [MBProgressHUD showError:@"商家id错误" toView:self.view];
        return;
    }
    list.modalPresentationStyle = UIModalPresentationOverFullScreen;
    list.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:list animated:YES completion:nil];
    list.SHyphenateList_choice = ^(NSString *header_pic, NSString *nickname, NSString *hx) {
        SUserUserCenter * center = [[SUserUserCenter alloc] init];
        [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserUserCenter * center = (SUserUserCenter *)data;
                
                //环信ID:@"8001"
                //聊天类型:EMConversationTypeChat
                EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:hx conversationType:EMConversationTypeChat];
                chatController.title = nickname;
                chatController.nickname_mine = center.data.nickname;
                chatController.pic_mine = center.data.head_pic;
                chatController.nickname_other = nickname;
                chatController.pic_other = header_pic;
                [self.navigationController pushViewController:chatController animated:YES];
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    };
}
- (IBAction)remindBtn:(UIButton *)sender {
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
    SAuctionRemindMe * remind = [[SAuctionRemindMe alloc] init];
    remind.auction_id = _auction_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [remind sAuctionRemindMeSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
@end
