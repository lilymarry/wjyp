//
//  SGoodsInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor.h"
#import "SGoodsInfor_nav.h"
#import "SGoodsInforCell1.h"
#import "SGoodsInforCell2.h"
#import "SGoodsInforCell3.h"
#import "SGoodsInforCell4.h"
#import "SGoodsInforCell5.h"
#import "SNBannerView.h"
#import "SGoodsInfor_top.h"
#import "SGoodsInfor_se0_footer.h"
#import "SGoodsInfor_se1_footer.h"
#import "SGoodsInfor_se3_footer.h"
#import "SGoodsInfor_down.h"
#import<WebKit/WebKit.h>
#import "SEvaAll.h"
#import "SShopCar_editView.h"
#import "AShare.h"
#import "SShopAround.h"
#import "SShopCar.h"
#import "SOrderConfirm.h"
#import "SOnlineShopInfor.h"

#import "SLimitBuyLimitBuyInfo.h"//限量购详情
#import "STicketBuyTicketBuyInfo.h"//票券区详情
#import "SGoodsGoodsInfo.h"//商品详情
#import "SIntegralBuyIntegralBuyInfo.h"//无界商店
#import "SGroupBuyGroupBuyInfo.h"//拼团购
#import "SPreBuyPreBuyInfo.h"//无界预购
#import "SCountryGoodsInfo.h"//进口馆
#import "SCarBuyCarInfo.h"//汽车购
//倒计时
#import "OYCountDownManager.h"
#import "SUserCollectAddCollect.h"//收藏
#import "SUserCollectDelOneCollect.h"//取消收藏
#import "SFightGroups.h"//拼购购：单独购买、一键开团详情
#import "SUserUserCenter.h"

#import "SCarConfirm.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

@interface SGoodsInfor () <UITableViewDelegate,UITableViewDataSource,SNBannerViewDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    SGoodsInfor_nav * nav;//顶部(商品、详情、评价)View
    BOOL collect_isno;//YES收藏
    UIButton * rightBtn_sub;//收藏按钮
    SGoodsInfor_down * down;//Footer
    WKWebView * wk_web;//极速web
    BOOL open1;//促销  YES收起
    NSArray * open1_arr;
    BOOL open2;//无界优品 YES收起
    BOOL open3;//服务 YES收起
    
    SGoodsInfor_top * top;
    NSInteger secondsCountDown;//倒计时总时长
    NSTimer *countDownTimer;
    NSInteger secondsCountDown_sub;//倒计时总时长
    NSTimer *countDownTimer_sub;
    NSString *format_time;
    
    SGoodsInfor_se3_footer  * se3_footer;
    BOOL se3_footerMer_isno;//YES隐藏商店信息 默认360

    
    NSArray * goods_common_attr;//产品规格列表
    
    CGFloat thisContent_HHH;//文字详情高度
    
    NSArray * group_arr;//团购
    
    NSString * merchant_id;//店铺id
    NSString * merchant_name;//店铺名称
    NSString * merchant_logo;//店铺logo
    NSString * merchant_easemob;//店铺环信账号
    NSString * model_goods_id;//商品id
    
    NSString * share_url;//分享链接
    NSString * share_img;//"分享图片",
    NSString * share_title;//分享标题
    NSString * share_content;//"分享内容"
    
    NSInteger eva_num;
    NSInteger evaImage_num;
    
    NSString * model_car_id;
    NSString * model_car_img;
    NSString * model_car_name;
    NSString * model_pre_money;
    NSString * model_all_price;
    NSString * model_true_pre_money;
 
    CGFloat wk_num;
    
    NSString * inforComment_num;
}
@property (strong, nonatomic) IBOutlet UILabel *shopNum;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIButton *moveTopBtn;

@property (strong, nonatomic) IBOutlet UIButton *car_oneBtn;//加入购物车
@property (strong, nonatomic) IBOutlet UIButton *car_twoBtn;//立即购买
@end

@implementation SGoodsInfor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
}
- (void)viewWillDisappear:(BOOL)animated {
    [countDownTimer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self showModel];
}
static CGRect extracted(SIntegralBuyIntegralBuyInfo *infor) {
    return [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
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
//    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    
    
    rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn_sub setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
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
    [nav.threeBtn setTitle:@"详情" forState:UIControlStateNormal];
    //默认商品选中
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //购物车个数
    _shopNum.layer.masksToBounds = YES;
    _shopNum.layer.cornerRadius = 7.5;
    _shopNum.hidden = YES;
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsInforCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsInforCell1"];
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsInforCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsInforCell2"];
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsInforCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsInforCell3"];
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsInforCell4" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsInforCell4"];
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsInforCell5" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsInforCell5"];
    
    //Header
    top = [[SGoodsInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW + 40 + 60 + 50 + 50 + 50 + 70 + 10 + 100 + 10)];
    _mTable.tableHeaderView = top;
    
    
    
    NSMutableAttributedString * attributedStr_left = [[NSMutableAttributedString alloc]initWithString:@"已预购580件"];
    [attributedStr_left addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, 3)];
    top.pro_leftTitle.attributedText = attributedStr_left;
    
    NSMutableAttributedString * attributedStr_right = [[NSMutableAttributedString alloc]initWithString:@"已抢419件/剩余56件"];
    [attributedStr_right addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9, 2)];
    top.pro_rigthTitle.attributedText = attributedStr_right;
   
    NSMutableAttributedString * attributedStr_cityPrice = [[NSMutableAttributedString alloc]initWithString:@"进口税  50元/件"];
    [attributedStr_cityPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 2)];
    top.cityPrice.attributedText = attributedStr_cityPrice;
    
    
    //Footer
    se3_footer = [[SGoodsInfor_se3_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 360)];
    
    down = [[SGoodsInfor_down alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50 + 200)];
    _mTable.tableFooterView = down;
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    wk_web.userInteractionEnabled = NO;
    wk_web.navigationDelegate = self;
    [down.wk_web addSubview:wk_web];
    
    
    //置顶
    _moveTopBtn.hidden = YES;
    [_moveTopBtn addTarget:self action:@selector(moveTopBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showModel {
    if ([_goods_type isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = [[SLimitBuyLimitBuyInfo alloc] init];
        infor.limit_buy_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sLimitBuyLimitBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SLimitBuyLimitBuyInfo * infor = (SLimitBuyLimitBuyInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                secondsCountDown = [infor.data.goodsInfo.end_time integerValue] - time(NULL);//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
                
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.limit_price;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.pro_leftTitle.hidden = YES;
                [top.proBlue setProgress:[infor.data.goodsInfo.sell_num floatValue]/([infor.data.goodsInfo.sell_num floatValue] + [infor.data.goodsInfo.limit_store floatValue])];
                top.proBlue_num.text = [NSString stringWithFormat:@"%.0f%%",[infor.data.goodsInfo.sell_num floatValue]/([infor.data.goodsInfo.sell_num floatValue] + [infor.data.goodsInfo.limit_store floatValue]) * 100];
                NSMutableAttributedString * attributedStr_right = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已抢%@件/剩余%@件",infor.data.goodsInfo.sell_num,infor.data.goodsInfo.limit_store]];
                [attributedStr_right addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6 + infor.data.goodsInfo.sell_num.length, infor.data.goodsInfo.limit_store.length)];
                top.pro_rigthTitle.attributedText = attributedStr_right;
                if ([infor.data.goodsInfo.country_id isEqualToString:@"0"]) {
                    top.country_logo.hidden = YES;
                } else {
                    top.country_logo.hidden = NO;
                }
                [top.country_logo sd_setImageWithURL:[NSURL URLWithString:infor.data.goodsInfo.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                top.country_desc.text = infor.data.goodsInfo.country_desc;
                NSMutableAttributedString * attributedStr_cityPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"进口税  %@元/件",infor.data.goodsInfo.country_tax]];
                [attributedStr_cityPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, infor.data.goodsInfo.country_tax.length)];
                top.cityPrice.attributedText = attributedStr_cityPrice;
                
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 40 + 60 + 50 + 70 + 10 + 100 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"票券区"]) {
        STicketBuyTicketBuyInfo * infor = [[STicketBuyTicketBuyInfo alloc] init];
        infor.ticket_buy_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sTicketBuyTicketBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                STicketBuyTicketBuyInfo * infor = (STicketBuyTicketBuyInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.shop_price;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                top.canR.text = [NSString stringWithFormat:@"最多可用%@%%代金券",infor.data.goodsInfo.ticket_buy_discount];
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 50 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"商品详情"]) {
        SGoodsGoodsInfo * infor = [[SGoodsGoodsInfo alloc] init];
        infor.goods_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sGoodsGoodsInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SGoodsGoodsInfo * infor = (SGoodsGoodsInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.shop_price;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = [[SIntegralBuyIntegralBuyInfo alloc] init];
        infor.integral_buy_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sIntegralBuyIntegralBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SIntegralBuyIntegralBuyInfo * infor = (SIntegralBuyIntegralBuyInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = [NSString stringWithFormat:@"兑换需要%@积分",infor.data.goodsInfo.use_integral];
                top.oldPrice.hidden = YES;
                top.oldPrice_Line.hidden = YES;
                top.songR.hidden = YES;
                top.integral.hidden = YES;
                top.integral_title.hidden = YES;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = extracted(infor).size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"拼团购"]) {
        
        // 启动倒计时管理
        [kCountDownManager start];
        
        SGroupBuyGroupBuyInfo * infor = [[SGroupBuyGroupBuyInfo alloc] init];
        infor.group_buy_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sGroupBuyGroupBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SGroupBuyGroupBuyInfo * infor = (SGroupBuyGroupBuyInfo *)data;
                [_car_oneBtn setTitle:[NSString stringWithFormat:@"￥%@\n单独购买",infor.data.one_price] forState:UIControlStateNormal];
                [_car_twoBtn setTitle:[NSString stringWithFormat:@"￥%@\n一键拼单",infor.data.group_price] forState:UIControlStateNormal];
                
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.shop_price;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                top.canR.text = [NSString stringWithFormat:@" 最多可用%@%%代金券",infor.data.goodsInfo.ticket_buy_discount];
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 50 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                group_arr = infor.data.group;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                
                //倒计时
                [kCountDownManager reload];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"无界预购"]) {
        
        // 启动倒计时管理
        [kCountDownManager start];
        
        SPreBuyPreBuyInfo * infor = [[SPreBuyPreBuyInfo alloc] init];
        infor.pre_buy_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sPreBuyPreBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SPreBuyPreBuyInfo * infor = (SPreBuyPreBuyInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                secondsCountDown = [infor.data.goodsInfo.end_time integerValue] - time(NULL);//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
                
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.deposit;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                NSMutableAttributedString * attributedStr_left = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已预购%@件",infor.data.goodsInfo.sell_num]];
                [attributedStr_left addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3 , infor.data.goodsInfo.sell_num.length)];
                top.pro_leftTitle.attributedText = attributedStr_left;
                [top.proBlue setProgress:[infor.data.goodsInfo.sell_num floatValue]/[infor.data.goodsInfo.pre_store floatValue]];
                top.proBlue_num.text = [NSString stringWithFormat:@"%.0f%%",[infor.data.goodsInfo.sell_num floatValue]/[infor.data.goodsInfo.pre_store floatValue] * 100];
                
                top.pro_rigthTitle.text = [NSString stringWithFormat:@"满%@件即可发布",infor.data.goodsInfo.pre_store];
                
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 40 + 60 + 50 + 70 + 10);
                _mTable.tableHeaderView = top;
                open1_arr = infor.data.promotion;
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                
                //倒计时
                [kCountDownManager reload];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"进口馆"]) {
        SCountryGoodsInfo * infor = [[SCountryGoodsInfo alloc] init];
        infor.goods_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sCountryGoodsInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SCountryGoodsInfo * infor = (SCountryGoodsInfo *)data;
                model_goods_id = infor.data.goodsInfo.goods_id;
                merchant_id = infor.data.mInfo.merchant_id;
                merchant_name = infor.data.mInfo.merchant_name;
                merchant_logo = infor.data.mInfo.logo;
                merchant_easemob = infor.data.mInfo.easemob_account;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.goodsInfo.goods_name;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                secondsCountDown = [infor.data.goodsInfo.end_time integerValue] - time(NULL);//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                top.daiR.hidden = YES;
                top.nowPriceR_WWW.constant = 10;
                top.nowPrice.text = infor.data.goodsInfo.shop_price;
                top.oldPrice.text = infor.data.goodsInfo.market_price;
                top.integral.text = infor.data.goodsInfo.integral;
                top.goods_name.text = infor.data.goodsInfo.goods_name;
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                top.sixView.hidden = YES;
                top.sixView_HHH.constant = 0;
                top.pro_leftTitle.hidden = YES;
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                
                if ([infor.data.goodsInfo.country_id isEqualToString:@"0"]) {
                    top.country_logo.hidden = YES;
                } else {
                    top.country_logo.hidden = NO;
                }
                [top.country_logo sd_setImageWithURL:[NSURL URLWithString:infor.data.goodsInfo.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                top.country_desc.text = infor.data.goodsInfo.country_desc;
                NSMutableAttributedString * attributedStr_cityPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"进口税  %@元/件",infor.data.goodsInfo.country_tax]];
                [attributedStr_cityPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, infor.data.goodsInfo.country_tax.length)];
                top.cityPrice.attributedText = attributedStr_cityPrice;
                
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 10 + 100 + 10);
                _mTable.tableHeaderView = top;
                
                open1_arr = infor.data.promotion;
                
                
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment.total];
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.comment.body.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = infor.data.comment.body.nickname;
                se3_footer.content.text = infor.data.comment.body.content;
                
                [se3_footer.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.mInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.merchant_name.text = infor.data.mInfo.merchant_name;
                for (UIView * view in se3_footer.starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mInfo.level integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [se3_footer.starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"皇冠"];
                }
                se3_footer.all_goods.text = infor.data.mInfo.all_goods;
                se3_footer.view_num.text = infor.data.mInfo.view_num;
                
                
                NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",infor.data.mInfo.goods_score]];
                [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.goods_score.length)];
                se3_footer.num1.attributedText = attributedStr1;
                
                NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",infor.data.mInfo.merchant_score]];
                [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.merchant_score.length)];
                se3_footer.num2.attributedText = attributedStr2;
                
                NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",infor.data.mInfo.shipping_score]];
                [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, infor.data.mInfo.shipping_score.length)];
                se3_footer.num3.attributedText = attributedStr3;
                
                goods_common_attr = infor.data.goods_common_attr;
                
                down.thisContent.text = infor.data.goodsInfo.goods_brief;
                CGSize size = [infor.data.goodsInfo.goods_brief boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.goodsInfo.goods_desc baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_goods_type isEqualToString:@"汽车购"]) {
        
        SCarBuyCarInfo * infor = [[SCarBuyCarInfo alloc] init];
        infor.car_id = _goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sCarBuyCarInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SCarBuyCarInfo * infor = (SCarBuyCarInfo *)data;
                rightBtn_sub.hidden = YES;
                
                if ([infor.data.cart_num integerValue] == 0) {
                    _shopNum.hidden = YES;
                } else {
                    _shopNum.hidden = NO;
                    _shopNum.text = infor.data.cart_num;
                }
                
                model_car_id = infor.data.car_info.car_id;
                model_car_img = infor.data.car_info.car_img;
                model_car_name = infor.data.car_info.car_name;
                model_pre_money = infor.data.car_info.pre_money;
                model_all_price = infor.data.car_info.all_price;
                model_true_pre_money = infor.data.car_info.true_pre_money;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_title = infor.data.car_info.car_name;
                share_content = infor.data.share_content;
                
                merchant_name = infor.data.server_name;
                merchant_logo = infor.data.server_head_pic;
                merchant_easemob = infor.data.easemob_account;
                
                SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.car_info.banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
                [top.bannerView addSubview:banner];
                
                top.twoView.hidden = YES;
                top.twoView_HHH.constant = 0;
                
                top.nowPrice.text = infor.data.car_info.pre_money;
                top.oldPrice.hidden = YES;
                top.oldPrice_Line.hidden = YES;
                top.integral.text = infor.data.car_info.integral;
                top.goods_name.text = infor.data.car_info.car_name;
                top.fiveView.hidden = YES;
                top.fiveView_HHH.constant = 0;
                
                top.true_pre_money.text = [NSString stringWithFormat:@"可抵￥%@车款",infor.data.car_info.true_pre_money];
                top.all_price.text = [NSString stringWithFormat:@"车全价￥%@",infor.data.car_info.all_price];
                
                top.sevenView.hidden = YES;
                top.sevenView_HHH.constant = 0;
                top.eightView.hidden = YES;
                top.eightView_HHH.constant = 0;
                
                
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 60 + 50 + 50);
                _mTable.tableHeaderView = top;
                
                eva_num = 0;
                
                if ([infor.data.comment_num integerValue] == 0) {
                    se3_footer.evaNumView.hidden = YES;
                    se3_footer.evaContentView.hidden = YES;
                    se3_footer.evaNumView_topHHH.constant = 0;
                    se3_footer.evaNumView_HHH.constant = 0;
                    se3_footer.evaContentViewHHH.constant = 0;
                    eva_num = 180;
                }
                SCarBuyCarInfo * evaInfor = infor.data.comment_new.firstObject;
                se3_footer.total.text = [NSString stringWithFormat:@"商品评价（%@）",infor.data.comment_num];
                inforComment_num = infor.data.comment_num;
                [se3_footer.headerImage sd_setImageWithURL:[NSURL URLWithString:evaInfor.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                se3_footer.nickname.text = evaInfor.nickname;
                se3_footer.content.text = evaInfor.content;
                if (evaInfor.pictures_arr.count == 0) {
                    
                    evaImage_num = 60;
                    se3_footer.evaContentViewHHH.constant = 140 - 60;
                } else {
                    evaImage_num = 0;
                    SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 60)];
                    [se3_footer.eva_conentImageView addSubview:con];
                    [con showModel:evaInfor.pictures_arr andPriceShow:NO andType:@"SCarBuyCarInfo"];
                }
                
                se3_footer.frame = CGRectMake(0, 0, ScreenW, 430 - 180 - 10 - eva_num - evaImage_num);
                
                
                se3_footer.merView.hidden = YES;
                se3_footer.merView_HHH.constant = 0;
                se3_footer.downView_HHH.constant = 0;
                se3_footerMer_isno = YES;
                
                
                goods_common_attr = infor.data.attr;
                
                down.thisContent.text = infor.data.car_info.car_desc;
                CGSize size = [infor.data.car_info.car_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                if (size.height <= 40) {
                    thisContent_HHH = 40;
                    down.thisContentView_HHH.constant = 60 + 40;
                } else {
                    thisContent_HHH = size.height + 10;
                    down.thisContentView_HHH.constant = 60 + size.height + 10;
                }
                
                [wk_web loadHTMLString:infor.data.car_info.content baseURL:nil];
                [_mTable reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    
}
-(void) countDownAction{
    //倒计时-1
    secondsCountDown--;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    [countDownTimer_sub invalidate];
    secondsCountDown_sub = 99;//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
    countDownTimer_sub = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countDownAction_sub) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
    
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown<=0){
        [countDownTimer invalidate];
    }
}
- (void)countDownAction_sub {
    secondsCountDown_sub--;
    //修改倒计时标签现实内容
    top.end_time.text=[NSString stringWithFormat:@"距离本场结束 %@:%@",format_time,[NSString stringWithFormat:@"%02ld",secondsCountDown_sub]];
    
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
//        NSLog(@"图文详情高度:%f",heightStr.floatValue);
        
        wk_num = heightStr.floatValue;
        wk_web.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue + 15);
        down.frame = CGRectMake(0, 0, ScreenW, 60 + thisContent_HHH + 50 + heightStr.floatValue + 15);
        _mTable.tableFooterView = down;
        
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _mTable) {
        if (scrollView.contentOffset.y > ScreenW) {
            _moveTopBtn.hidden = NO;
        } else {
            _moveTopBtn.hidden = YES;
        }

        
        if (scrollView.contentOffset.y < ScreenW + 160) {
            //商品
            [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
            nav.oneLine.hidden = NO;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = YES;
        } else if (scrollView.contentOffset.y >= ScreenW + 160 && scrollView.contentOffset.y < _mTable.contentSize.height  - wk_num - 50 - 1) {
            //评价
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = NO;
            nav.threeLine.hidden = YES;
        } else if (scrollView.contentOffset.y >= _mTable.contentSize.height - wk_num - 50 - 1) {
            //详情
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = NO;
            
        }
    }
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 置顶
- (void)moveTopBtnClick {
    [_mTable setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark - 商品
- (void)oneBtnClick {

    [_mTable setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark - 评价
- (void)twoBtnClick {
    [_mTable setContentOffset:CGPointMake(0, ScreenW + 160) animated:YES];

}
#pragma mark - 详情
- (void)threeBtnClick {
    [_mTable setContentOffset:CGPointMake(0, _mTable.contentSize.height - wk_num - 50) animated:YES];
}


#pragma mark - 分享
- (void)rightBtnClick {
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
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
    shareVC.id_val = model_goods_id;
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
        collect.id_val = model_goods_id;
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
        delCollect.id_val = model_goods_id;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if ([_goods_type isEqualToString:@"限量购"]||[_goods_type isEqualToString:@"票券区"]||[_goods_type isEqualToString:@"商品详情"]||[_goods_type isEqualToString:@"拼团购"]||[_goods_type isEqualToString:@"无界预购"]||[_goods_type isEqualToString:@"进口馆"]) {
            if (open1 == YES) {
                return 1;
            }
            return open1_arr.count;
        }
        if ([_goods_type isEqualToString:@"汽车购"]) {
            return 0;
        }
        if (open1 == YES) {
            return 1;
        }
        return 2;
    }
    if (section == 1) {
        if (open2 == YES) {
            return 0;
        }
        if ([_goods_type isEqualToString:@"汽车购"]) {
            return 0;
        }
        return 5;
    }
    if (section == 2) {
        if (open3 == YES) {
            return 1;
        }
        if ([_goods_type isEqualToString:@"汽车购"]) {
            return 0;
        }
        return 5;
    }
    if (section == 3) {
        if ([_goods_type isEqualToString:@"限量购"]||[_goods_type isEqualToString:@"票券区"]||[_goods_type isEqualToString:@"商品详情"]||[_goods_type isEqualToString:@"无界预购"]||[_goods_type isEqualToString:@"进口馆"]||[_goods_type isEqualToString:@"汽车购"]) {
            return 0;
        }
        if ([_goods_type isEqualToString:@"拼团购"]) {
            return group_arr.count;
        }
        return 2;
    }
    if (section == 4) {
        if ([_goods_type isEqualToString:@"限量购"]||[_goods_type isEqualToString:@"票券区"]||[_goods_type isEqualToString:@"商品详情"]||[_goods_type isEqualToString:@"拼团购"]||[_goods_type isEqualToString:@"无界预购"]||[_goods_type isEqualToString:@"进口馆"]||[_goods_type isEqualToString:@"汽车购"]) {
            return goods_common_attr.count;
        }
        return 5;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        if ([_goods_type isEqualToString:@"限量购"]||[_goods_type isEqualToString:@"票券区"]||[_goods_type isEqualToString:@"商品详情"]||[_goods_type isEqualToString:@"无界预购"]||[_goods_type isEqualToString:@"进口馆"]||[_goods_type isEqualToString:@"汽车购"]) {
            return 0.01;
        }
        return 60;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        if ([_goods_type isEqualToString:@"限量购"]||[_goods_type isEqualToString:@"票券区"]||[_goods_type isEqualToString:@"商品详情"]||[_goods_type isEqualToString:@"无界预购"]||[_goods_type isEqualToString:@"进口馆"]||[_goods_type isEqualToString:@"汽车购"]) {
            return nil;
        }
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
        header.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 50)];
        [header addSubview:titleView];
        titleView.backgroundColor = [UIColor whiteColor];
        
        UILabel * thisTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 50)];
        [titleView addSubview:thisTitle];
        thisTitle.text = @"别人在拼单";
        thisTitle.font = [UIFont systemFontOfSize:15];
        thisTitle.textColor = WordColor;
        
        UIView * header_line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenW, 0.5)];
        [titleView addSubview:header_line];
        header_line.backgroundColor = MyLine;
        
        return header;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (se3_footerMer_isno == YES) {
            return 0.01;
        }
        return 190;
    } else if (section == 1) {
        if (se3_footerMer_isno == YES) {
            return 0.01;
        }
        return 60;
    } else if (section == 3) {
        if (se3_footerMer_isno == YES) {
            return 430 - 180 - 10 - eva_num - evaImage_num;
        }
        return 360 - eva_num;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (se3_footerMer_isno == YES) {
            return nil;
        }
        SGoodsInfor_se0_footer * footer = [[SGoodsInfor_se0_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 190)];
        if (open2 == YES) {
            [footer.rightBtn setImage:[UIImage imageNamed:@"灰色下箭头"] forState:UIControlStateNormal];
        } else {
            [footer.rightBtn setImage:[UIImage imageNamed:@"灰色上箭头"] forState:UIControlStateNormal];
        }
        [footer.rightBtn addTarget:self action:@selector(showOpen_2Click) forControlEvents:UIControlEventTouchUpInside];
        //选择商品规格、类型
        [footer.choiceType addTarget:self action:@selector(choiceTypeClick) forControlEvents:UIControlEventTouchUpInside];
        
        return footer;
    } else if (section == 1) {
        if (se3_footerMer_isno == YES) {
            return nil;
        }
        SGoodsInfor_se1_footer * footer = [[SGoodsInfor_se1_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"运费10元"];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 2)];
        footer.freightPrice.attributedText = attributedStr;
        
        
        return footer;
    } else if (section == 3) {
        
//        NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:@"宝贝描述4.7"];
//        [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 3)];
//        se3_footer.num1.attributedText = attributedStr1;
//        
//        NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:@"卖家服务4.8"];
//        [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 3)];
//        se3_footer.num2.attributedText = attributedStr2;
//        
//        NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:@"物流服务4.8"];
//        [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 3)];
//        se3_footer.num3.attributedText = attributedStr3;
        
        //全部评价
        [se3_footer.allEvaBtn addTarget:self action:@selector(allEvaBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //进店逛逛
        [se3_footer.twoBtn addTarget:self action:@selector(shopAroundClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        return se3_footer;
    }
    return nil;
}
#pragma mark - 选择商品规格、类型
- (void)choiceTypeClick {
    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
    editView.SShopCar_editView_back = ^{
        [editView removeFromSuperview];
    };
    editView.SShopCar_editView_submit = ^{
        [editView removeFromSuperview];
    };
}
#pragma mark - 全部评价(45)
- (void)allEvaBtnClick {
    SEvaAll * eva = [[SEvaAll alloc] init];
    eva.car_id = _goods_id;
    eva.inforComment_num = inforComment_num;
    [self.navigationController pushViewController:eva animated:YES];
}
#pragma mark - 进店逛逛
- (void)shopAroundClick {
//    SShopAround * around = [[SShopAround alloc] init];
//    [self.navigationController pushViewController:around animated:YES];
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = merchant_id;
    [self.navigationController pushViewController:infor animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([_goods_type isEqualToString:@"限量购"]) {
            if (open1 == YES) {
                SLimitBuyLimitBuyInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                SLimitBuyLimitBuyInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
            
        }
        if ([_goods_type isEqualToString:@"票券区"]) {
            if (open1 == YES) {
                STicketBuyTicketBuyInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                STicketBuyTicketBuyInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
            
        }
        if ([_goods_type isEqualToString:@"商品详情"]) {
            if (open1 == YES) {
                SGoodsGoodsInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                SGoodsGoodsInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
            
        }
        if ([_goods_type isEqualToString:@"拼团购"]) {
            if (open1 == YES) {
                SGroupBuyGroupBuyInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                SGroupBuyGroupBuyInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
        }
        if ([_goods_type isEqualToString:@"无界预购"]) {
            if (open1 == YES) {
                SPreBuyPreBuyInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                SPreBuyPreBuyInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
        }
        if ([_goods_type isEqualToString:@"进口馆"]) {
            if (open1 == YES) {
                SCountryGoodsInfo * infor = open1_arr.firstObject;
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            } else {
                SCountryGoodsInfo * infor = open1_arr[indexPath.row];
                CGSize size = [infor.title boundingRectWithSize:CGSizeMake(ScreenW - 95, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                if (size.height <= 50) {
                    return 50;
                } else {
                    return 70;
                }
            }
        }
    }
    if (indexPath.section == 3) {
        return 70;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SGoodsInforCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsInforCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.leftTitle.hidden = NO;
            cell.rightBtn.hidden = NO;
        } else {
            cell.leftTitle.hidden = YES;
            cell.rightBtn.hidden = YES;
        }
        
        if (open1 == YES) {
            [cell.rightBtn setImage:[UIImage imageNamed:@"灰色下箭头"] forState:UIControlStateNormal];
            if ([_goods_type isEqualToString:@"限量购"]) {
                SLimitBuyLimitBuyInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"票券区"]) {
                STicketBuyTicketBuyInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"商品详情"]) {
                SGoodsGoodsInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"拼团购"]) {
                SGroupBuyGroupBuyInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"无界预购"]) {
                SPreBuyPreBuyInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"进口馆"]) {
                SCountryGoodsInfo * infor = open1_arr.firstObject;
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            
        } else {
            [cell.rightBtn setImage:[UIImage imageNamed:@"灰色上箭头"] forState:UIControlStateNormal];
            
            if ([_goods_type isEqualToString:@"限量购"]) {
                SLimitBuyLimitBuyInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"票券区"]) {
                STicketBuyTicketBuyInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"商品详情"]) {
                SGoodsGoodsInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"拼团购"]) {
                SGroupBuyGroupBuyInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"无界预购"]) {
                SPreBuyPreBuyInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
            if ([_goods_type isEqualToString:@"进口馆"]) {
                SCountryGoodsInfo * infor = open1_arr[indexPath.row];
                if ([infor.type isEqualToString:@"1"]) {
                    cell.manR.backgroundColor = MyBlue;
                    cell.manR.text = @"满减";
                } else {
                    cell.manR.backgroundColor = MyPowder;
                    cell.manR.text = @"满折";
                }
                cell.thisTitle.text = infor.title;
            }
        }
        [cell.rightBtn addTarget:self action:@selector(showOpen_1Click) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else if (indexPath.section == 1) {
        SGoodsInforCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsInforCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"南开华苑站 库存15 距您15km"];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 2)];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 4)];
        cell.thistitle.attributedText = attributedStr;
        
        return cell;

    } else if (indexPath.section == 2) {
        SGoodsInforCell3 * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsInforCell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.left_title.hidden = NO;
            cell.rightBtn.hidden = NO;
        } else {
            cell.left_title.hidden = YES;
            cell.rightBtn.hidden = YES;
        }
        if (open3 == YES) {
            [cell.rightBtn setImage:[UIImage imageNamed:@"灰色下箭头"] forState:UIControlStateNormal];
        } else {
            [cell.rightBtn setImage:[UIImage imageNamed:@"灰色上箭头"] forState:UIControlStateNormal];
        }
        [cell.rightBtn addTarget:self action:@selector(showOpen_3Click) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section == 3) {
        SGoodsInforCell4 * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsInforCell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([_goods_type isEqualToString:@"拼团购"]) {
            SGroupBuyGroupBuyInfo * list = group_arr[indexPath.row];
            [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_user.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.nickname.text = list.head_user.nickname;
            cell.model = group_arr[indexPath.row];
        }
        
        return cell;
    }
    SGoodsInforCell5 * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsInforCell5" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_goods_type isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"票券区"]) {
        STicketBuyTicketBuyInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"商品详情"]) {
        SGoodsGoodsInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"拼团购"]) {
        SGroupBuyGroupBuyInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"进口馆"]) {
        SCountryGoodsInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_value;
    }
    if ([_goods_type isEqualToString:@"汽车购"]) {
        SCarBuyCarInfo * infor = goods_common_attr[indexPath.row];
        cell.one.text = infor.attr_name;
        cell.two.text = infor.attr_val;
    }

    return cell;
}
#pragma mark - 促销收起
- (void)showOpen_1Click {
    if (open1 == NO) {
        open1 = YES;
    } else {
        open1 = NO;
    }
    [_mTable reloadData];
}
#pragma mark - 无界驿站收起
- (void)showOpen_2Click {
    if (open2 == NO) {
        open2 = YES;
    } else {
        open2 = NO;
    }
    [_mTable reloadData];
}
#pragma mark - 服务收起
- (void)showOpen_3Click {
    if (open3 == NO) {
        open3 = YES;
    } else {
        open3 = NO;
    }
    [_mTable reloadData];
}
#pragma mark - 回首页
- (IBAction)backHomeBtn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 前往购物车
- (IBAction)goCar:(UIButton *)sender {
    SShopCar * shopCar = [[SShopCar alloc] init];
    shopCar.type = YES;
    [self.navigationController pushViewController:shopCar animated:YES];
}
#pragma mark - 联系客服
- (IBAction)goMessage:(id)sender {
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
#pragma mark - 加入购物车
- (IBAction)addCar:(UIButton *)sender {
    if ([_goods_type isEqualToString:@"拼团购"]) {
        SFightGroups * group = [[SFightGroups alloc] init];
        [self.navigationController pushViewController:group animated:YES];
    }
}
#pragma mark - 立即购买
- (IBAction)pay_submitBtn:(UIButton *)sender {
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
    SCarConfirm * confirm = [[SCarConfirm alloc] init];
    confirm.model_car_id = model_car_id;
    confirm.model_car_img = model_car_img;
    confirm.model_car_name = model_car_name;
    confirm.model_pre_money = model_pre_money;
    confirm.model_all_price = model_all_price;
    confirm.model_true_pre_money = model_true_pre_money;
    [self.navigationController pushViewController:confirm animated:YES];
}

@end
