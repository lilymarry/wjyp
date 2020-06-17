//
//  SGoodsInfor_first.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#define Random10To20 (arc4random() % 11) + 10//生成10~20的随机数

#import "SGoodsInfor_first.h"
#import "SGoodsInfor_nav.h"
#import "SGoodsInfor_firstView.h"
#import "QGoodsInfor_first_header0Reusa.h"
#import "QGoodsInfor_first_header1Reusa.h"
#import "QGoodsInfor_first_header2Reusa.h"
#import "QGoodsInfor_first_header3Reusa.h"
#import "QGoodsInfor_first_header3_evaCollect.h"
#import "SGoodsInfor_first_zeroCell.h"
#import "SGoodsInfor_first_oneCell.h"
#import "SGoodsInfor_first_twoCell.h"
#import "SGoodsInfor_first_threeCell.h"
#import "SGoodsInfor_first_fourCell.h"
#import "SOnlineShopCell.h"
#import "QGoodsInfor_first_groupCell.h"

#import "SGoodsGoodsInfo.h"//普通商品详情、票券区
#import "SNBannerView.h"
#import <WebKit/WebKit.h>
#import "SLimitBuyLimitBuyInfo.h"//限量购
#import "SGroupBuyGroupBuyInfo.h"//拼单购
#import "SPreBuyPreBuyInfo.h"//无界预购
#import "SIntegralBuyIntegralBuyInfo.h"//无界商店
#import "SGoodsExplain.h"//说明
#import "SUserCollectAddCollect.h"
#import "SUserCollectDelOneCollect.h"
#import "SShopCar.h"
#import "SOnlineShopInfor.h"
#import "SIndianaInfor.h"
#import "SLotInfor.h"
#import "SShopCar_editView.h"
#import "DatePicker_Country.h"
#import "SPromotion_OPEN.h"
#import "SCoupons_OPEN.h"
#import "AShare.h"
#import "SOnlineShop_ClassInfoList_sub.h"
#import "SUserUserCenter.h"
#import "SGoodsGetTicket.h"
#import "SPurchase.h"
#import "SCartAddCart.h"
#import "SOrderConfirm.h"
#import "SFightGroups.h"
#import "SEva.h"
#import "STicketFight.h"
#import "SFreightFreight.h"//运费
#import "SGoodsAttrApi.h"

//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"

#import "SGoodsCategoryCateIndex.h"

//查看分类
#import "SOnlineShop_ClassInfoList_more.h"

#import "BaseShare.h"

#import "CountDown.h"

// 动态信息UI
#import "DynamicAlertMes.h"

/*
 *添加展示更多的拼单信息的界面
 */
#import "ShowMoreGroupView.h"

#import "SOrderCenter_list.h" //进入拼单购全部列表页

#import "SgiftDetailModel.h"
#import "SGoodsInfor_firstPoster.h"
#import "luckHandList.h"
#import "SGroupBuyLuckHandListCell.h"
#import "CommonHelp.h"
#import "CleanSOrderConfirm.h"
/*
 *记录group_arr是否有数据
 */
static NSUInteger groupArrIsEmpty = 0;

/// 获取动态消息api
static NSString * const GoodsMsgApiUrl = @"Goods/goodsMsg";

@interface SGoodsInfor_first () <UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate,WKNavigationDelegate,ZLPhotoPickerBrowserViewControllerDelegate>
{
    SGoodsInfor_nav * nav;//顶部(商品、详情、评价)View
    UIButton * rightBtn_sub;
    
    SGoodsInfor_firstView * top;
    
    NSInteger secondsCountDown;//倒计时总时长
    NSTimer *countDownTimer;
    NSInteger secondsCountDown_sub;//倒计时总时长
    NSTimer *countDownTimer_sub;
    NSString *format_time;
    
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    BOOL is_EndNew_Bool;//是否全部隐藏灯泡
    NSInteger is_EndNew_Bool_num;
    NSArray * dj_ticket;//代金券
    NSInteger dj_ticket_num;
    NSArray * goods_active;//商品正在进行的活动
    NSArray * promotion;//优惠券列表
    NSArray * ticketList;//优惠券列表
    NSInteger ticketList_num;
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
    QGoodsInfor_first_header3Reusa * header3;
    NSInteger wek_web_num;
    NSInteger attr_num;
    
    NSString * stage_status;//活动时间状态
    
    NSArray * group_arr;
    NSInteger group_arr_num;
    
    BOOL is_integral;
    NSInteger is_integral_num;
    NSInteger action_num;
    
    NSArray * goods_price_desc_arr;//价格说明
    
    BOOL collect_isno;//是否收藏
    NSString * collect_id;//收藏id
    NSString * product_id;//    商品属性id （特殊商品时需传）

    NSString * merchant_id;//商家id
    NSArray * goods_attr_arr;//商品尺码类型数组
    NSArray * contrastArr;//商品尺码类型对比数组
    
    NSString * shop_price_buy;//支付金额
    NSString * shop_onePrice_buy;//直接购买
    NSString * good_img_buy;//支付logo
    QGoodsInfor_first_header2Reusa * header2;
    NSString * vouchers_desc;//代金券说明
    NSString * share_url;//分享链接
    NSString * share_img;//"分享图片",
    NSString * share_title;//分享标题
    NSString * share_content;//"分享内容"
    NSString * top_cate_id;//": "商品三级分类id",
    NSString * cate_id;//": "商品二级分类id",
    NSString * pcate_id;//":"商品三级分类id"
    NSString * two_cate_name;//": "休闲食品",//二级分类名称
    NSString * merchant_easemob_account;//": "150582059257251",//商家客服账号
    NSString * merchant_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-19/59c0ff9493ec1.png",//商家客服头像
    NSString * merchant_nickname;//": "hi po n",//客服昵称
    
    NSInteger intergChange_num;//积分兑换
    NSInteger priceView_num;//积分兑换
    
    NSString * group_buy_isno;// @"":加入购物车 @"1":直接购买 @"2":开团 @"3":参团
    NSString * group_buy_order_id;//参团id
    
//    BOOL firt_isno;//第一次进来
    
    NSInteger overTimeView_num;
    
    BOOL SLimited_isno;//限量购到点了，不能买了
    
    NSString * now_province;
    NSString * now_city;
    NSString * now_area;
    NSMutableAttributedString * now_freight;
    NSString * top_freight;
    
    NSArray * easemob_account_ARR;
    
    NSString * model_remarks;//"本品由得一蜂业旗舰店从境内发货，并提供下单后2小时内发货。"   //注释内容
    
    NSString * model_choiceContent;
    
    //已选择的内容就不需要刷新了
    NSString * choice_shop_price;
    NSString * choice_market_price;
    NSString * choice_red_return_integral;
    NSString * choice_wy_price;
    NSString * choice_yx_price;
    NSString * choice_goods_num;
    NSString * choice_num;
    NSString * choice_product_id;
    NSString * choice_integral;
    NSString * choice_group_buy_id;
    
    NSString * overAgein;//是否选择完购物车跳转 1、2需要跳转   nil选择规格 1.立即购买 2.加入购物车
    
    NSMutableArray * banner_imgaeArr;
    NSArray * html_imageArr;
    
    NSString * model_mall_status;//是否有唯一的库存
    
    NSString * group_buy_type_status;// 拼单购状态下 如果是体验商品 传1 否则传2
    
    /*
     *是否参加过体验拼单活动的状态
     */
    NSString * isAlreadyExperienceGroupBuy;// 体验拼单购状态下是否体验过拼单
    /*
     *体验拼单购商品,是否人数已满
     */
    NSString * diffNum;// 体验拼单购状态下是否体验过拼单
    
    /*
     *已经被团商品的数量
     */
    NSString * alreadyGroupGoodCount;//当前已经有多少件商品拼团成功
    
    /*
     *显示正在拼单的人数
     */
    NSString * groupCount;//多少人在拼单
    
    /*
     * "goodContentY" 记录评论的Y坐标
     * "goodDetailY" 记录详情内容的Y坐标
     */
    CGFloat goodContentY;//评论Y坐标
    CGFloat goodDetailY;//详情Y坐标
    
    /*
     *普通商品返还的积分
     */
    NSString * pIntegral;//普通商品返还的积分
    
#pragma mark - 无界商店
    /*
     *保存无界商店选择属性后,对应的商品id,和对应的使用积分的数量
     */
    NSString * choice_integral_buy_id;
    NSString * wuJie_use_integral;
    /*
     *店铺的联系方式
     */
    NSString * merchant_phone;//店铺电话
    
    DynamicAlertMes * dynamicAlertMesView;
    dispatch_queue_t dynamicAlertQueue;
    dispatch_source_t dynamicAlertTimer;
    /*
     *无界商店立即兑换时判断是否跳转的字段
     */
    NSString * BuyForNow;
    NSString *integral_buy_id; //无界商店 跳转ID
    
    SGoodsGoodsInfo * goodsGoodsInfo;
    SLimitBuyLimitBuyInfo * LimitBuyInfo;
    SGroupBuyGroupBuyInfo * GroupBuyInfo;
    SPreBuyPreBuyInfo*preBuyPreBuyInfo;
    SIntegralBuyIntegralBuyInfo *integralBuyIntegralBuyInfo;
    SgiftDetailModel *sgiftDetailModel;
    
    NSArray *group_rank;//手气名单
     NSString *group_cid;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UILabel *carNum;//购物车数量
@property (strong, nonatomic) IBOutlet UIButton *addCarBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBuyBtn;
@property (strong, nonatomic) IBOutlet UIButton *addNowBtn;
@property (strong, nonatomic) IBOutlet UIButton *moveTopBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBuyW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addbuyBtnW;

/*
 *添加获取赠送积分的属性
 */
@property (nonatomic, copy) NSString * GroupIntegral;

/*
 *倒计时相关属性
 */
@property (strong, nonatomic)  CountDown *countDown;//倒计时timer
@property (nonatomic, assign)  long long countDownStartTimeStr;//获取的服务器系统的时间
@property (nonatomic, strong) NSMutableArray * timerArr;//保存活动结束的截止时间

@property (nonatomic, assign) BOOL isPop;//是否是pop了当前的控制器
@property (nonatomic, assign) long long disAppearTime;//控制器消失时的时间点
@property (nonatomic, assign) long long AppearTime;//控制器再次显示时的时间点
@property (nonatomic, assign) long long diffTime;//消失和再显示的时间差值
@property (nonatomic, assign) BOOL firstTime;//是否是第一次进入时间

/*
 *弱引用ShowMoreGroupView,用于获取它的collection中的显示的cell
 */
@property (nonatomic, weak) ShowMoreGroupView * moreGroupView;

/*
 * "isClickContentBtn" 当前是否被点击
 * "isClickDetailBtn" 当前是否被点击
 */
@property (nonatomic, assign) BOOL isClickContentBtn;
@property (nonatomic, assign) BOOL isClickDetailBtn;

/*
 *弹框选中发起拼单
 */
@property (nonatomic, assign, getter=isSelectOpenGroup) BOOL selectOpenGroup;

/*
 *动态消息数组
 */
@property (nonatomic, strong) NSArray * dynamicMsgArr;
/*
 *动态消息数组中的消息索引
 */
@property (nonatomic, assign) NSUInteger msgIndex;

//判断是不是2980商品
@property (nonatomic, assign) BOOL is_active;

//判断是不是爆款商品
@property (nonatomic, assign) BOOL is_active_5;
//互清库存
@property (nonatomic, assign) BOOL is_active_7;

@property (strong, nonatomic) IBOutlet UIButton *jishouBtn;


@end

@implementation SGoodsInfor_first

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    [self showModel];
//    NSArray *ar = @[
//  @{@"head_pic":@"",@"nick_name":@"张三",@"msg":@"刚刚抢到了一个特价商品"},
//  @{@"head_pic":@"",@"nick_name":@"王五",@"msg":@"刚刚中奖了"},
//  @{@"head_pic":@"",@"nick_name":@"李四",@"msg":@"拼单了一个商品"}];
//    [self showDynamicView:ar[0]];
    /*
     *当页面显示的时候,恢复GCD定时器的定时功能
     */
    if (dynamicAlertTimer) {
        dispatch_resume(dynamicAlertTimer);
    }
    
}
//- (void)showDynamicView:(NSDictionary *)dic {
- (void)showDynamicView:(NSArray *)arr {
    __block NSUInteger delayTime = 0;//要延迟的计时时间
    __block NSUInteger RandomTime = 0;//随机产生的时间
    NSTimeInterval period = 1.0; //设置时间间隔
    dynamicAlertQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dynamicAlertTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dynamicAlertQueue);
    dispatch_source_set_timer(dynamicAlertTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    [[UIApplication sharedApplication].delegate.window addSubview:dynamicAlertMesView];
    dispatch_source_set_event_handler(dynamicAlertTimer, ^{
        if (delayTime == RandomTime) {//当延迟的时间和随机产生的时间相同时,展示动态消息
            dispatch_async(dispatch_get_main_queue(), ^{
//            [dynamicAlertMesView settingValues:dic];
                [dynamicAlertMesView settingValues:arr[self.msgIndex]];
                dynamicAlertMesView.alpha = 1.0;
                [UIView animateWithDuration:3 animations:^{
                    dynamicAlertMesView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.msgIndex++;
                    if (self.msgIndex >= arr.count) {
                        self.msgIndex = 0;
                    }
                    delayTime = 0;//动态消息展示完后,恢复计时的延迟时间为0
                    RandomTime = Random10To20;
                }];
            });
        }
        delayTime++;
    });
    dispatch_resume(dynamicAlertTimer);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    /*
     *创建拼单的倒计时
     */
    if ([_overType isEqualToString:@"拼单购"] && ![group_buy_type_status isEqualToString:@"1"]) {
        
        if(!self.firstTime){//刚进入界面时,不计算时间差
            if (!_isPop) {
                self.AppearTime = time(NULL) * 1000;
                
                self.diffTime = self.AppearTime - self.disAppearTime;
                self.countDownStartTimeStr += self.diffTime;
            }
        }
        //根据groupArr是否有数据来决定是否创建定时器
        if (groupArrIsEmpty) {
            [self CreatCountDown];
        }
    }
    
    self.firstTime = NO;//恢复第一次进入的状态为NO
  
    
  
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    //移除动态消息
    [dynamicAlertMesView removeFromSuperview];
    /*
     *页面消失的时候,暂停GCD的计时功能
     */
    if(dynamicAlertTimer){
      dispatch_suspend(dynamicAlertTimer);
    }
    
    /*
     *当前界面消失时,销毁定时器
     */
    
    //只有当当前购物模块为拼单购,并且不是拼单购中的体验拼单的商品时,才执行销毁countDown定时器的操作
    if ([_overType isEqualToString:@"拼单购"] && ![group_buy_type_status isEqualToString:@"1"]) {
        if (!_isPop) {//不是pop当前控制器,才执行记录系统时间的操作
            self.disAppearTime = time(NULL) * 1000;
        }
        [self stopTimer];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 初始化 动态消息 提示
    dynamicAlertMesView = [[DynamicAlertMes alloc] initWithFrame:CGRectMake(20, 100, 300, 40)];
    
    /*
     *初始化是否是第一次进入控制器
     */
    self.firstTime = YES;
    
    /*
     *初始化Y坐标,为了和mCollect的偏移不同,以实现偏移的滚动,因为mCollect的默认偏移量是0
     */
    goodContentY = 1.0;
    goodDetailY = 1.0;
    
    nowType = @"1";
    total_num = 0;
    goods_num = 0;
    wek_web_num = 0;
    attr_num = 0;
    ticketList_num = 0;
    group_arr_num = 0;
    is_integral_num = 0;
    action_num = 0;
    _carNum.hidden = YES;
    [self createNav];
    [self createUI];
    
    page = 1;
    [self initRefresh];
    now_province = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"];
    now_city = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称"];
    now_area = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称_sub"];
//     [self showModel];
    /*
     *无界商店立即兑换时判断是否跳转的字段
     */
    BuyForNow = @"";
}
//- (void)viewDidAppear:(BOOL)animated {
//    if (firt_isno == NO) {
//        firt_isno = YES;
//    } else {
//       [self showModel];
//    }
//}
- (void)initRefresh
{
    __block SGoodsInfor_first * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
//    _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        page++;
//        [blockSelf showModel];
//    }];
}

/**
 此商品是否上架

 @param str 商品是否上架的状态 0 下架，1 上架
 */
- (void)isPutaway:(NSString *)str {
    if ([str isEqualToString:@"0"]) {
        //已下架 返回上一层
        [MBProgressHUD showError:@"此商品已下架!" toView:self.view];
       [self performSelector:@selector(goBack) withObject:nil afterDelay:2.0];
    }
}
//返回上一层
- (void)goBack {
    [self.navigationController popViewControllerAnimated:TRUE];
    return;
}

- (void)showModel {
    [countDownTimer invalidate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (_overType == nil) {
        //普通商品详情、票券区详情
        SGoodsGoodsInfo * infor = [[SGoodsGoodsInfo alloc] init];
        infor.goods_id = _goods_id;
        infor.p = [@(page) stringValue];
        infor.order_id=_order_id;
        infor.product_id=_product_id;
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sGoodsGoodsInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if ([code intValue]==1){
            SGoodsGoodsInfo * infor = (SGoodsGoodsInfo *)data;
            goodsGoodsInfo=infor;
        
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;
            easemob_account_ARR = infor.data.easemob_account;
            if ([infor.data.is_cart isEqualToString:@"1"]) {
                [_addCarBtn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:0.6]];
                _addCarBtn.userInteractionEnabled = YES;
                
            } else {
                [_addCarBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
                _addCarBtn.userInteractionEnabled = NO;
            }

            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
//            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;
            
            //轮播图
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [top.bannerView addSubview:banner];
            
            banner_imgaeArr = [[NSMutableArray alloc] init];
            for (SGoodsGoodsInfo * bannerImage in infor.data.goods_banner) {
                [banner_imgaeArr addObject:bannerImage.path];
            }
            
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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
            }

            if ([infor.data.goodsInfo.is_end isEqualToString:@"0"] && [infor.data.goodsInfo.is_new_goods isEqualToString:@"1"]) {
                is_EndNew_Bool = YES;
                top.is_EndNewView.hidden = YES;
                top.is_EndNewView_HHH.constant = 0;
            } else {
                is_EndNew_Bool = NO;
                if ([infor.data.goodsInfo.is_end isEqualToString:@"1"] && [infor.data.goodsInfo.is_new_goods isEqualToString:@"0"]) {
                    top.is_end_desc_HHH.constant = 24;
                } else {
                    if ([infor.data.goodsInfo.is_end isEqualToString:@"0"]) {
                        top.is_end_desc.hidden = YES;
                        top.is_end_desc_HHH.constant = 0;
                    } else {
                        top.is_new_goods_desc.hidden = YES;
                        top.is_end_desc_HHH.constant = 48;
                    }
                }
            }
            is_EndNew_Bool_num = 0;
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            if ([infor.data.goodsInfo.use_integral integerValue] == 0) {
                top.intergChangeView.hidden = YES;
                top.intergChange_HHH.constant = 0;
                intergChange_num = 40;
            } else {
                top.intergChangeView.hidden = NO;
                top.intergChange_HHH.constant = 40;
                intergChange_num = 0;
            }
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num);
            
            
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            //售价
            if (choice_shop_price == nil) {
                top.shop_price.text = infor.data.goodsInfo.shop_price;
            } else {
                top.shop_price.text = choice_shop_price;
            }
            //原价
            if (choice_market_price == nil) {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            } else {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",choice_market_price];
            }
            //积分
            if (choice_red_return_integral == nil) {
                top.integral.text = infor.data.goodsInfo.integral;
            } else {
                top.integral.text = choice_red_return_integral;
            }
         //   NSLog(@"ddddd %@",infor.data.goodsInfo.is_active);
            //2980商品 时隐藏
          
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
            shop_price_buy = infor.data.goodsInfo.shop_price;
            model_mall_status = infor.data.goodsInfo.mall_status;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];
            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            top_cate_id = infor.data.goodsInfo.top_cate_id;
            pcate_id = infor.data.goodsInfo.pcate_id;
            cate_id = infor.data.goodsInfo.cate_id;
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            /*
             *店铺的联系方式
             */
            merchant_phone = infor.data.mInfo.merchant_phone;
            level = infor.data.mInfo.level;
            all_goods = infor.data.mInfo.all_goods;
            view_num = infor.data.mInfo.view_num;
            goods_score = infor.data.mInfo.goods_score;
            merchant_score = infor.data.mInfo.merchant_score;
            shipping_score = infor.data.mInfo.shipping_score;
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
            group_price = infor.data.cheap_group.group_price;
            integral = infor.data.cheap_group.integral;
            goods_price = infor.data.cheap_group.goods_price;
            goods = infor.data.cheap_group.goods;
            
            if ([total integerValue] == 0) {
                //商品没有评价
                total_num = 250;
            } else {
                //商品有评价
                if (pictures.count == 0) {
                    //商品评价没有上传图片
                    total_num = 100;
                }
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            html_imageArr = [self getImageurlFromHtml:goods_desc];
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
         //   goods_common_attr = infor.data.goods_common_attr;
             goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;
            
            _is_active = [infor.data.goodsInfo.is_active isEqualToString:@"3"]? YES:NO;
            //爆款专区
            _is_active_5=[infor.data.goodsInfo.is_active isEqualToString:@"5"]? YES:NO;
            
            //互清库存
            _is_active_7=[infor.data.goodsInfo.is_active isEqualToString:@"7"]? YES:NO;
            if (_is_active) {
                top.integral.hidden = YES;
                top.songR.hidden = YES;
                top.songRTitle.hidden = YES;
                top.dj_ticketView.hidden = YES;
                _topBuyW.constant=0;
                _addCarBtn.hidden=YES;//隐藏加入购物车
                _addbuyBtnW.constant=250;
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num - top.di_ticket_view_HHH.constant-top.priceExplain_HHH.constant);
                top.priceExplainView.hidden = YES;
                top.priceExplain_HHH.constant = 0;
            }
            
            if (_is_active_5) {
                top.integral.hidden = YES;
                top.songR.hidden = YES;
                top.songRTitle.hidden = YES;
            }
            if (_is_active_7) {
                
                top.integral.hidden = YES;
                top.songR.hidden = YES;
                top.songRTitle.hidden = YES;
                
                _topBuyW.constant=0;
                _addCarBtn.hidden=YES;//隐藏加入购物车
                _addbuyBtnW.constant=250;
                
                top.priceExplainView.hidden = YES;
                top.priceExplain_HHH.constant = 0;
                
                top.overTimeView.hidden = NO;
                overTimeView_num = 0;
                top.overTime_HHH.constant = 50;
                
                top.overTime.text=[NSString stringWithFormat:@"活动时间：%@-%@",[CommonHelp timeWithTimeIntervalString:infor.data.goodsInfo.examine_time andFormatter:@"YYYY-MM-dd"],[CommonHelp timeWithTimeIntervalString:infor.data.goodsInfo.deadline andFormatter:@"YYYY-MM-dd"]];
                
                top.indexLab.text=[NSString stringWithFormat:@" 指数:%@ ",infor.data.goodsInfo.index];
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380+50 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num-50);
                
                
            }
            if ( _order_id.length!=0) {
                _jishouBtn.hidden=NO;
                [_jishouBtn addTarget:self action:@selector(jishouBtnPress) forControlEvents:UIControlEventTouchUpInside];
                top.priceView.hidden=YES;
                top.priceViewHH.constant=0;
                priceView_num=50;
                
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380+50 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num-50-priceView_num);
                
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"寄售额:¥ %@",infor.data.goodsInfo.wholesale_price]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,infor.data.goodsInfo.wholesale_price.length+2)];
             
               top.sell_num.attributedText = AttributedStr;
               
    
                
                NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提货价:¥ %@",infor.data.goodsInfo.supply_price]];
                [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,infor.data.goodsInfo.supply_price.length+2)];
                top.goods_num.attributedText = AttributedStr1;
                
                NSMutableAttributedString * AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"利润:¥ %@",infor.data.goodsInfo.profit]];
                [AttributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,infor.data.goodsInfo.profit.length+2)];
                
                top.top_freight.attributedText =AttributedStr2;
                
            }
            else
            {
                _jishouBtn.hidden=YES;
                priceView_num=0;
            }
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
            }
            else
            {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                );
            }

        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = [[SLimitBuyLimitBuyInfo alloc] init];
        infor.limit_buy_id = _goods_id;
        infor.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sLimitBuyLimitBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SLimitBuyLimitBuyInfo * infor = (SLimitBuyLimitBuyInfo *)data;
            LimitBuyInfo=infor;
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;

            easemob_account_ARR = infor.data.easemob_account;

            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
//            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;

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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
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
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            if ([infor.data.goodsInfo.stage_status isEqualToString:@"已结束"]) {
                SLimited_isno = YES;
                [_addNowBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [_addNowBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
                top.overTimeView.hidden = YES;
                overTimeView_num = 50;
                top.overTime_HHH.constant = 0;
            } else {
                SLimited_isno = NO;
                [_addNowBtn setBackgroundColor:[UIColor redColor]];
                [_addNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
                top.overTimeView.hidden = NO;
                overTimeView_num = 0;
                top.overTime_HHH.constant = 50;
                secondsCountDown = [infor.data.goodsInfo.end_time integerValue] - time(NULL);//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
            }
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 + 30 - is_EndNew_Bool_num - dj_ticket_num - overTimeView_num);
            
            
            
            stage_status = infor.data.goodsInfo.stage_status;
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            //售价
            if (choice_shop_price == nil) {
                top.shop_price.text = infor.data.goodsInfo.limit_price;
            } else {
                top.shop_price.text = choice_shop_price;
            }
            //原价
            if (choice_market_price == nil) {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            } else {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",choice_market_price];
            }
            //积分
            if (choice_red_return_integral == nil) {
                top.integral.text = infor.data.goodsInfo.integral;
            } else {
                top.integral.text = choice_red_return_integral;
            }
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
            shop_price_buy = infor.data.goodsInfo.limit_price;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];
            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            
            [top.proBlue setProgress:[infor.data.goodsInfo.sell_num floatValue]/([infor.data.goodsInfo.sell_num floatValue] + [infor.data.goodsInfo.limit_store floatValue])];
            top.proBlue_num.text = [NSString stringWithFormat:@"%.0f%%",[infor.data.goodsInfo.sell_num floatValue]/([infor.data.goodsInfo.sell_num floatValue] + [infor.data.goodsInfo.limit_store floatValue]) * 100];
            NSMutableAttributedString * attributedStr_right = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已抢购%@件/剩余%@件",infor.data.goodsInfo.sell_num,infor.data.goodsInfo.limit_store]];
            [attributedStr_right addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7 + infor.data.goodsInfo.sell_num.length, infor.data.goodsInfo.limit_store.length)];
            top.proBlue_rigthNum.attributedText = attributedStr_right;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            cate_id = infor.data.goodsInfo.cate_id;
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
//            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
//            group_price = infor.data.cheap_group.group_price;
//            integral = infor.data.cheap_group.integral;
//            goods_price = infor.data.cheap_group.goods_price;
//            goods = infor.data.cheap_group.goods;
            
            if ([total integerValue] == 0) {
                total_num = 250;
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
         //   goods_common_attr = infor.data.goods_common_attr;
            
            goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;

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
            [MBProgressHUD showError:nil toView:self.view];
        }];
    } else if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = [[SGroupBuyGroupBuyInfo alloc] init];
        infor.group_buy_id = _goods_id;
        infor.p = [@(page) stringValue];
        infor.a_id = _a_id ? _a_id : @"";
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sGroupBuyGroupBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyGroupBuyInfo * infor = (SGroupBuyGroupBuyInfo *)data;
            GroupBuyInfo=infor;
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;

            easemob_account_ARR = infor.data.easemob_account;

            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
//            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;
            
            
            /*记录 商品为拼单购状态下  体验/拼单 类型*/
            group_buy_type_status = infor.data.group_type;
            
            /*
             *获取当前用户是否已参加过本商品的体验拼单活动
             */
            SGroupBuyGroupBuyInfo * groupFirstObject = infor.data.group.firstObject;
            isAlreadyExperienceGroupBuy = groupFirstObject.is_member;
            diffNum = groupFirstObject.diff_num;
            //轮播图
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goods_banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            
            /*
             *设置banner的pageControl的显示和隐藏
             */
            if ([group_buy_type_status isEqualToString:@"1"]) {
                [banner setValue:[NSNumber numberWithBool:YES] forKeyPath:@"pageControl.hidden"];
            }else{
                [banner setValue:[NSNumber numberWithBool:NO] forKeyPath:@"pageControl.hidden"];
            }
            
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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
            }
//            if ([infor.data.goodsInfo.is_end isEqualToString:@"0"] && [infor.data.goodsInfo.is_new_goods isEqualToString:@"1"]) {
//                is_EndNew_Bool = YES;
//                top.is_EndNewView.hidden = YES;
//                top.is_EndNewView_HHH.constant = 0;
//            } else {
//                is_EndNew_Bool = NO;
//
//                if ([infor.data.goodsInfo.is_end isEqualToString:@"0"]) {
//                    top.is_end_desc.hidden = YES;
//                    top.is_end_desc_HHH.constant = 0;
//                } else {
//                    top.is_new_goods_desc.hidden = YES;
//                    top.is_end_desc_HHH.constant = 40;
//                }
//            }
            
            
            if ([infor.data.group_type isEqualToString:@"2"]) {
//                is_EndNew_Bool = YES;
//                top.is_EndNewView.hidden = YES;
//                top.is_EndNewView_HHH.constant = 0;
//                top.is_end_desc.hidden = YES;
//                top.is_new_goods_desc.hidden = YES;
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
            } else {
                is_EndNew_Bool = NO;
                /*
                 *将购物模式,传递给top视图
                 */
                top.overType = _overType;
                /*
                 *设置要显示的活动信息
                 */
                top.inforData = infor.data;
            }
            
            /*
             *移动了一下获取成单所需人数代码的位置,为了设置体验品单的进度条的显示
             */
            SGroupBuyGroupBuyInfo * tmpObject = infor.data.goodsInfo;
            top.conditionNum.text = [NSString stringWithFormat:@"成单所需%@人", tmpObject.group_num];
            
            is_EndNew_Bool_num = 0;
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 - 170 - is_EndNew_Bool_num - dj_ticket_num + top.introduct_HHH.constant);
            /*
             *体验拼单的商品的进度条的显示,以及top高度的计算
             */
            if ([group_buy_type_status isEqualToString:@"1"]) {
                top.group_buy_type_status = group_buy_type_status;
                top.blueView.hidden = NO;
                top.blue_HHH.constant = top.proBlueToTopCons.constant + top.proBlueHeightCons.constant + 5;
                [top.proBlue setProgress:infor.data.total.floatValue / tmpObject.group_num.floatValue];
                /*
                 *新添加体验拼单商品参与的进度的展示
                 */
                top.proLabel.hidden = NO;
                /*
                 *显示体验拼单商品的参与拼单人数的进度
                 */
                top.proLabel.text = [NSString stringWithFormat:@"%.0f%%",top.proBlue.progress * 100];
                CGSize textSize = [top.proLabel sizeThatFits:CGSizeMake(ScreenW, 15)];
                if (top.proBlue.progress == 0) {
                    top.proLabelToLeadingCons.constant = (ScreenW - 30) * top.proBlue.progress;
                }else if (top.proBlue.progress == 1){
                    top.proLabelToLeadingCons.constant = (ScreenW - 30) * top.proBlue.progress - textSize.width;
                }else{
                    top.proLabelToLeadingCons.constant = (ScreenW - 30) * top.proBlue.progress - textSize.width * 0.5;
                }
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 - 170 - is_EndNew_Bool_num - dj_ticket_num + top.blue_HHH.constant + top.introduct_HHH.constant);
            }
            
            //拼单购时隐藏独立购买按钮
//            _addCarBtn.hidden = YES;

//            [_addCarBtn setTitle:[NSString stringWithFormat:@"￥%@\n独立购买",infor.data.one_price] forState:UIControlStateNormal];
            
            /*
             * 设置独立购买显示赠送的积分
             */
            NSString * NormalGoodIntegral = nil;
            if (!pIntegral) {
                NormalGoodIntegral = infor.data.goodsInfo.p_integral;
            }else{
                NormalGoodIntegral = pIntegral;
            }
//            [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n独立购买",NormalGoodIntegral]] forState:UIControlStateNormal];

            
            
//            shop_onePrice_buy = infor.data.one_price;//旧代码
            
            /*
             *添加是否是体验拼单商品的判断
             */
            if ([group_buy_type_status isEqualToString:@"1"]) {
                shop_onePrice_buy = infor.data.goodsInfo.shop_price;
            }else{
                shop_onePrice_buy = infor.data.one_price;
            }
            
            top.market_price.font = [UIFont systemFontOfSize:15];
            top.marketPriceConstraintHeight.constant = 25.0f;
            
            
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            
            //售价
            if (choice_shop_price == nil) {
                top.shop_price.text = infor.data.goodsInfo.shop_price;
            } else {
                top.shop_price.text = choice_shop_price;
            }
            
//            [_addBuyBtn setTitle:[NSString stringWithFormat:@"￥%@\n发起拼单",top.shop_price.text] forState:UIControlStateNormal];//旧代码
            
            
            //积分
            if (choice_red_return_integral == nil) {
                top.integral.text = infor.data.goodsInfo.integral;
            } else {
                top.integral.text = choice_red_return_integral;
            }
            
            if ([infor.data.goodsInfo.integral doubleValue]==0){
                top.integral.hidden = YES;
                top.songR.hidden = YES;
                top.songRTitle.hidden = YES;
            }
            
            self.GroupIntegral = top.integral.text;
            
            //拼单购中,商品已经被团购的件数
            alreadyGroupGoodCount = infor.data.total;
            /*
             *判断当前是否是体验拼单的状态,根据状态设置立即支付的显示,以及下一部操作
             */
            if ([group_buy_type_status isEqualToString:@"1"]) {
                
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"￥%@\n体验拼单",top.shop_price.text] forState:UIControlStateNormal];
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n体验拼单",top.integral.text] forState:UIControlStateNormal];
                [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n单买￥%@元",NormalGoodIntegral,infor.data.one_price]] forState:UIControlStateNormal];
                if ([top.integral.text doubleValue]==0){
                    [_addBuyBtn setTitle:[NSString stringWithFormat:@"手气￥%@元",top.shop_price.text] forState:UIControlStateNormal];
                }
                else
                {
                 [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n手气￥%@元",top.integral.text,top.shop_price.text] forState:UIControlStateNormal];
                }
           //     NSLog(@"%@",integral);
                //拼单购中,商品已经被团购的件数
                top.market_price.text = [NSString stringWithFormat:@"已参与%@人",alreadyGroupGoodCount];
            }else{
                _addBuyBtn.enabled = YES;
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"￥%@\n发起拼单",top.shop_price.text] forState:UIControlStateNormal];
                [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n独立购买",NormalGoodIntegral]] forState:UIControlStateNormal];
                [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n发起拼单",top.integral.text] forState:UIControlStateNormal];
                //拼单购中,商品已经被团购的件数
                top.market_price.text = [NSString stringWithFormat:@"已拼成%@件",alreadyGroupGoodCount];
            }
            
            
//            //原价//旧代码
//            if (choice_market_price == nil) {
//                top.market_price.text = [NSString stringWithFormat:@"已团%@件",infor.data.total];
//            } else {
//                top.market_price.text = [NSString stringWithFormat:@"已团%@件",choice_market_price];
//            }
            
            /*
             *拼单购显示已团商品的件数,不根据choice_market_price做判断
             */
            
            //隐藏其他商品类型的价格UI
            top.shop_priceLeft.hidden = YES;
            top.shop_price.hidden = YES;
            //显示拼单购类型的价格UI
            top.shopPriceLeftGroup.hidden = NO;
            top.shopPriceGroup.hidden = NO;
            top.oldPrice.hidden = NO;
            
            //售价
            if (choice_shop_price == nil) {
                top.shopPriceGroup.text = infor.data.goodsInfo.shop_price;
            } else {
                top.shopPriceGroup.text = choice_shop_price;
            }
            
            top.oldPrice.text = [NSString stringWithFormat:@"￥%@", infor.data.goodsInfo.market_price];
            CALayer *oldPriceLayer = [[CALayer alloc] init];
            oldPriceLayer.frame = CGRectMake(0, (top.oldPrice.frame.size.height - 1) / 2, top.oldPrice.frame.size.width + 18, 1);
            oldPriceLayer.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1].CGColor;
            [top.oldPrice.layer addSublayer:oldPriceLayer];
            
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
            model_mall_status = infor.data.goodsInfo.mall_status;
            
            shop_price_buy = infor.data.goodsInfo.shop_price;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.market_price_line.hidden = YES;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];

            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            cate_id = infor.data.goodsInfo.cate_id;
            /*
             *添加拼单购商品,查看分类跳转
             */
            top_cate_id = infor.data.goodsInfo.top_cate_id;
            pcate_id = infor.data.goodsInfo.pcate_id;
            
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            /*
             *店铺的联系方式
             */
            merchant_phone = infor.data.mInfo.merchant_phone;
            level = infor.data.mInfo.level;
            all_goods = infor.data.mInfo.all_goods;
            view_num = infor.data.mInfo.view_num;
            goods_score = infor.data.mInfo.goods_score;
            merchant_score = infor.data.mInfo.merchant_score;
            shipping_score = infor.data.mInfo.shipping_score;
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
            group_price = infor.data.cheap_group.group_price;
            integral = infor.data.cheap_group.integral;
            goods_price = infor.data.cheap_group.goods_price;
            goods = infor.data.cheap_group.goods;
            
            groupCount = infor.data.group_count;
            
            if ([total integerValue] == 0) {
                total_num = 250;
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
             goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            // goods_common_attr =infor.data.goods_common_attr ;
            group_arr = infor.data.group;
            
            if ([group_buy_type_status isEqualToString:@"1"]) group_arr = nil;
            if (group_arr.count == 0) {
                group_arr_num = 60;
            }else{
                /*
                 *拼团的数组不为空的时候调用
                 */
                groupArrIsEmpty++;
                [self CreatCountDown];
            }

            
            /*
             *获取每个拼团的倒计时的结束时间
             */
            [self.timerArr removeAllObjects];
            self.timerArr = nil;
            self.timerArr = [self GetActivityEndTime];
            
            
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;
        //    NSLog(@"SSSSS %@",   infor.data.group_rank.rank_list)  ;
            group_rank=infor.data.group_rank.rank_list;
            
    
            if ([group_buy_type_status isEqualToString:@"1"]) {
                top.tickNamelab.text=@"手气值排行榜";
                top.ima_jiangPai.hidden=NO;
                top.tickNameLabHHH.constant=50;
                [top.dj_ticketBtn setImage:[UIImage imageNamed:@"灰色右箭头"] forState:UIControlStateNormal];
              
            }else{
                top.tickNamelab.text =@"可使用代金券情况";
                 top.ima_jiangPai.hidden=YES;
                 top.tickNameLabHHH.constant=8;
                [top.dj_ticketBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
            }
        
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
    } else if ([_overType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = [[SPreBuyPreBuyInfo alloc] init];
        infor.pre_buy_id = _goods_id;
        infor.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sPreBuyPreBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreBuyPreBuyInfo * infor = (SPreBuyPreBuyInfo *)data;
            preBuyPreBuyInfo=infor;
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;

            easemob_account_ARR = infor.data.easemob_account;

            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
//            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;

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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
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
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            if ([infor.data.goodsInfo.is_integral isEqualToString:@"0"]) {
                is_integral_num = 50;
                top.needInterView.hidden = YES;
                top.needInter_HHH.constant = 0;
            }
            CGSize size = [[NSString stringWithFormat:@"活动说明：%@",infor.data.goodsInfo.desc] boundingRectWithSize:CGSizeMake(ScreenW - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            action_num = size.height + 10;
            top.action_HHH.constant = action_num;
            
            if ([infor.data.goodsInfo.stage_status isEqualToString:@"已结束"]) {
                SLimited_isno = YES;
                [_addNowBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [_addNowBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
                top.overTimeView.hidden = YES;
                overTimeView_num = 50;
                top.overTime_HHH.constant = 0;
            } else {
                SLimited_isno = NO;
                [_addNowBtn setBackgroundColor:[UIColor redColor]];
                [_addNowBtn setTitle:@"交付定金" forState:UIControlStateNormal];
                top.overTimeView.hidden = NO;
                overTimeView_num = 0;
                top.overTime_HHH.constant = 50;
                secondsCountDown = [infor.data.goodsInfo.end_time integerValue] - time(NULL);//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
            }
            stage_status = infor.data.goodsInfo.stage_status;
            top.overTime_needTitle.text = [NSString stringWithFormat:@"定金 %@",infor.data.goodsInfo.deposit];
            
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 380 + 180 - is_EndNew_Bool_num - dj_ticket_num - is_integral_num - 50 + action_num - overTimeView_num);

            
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            [_addCarBtn setTitle:[NSString stringWithFormat:@"￥%@\n预约价格",infor.data.goodsInfo.pre_price] forState:UIControlStateNormal];
            
            //售价
            if (choice_shop_price == nil) {
                top.shop_price.text = infor.data.goodsInfo.deposit;
            } else {
                top.shop_price.text = choice_shop_price;
            }
            //原价
            if (choice_market_price == nil) {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            } else {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",choice_market_price];
            }
            //积分
            if (choice_red_return_integral == nil) {
                top.integral.text = infor.data.goodsInfo.integral;
            } else {
                top.integral.text = choice_red_return_integral;
            }
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
            shop_price_buy = infor.data.goodsInfo.pre_price;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];

            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            top.needInter_Num.text = [NSString stringWithFormat:@"可以使用 %@ 积分支付",infor.data.goodsInfo.integral_price];
            top.lastTime_num.text = [NSString stringWithFormat:@"最晚发货日期：%@",infor.data.goodsInfo.end_delivery_date];
            [top.proBlue setProgress:[infor.data.goodsInfo.sell_num floatValue]/[infor.data.goodsInfo.success_max_num floatValue]];
            top.proBlue_num.text = [NSString stringWithFormat:@"%.0f%%",[infor.data.goodsInfo.sell_num floatValue]/[infor.data.goodsInfo.success_max_num floatValue] * 100];
            NSMutableAttributedString * attributedStr_right = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已抢购%@件/剩余%ld件",infor.data.goodsInfo.sell_num,[infor.data.goodsInfo.success_max_num integerValue] - [infor.data.goodsInfo.sell_num integerValue]]];
            [attributedStr_right addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7 + infor.data.goodsInfo.sell_num.length, [NSString stringWithFormat:@"%ld",[infor.data.goodsInfo.success_max_num integerValue]  - [infor.data.goodsInfo.sell_num integerValue]].length)];
            top.proBlue_leftNum.attributedText = attributedStr_right;
            top.proBlue_rigthNum.text = [NSString stringWithFormat:@"满%@件即可发货",infor.data.goodsInfo.success_max_num];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"活动说明：%@",infor.data.goodsInfo.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, 5)];
            top.action_Title.attributedText = attributedStr_dec;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            cate_id = infor.data.goodsInfo.cate_id;
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
            group_price = infor.data.cheap_group.group_price;
            integral = infor.data.cheap_group.integral;
            goods_price = infor.data.cheap_group.goods_price;
            goods = infor.data.cheap_group.goods;
            
            if ([total integerValue] == 0) {
                total_num = 250;
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
          //  goods_common_attr = infor.data.goods_common_attr;
            
            goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;

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
    } else if ([_overType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = [[SIntegralBuyIntegralBuyInfo alloc] init];
        infor.integral_buy_id = _goods_id;
        infor.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sIntegralBuyIntegralBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyIntegralBuyInfo * infor = (SIntegralBuyIntegralBuyInfo *)data;
            integralBuyIntegralBuyInfo=infor;
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;

            easemob_account_ARR = infor.data.easemob_account;

            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
//            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;
            
            model_mall_status = infor.data.goodsInfo.mall_status;
            
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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                /*
                 *因为无界商城中,没有代金券选项,所以,暂时不显示代金券相关的视图,暂时将此行代码注释掉
                 */
//                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
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
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 250 - is_EndNew_Bool_num - dj_ticket_num);
            
            shop_price_buy = infor.data.goodsInfo.use_integral;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            top.shop_priceLeft.font = [UIFont systemFontOfSize:15];
//            top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@积分",infor.data.goodsInfo.use_integral];//旧代码
            /*
             *根据是否选中不同规格的商品,显示兑换需要使用的积分
             */
            if (wuJie_use_integral == nil) {
                top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@积分",infor.data.goodsInfo.use_integral];
            }else{
                top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@积分",wuJie_use_integral];
            }
            top.songR.hidden = YES;
            top.songRTitle.hidden = YES;
            top.integral.textColor = WordColor_sub;
//            top.integral.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];//旧代码
            
            /*
             *根据是否选中不同规格的商品,显示库存
             */
            if (choice_goods_num == nil) {
                top.integral.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.integral.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }

            
            
            
            //售价
//            if (choice_shop_price == nil) {
//                top.shop_price.text = @"";
//            } else {
//                top.shop_price.text = choice_shop_price;
//            }//旧代码
            /*
             *不显示商品的售价
             */
            top.shop_price.text = @"";
            //原价
            if (choice_market_price == nil) {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            } else {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            }
//            //积分
//            if (infor.data.goodsInfo.integral != nil) {
//                top.integral.text = infor.data.goodsInfo.integral;
//            } else {
//                top.integral.text = choice_red_return_integral;
//            }
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
//            top.integral.text = infor.data.goodsInfo.integral;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];
            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            cate_id = infor.data.goodsInfo.cate_id;
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            /*
             *店铺的联系方式
             */
            merchant_phone = infor.data.mInfo.merchant_phone;
            level = infor.data.mInfo.level;
            all_goods = infor.data.mInfo.all_goods;
            view_num = infor.data.mInfo.view_num;
            goods_score = infor.data.mInfo.goods_score;
            merchant_score = infor.data.mInfo.merchant_score;
            shipping_score = infor.data.mInfo.shipping_score;
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
            group_price = infor.data.cheap_group.group_price;
            integral = infor.data.cheap_group.integral;
            goods_price = infor.data.cheap_group.goods_price;
            goods = infor.data.cheap_group.goods;
            
            if ([total integerValue] == 0) {
                total_num = 250;
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
          //  goods_common_attr = infor.data.goods_common_attr;
             goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            /*
             *无界商店跳转到分类需要参数
             */
            pcate_id = infor.data.goodsInfo.pcate_id;
            top_cate_id = infor.data.goodsInfo.top_cate_id;
            
            
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;
            
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
    else if ([_overType isEqualToString:@"赠品专区"]) {
        SgiftDetailModel * infor = [[SgiftDetailModel alloc] init];
        infor.gift_goods_id = _gift_goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor SgiftDetailModelSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SgiftDetailModel * infor = (SgiftDetailModel *)data;
            sgiftDetailModel=infor;
            //判断此商品上架状态
            [self isPutaway:infor.data.goodsInfo.buy_status];
            
            model_remarks = infor.data.remarks;
            
            easemob_account_ARR = infor.data.easemob_account;
            
            if ([infor.data.cart_num integerValue] < 1) {
                _carNum.hidden = YES;
            } else {
                _carNum.hidden = NO;
                _carNum.text = infor.data.cart_num;
            }
            
            collect_id = infor.data.goodsInfo.goods_id;
            product_id = infor.data.goodsInfo.product_id;//kong
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
            //商品尺码规格数组
            goods_attr_arr = infor.data.first_list;
            contrastArr = infor.data.first_val;
            vouchers_desc = infor.data.vouchers_desc;
            share_url = infor.data.share_url;
            share_img = infor.data.share_img;
            share_title = infor.data.goodsInfo.goods_name;
            //            share_content = infor.data.share_content;
            share_content = infor.data.goodsInfo.goods_brief;
            
            model_mall_status = infor.data.goodsInfo.mall_status;
            
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
            
            //同时不存在，全部隐藏
            if (choice_shop_price == nil) {
                /*
                 *因为无界商城中,没有代金券选项,所以,暂时不显示代金券相关的视图,暂时将此行代码注释掉
                 */
                //                dj_ticket = infor.data.goodsInfo.dj_ticket;//代金券
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
            dj_ticket_num = 0;
            if (is_EndNew_Bool == YES) {
                is_EndNew_Bool_num = 50;
            }
            if (dj_ticket.count == 0) {
                dj_ticket_num = 60;
                top.dj_ticketView.hidden = YES;
            }
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW + 250 - is_EndNew_Bool_num - dj_ticket_num);
            
            shop_price_buy = infor.data.goodsInfo.use_integral;
            good_img_buy = infor.data.goodsInfo.goods_img;
            top.goods_name.text = infor.data.goodsInfo.goods_name;
            top.shop_priceLeft.font = [UIFont systemFontOfSize:15];
            //            top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@积分",infor.data.goodsInfo.use_integral];//旧代码
            /*
             *根据是否选中不同规格的商品,显示兑换需要使用的积分
             */
        //    if (wuJie_use_integral == nil) {
                top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@赠品券",infor.data.goodsInfo.use_voucher];
//            }else{
//                top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@赠品券",wuJie_use_integral];
//            }
            top.songR.hidden = YES;
            top.songRTitle.hidden = YES;
            top.integral.textColor = WordColor_sub;
            //            top.integral.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];//旧代码
            
            /*
             *根据是否选中不同规格的商品,显示库存
             */
            if (choice_goods_num == nil) {
                top.integral.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.integral.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            
            
            
            
            //售价
            //            if (choice_shop_price == nil) {
            //                top.shop_price.text = @"";
            //            } else {
            //                top.shop_price.text = choice_shop_price;
            //            }//旧代码
            /*
             *不显示商品的售价
             */
            top.shop_price.text = @"";
            //原价
            if (choice_market_price == nil) {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            } else {
                top.market_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.market_price];
            }
            //            //积分
            //            if (infor.data.goodsInfo.integral != nil) {
            //                top.integral.text = infor.data.goodsInfo.integral;
            //            } else {
            //                top.integral.text = choice_red_return_integral;
            //            }
            //无油价
            if (choice_wy_price == nil) {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.wy_price];
            } else {
                top.wy_price.text = [NSString stringWithFormat:@"￥%@",choice_wy_price];
            }
            //优享价
            if (choice_yx_price == nil) {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",infor.data.goodsInfo.yx_price];
            } else {
                top.yx_price.text = [NSString stringWithFormat:@"￥%@",choice_yx_price];
            }
            //库存
            if (choice_goods_num == nil) {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",infor.data.goodsInfo.goods_num];
            } else {
                top.goods_num.text = [NSString stringWithFormat:@"库存 %@",choice_goods_num];
            }
            //商品兑换积分
            if (choice_integral == nil) {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",infor.data.goodsInfo.use_integral];
            } else {
                top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",choice_integral];
            }
            
            //            top.integral.text = infor.data.goodsInfo.integral;
            top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];
            top.goods_brief.text = infor.data.goodsInfo.goods_brief;
            
            goods_active = infor.data.goodsInfo.goods_active;
            promotion = infor.data.promotion;
            ticketList = infor.data.ticketList;
            if (ticketList.count == 0) {
                ticketList_num = 140;
            }
            cate_id = infor.data.goodsInfo.cate_id;
            two_cate_name = infor.data.goodsInfo.two_cate_name;
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
            /*
             *店铺的联系方式
             */
            merchant_phone = infor.data.mInfo.merchant_phone;
            level = infor.data.mInfo.level;
            all_goods = infor.data.mInfo.all_goods;
            view_num = infor.data.mInfo.view_num;
            goods_score = infor.data.mInfo.goods_score;
            merchant_score = infor.data.mInfo.merchant_score;
            shipping_score = infor.data.mInfo.shipping_score;
            merchant_easemob_account = infor.data.mInfo.merchant_easemob_account;
            merchant_head_pic = infor.data.mInfo.merchant_head_pic;
            merchant_nickname = infor.data.mInfo.merchant_nickname;
            ticket_buy_discount = infor.data.cheap_group.ticket_buy_discount;
            group_price = infor.data.cheap_group.group_price;
            integral = infor.data.cheap_group.integral;
            goods_price = infor.data.cheap_group.goods_price;
            goods = infor.data.cheap_group.goods;
            
            if ([total integerValue] == 0) {
                total_num = 250;
            }
            if (goods.count == 0) {
                goods_num = 210;
            }
            
            goods_desc = infor.data.goodsInfo.goods_desc;
            package_list = infor.data.goodsInfo.package_list;
            after_sale_service = infor.data.goodsInfo.after_sale_service;
            price_desc = infor.data.price_desc;
            //  goods_common_attr = infor.data.goods_common_attr;
            goods_common_attr =[self notNullData:infor.data.goods_common_attr] ;
            /*
             *无界商店跳转到分类需要参数
             */
            pcate_id = infor.data.goodsInfo.pcate_id;
            top_cate_id = infor.data.goodsInfo.top_cate_id;
            
            
            CGSize size_package_list = [package_list boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            package_list_num = size_package_list.height + 10;
            CGSize size_after_sale_service = [after_sale_service boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            after_sale_service_num = size_after_sale_service.height + 10;
            CGSize size_price_desc = [price_desc boundingRectWithSize:CGSizeMake(ScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            price_desc_num = size_price_desc.height + 10;
            
            goods_price_desc_arr = infor.data.goods_price_desc;
            integral_buy_id = infor.data.goodsInfo.integral_buy_id;
            
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
            [arr removeAllObjects];
            [_mCollect.mj_header endRefreshing];
            [self freight_num];
            [_mCollect reloadData];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    /*
     *获取动态显示的纤细字典数组
     */
    [HttpManager getWithUrl:GoodsMsgApiUrl andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * mesDic = (NSDictionary *)Json;
        if (![mesDic[@"code"] isEqualToString:@"1"]) return;
        NSArray * mesArray = [[mesDic objectForKey:@"data"] objectForKey:@"event_msg"];
        NSInteger count = [mesArray count];
        if (count > 0) {
            NSMutableArray * dynamicTempArr = [NSMutableArray array];
            for (SGroupBuyGroupBuyInfo * dynamicMsgModel in mesArray) {
                [dynamicTempArr addObject:dynamicMsgModel.mj_keyValues];
            }
            self.dynamicMsgArr = [dynamicTempArr copy];
            /*
             *显示动态信息
             */
            [self showDynamicView:self.dynamicMsgArr];
        }
    } andFail:^(NSError *error) {
    }];
    
}
#pragma mark - 运费
- (void)freight_num {
    SFreightFreight * freight = [[SFreightFreight alloc] init];
    if (collect_id == nil) {
        [MBProgressHUD showError:@"商品id有问题,请联系客服" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        return;
    }
    freight.goods_id = collect_id;
    freight.address = [NSString stringWithFormat:@"%@,%@,%@",now_province,now_city,now_area];
    //商品个数默认1个
    if (choice_num == nil) {
        freight.goods_num = @"1";
    } else {
        freight.goods_num = choice_num;
    }
    //商品属性默认空
    if (choice_product_id == nil) {
        freight.product_id = @"";
    } else {
        freight.product_id = choice_product_id;
    }
    [freight sFreightFreightSuccess:^(NSString *code, NSString *message, id data) {
        SFreightFreight * freight = (SFreightFreight *)data;
        
        now_freight = [[NSMutableAttributedString alloc]initWithString:freight.data.pay];
        if (_order_id.length<=0) {
               top.top_freight.text = freight.data.pay;
        }
     
        [_mCollect reloadData];

    } andFailure:^(NSError *error) {
        
    }];
}
#pragma mark - 倒计时
-(void) countDownAction{
    //倒计时-1
    secondsCountDown--;
    NSString *str_day = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600/24];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600%24];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    format_time = [NSString stringWithFormat:@"%@:%@:%@:%@",str_day,str_hour,str_minute,str_second];
    
    [countDownTimer_sub invalidate];
    secondsCountDown_sub = 99;//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
    countDownTimer_sub = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(countDownAction_sub) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
    
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
    }
}

- (void)countDownAction_sub {
    secondsCountDown_sub--;
    //修改倒计时标签现实内容
    //修改倒计时标签现实内容
    top.overTime.text=[NSString stringWithFormat:@"%@ %@:%@",stage_status,format_time,[NSString stringWithFormat:@"%02ld",secondsCountDown_sub]];
    
}
#pragma mark - 说明
- (void)priceInterBtnClick:(UIButton *)btn {
    SGoodsExplain * explain = [[SGoodsExplain alloc] init];
    explain.modalPresentationStyle = UIModalPresentationOverFullScreen;
    explain.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:explain animated:YES completion:nil];
    if (btn.tag == 0) {
//        修改价钱说明 👉 价格说明  by_fxg
        [explain showModel:goods_price_desc_arr andType:_overType andType:@"价格说明"];
    } else {
        
        [explain showModel:goods_server andType:_overType andType:@"服务说明"];
    }
    explain.SGoodsExplainBack = ^{
        [explain dismissViewControllerAnimated:YES completion:nil];
    };
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
    
    if (ScreenW < 375) {
        nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        self.navigationItem.titleView = nav;
        nav.twoBtn_WWW.constant = 50;
    } else {
        nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
        self.navigationItem.titleView = nav;
        nav.twoBtn_WWW.constant = 70;
    }
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    _carNum.layer.masksToBounds = YES;
    _carNum.layer.cornerRadius = _carNum.frame.size.width/2;
    //商品
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //评价
    [nav.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
    [nav.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //详情
    if (_overType==NULL||[_overType isEqualToString:@"拼单购"]||[_overType isEqualToString:@"无界商店"] ){
            [nav.threeBtn setTitle:@"素材" forState:UIControlStateNormal];
    }
    else
    {
    [nav.threeBtn setTitle:@"详情" forState:UIControlStateNormal];
    }
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //默认商品选中
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //置顶
    _moveTopBtn.hidden = YES;
    [_moveTopBtn addTarget:self action:@selector(moveTopBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)lefthBtnClick {
    
    /*
     *添加退出团购时,发出的通知消息,目的是当退出团购的界面的时候,关闭拼团倒计时的定时器
     */
    if ([_overType isEqualToString:@"拼单购"]) {    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QuitGroupBuy" object:nil userInfo:nil];
    }
    /*
     *当前控制器是通过pop的方式退出
     */
    self.isPop = YES;
    
    /*
     *返回上一层的时候,关闭GCD定时器
     */
    if(dynamicAlertTimer){
       dispatch_source_cancel(dynamicAlertTimer);
    }
    /*
     *返回上一页面的block回调,用于在拼单购商品列表中,继续开始通知消息的轮播动画
     */
    if (self.PopGoodsInforBlock) {
        self.PopGoodsInforBlock();
    }
    
    /*
     *退出当前界面恢复初始化值
     */
    BuyForNow = @"";
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
    
//    if (group_arr.count == 0) {
//        //如果没有优惠一起买
//        if (arr.count%2 == 0) {
//            if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 + 64) animated:YES];
//            } else {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 + 64) animated:YES];
//            }
//        } else {
//            if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 + 64) animated:YES];
//
//            } else {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 + 64) animated:YES];
//
//            }
//        }
//    } else {
//        if (arr.count%2 == 0) {
//            if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 450 + 64) animated:YES];
//            } else {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 450 + 64) animated:YES];
//
//            }
//
//        } else {
//            if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 450 + 64) animated:YES];
//
//            } else {
//                [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 450 + 64) animated:YES];
//
//            }
//
//        }
//    }//旧代码
    
    
    
    /*
     *点击评论按钮,定位到评论内容模块
     */
    if (_mCollect.contentOffset.y != goodContentY) {//判断当前内容显示的位置和_mCollect的偏移是否一样,以判断需不需要滚动
        self.isClickDetailBtn = NO;
        self.isClickContentBtn = YES;//是否点击的是评论按钮
        [_mCollect setContentOffset:CGPointMake(0, goodContentY > 1 ? goodContentY : 2000) animated:YES];//设置偏移,当已获取到确定的Y坐标后,就使用确定的Y坐标
    }
    

}
#pragma mark - 详情
- (void)threeBtnClick {
    
//    if (arr.count%2 == 0) {
//        if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//            [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height  - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 + 64) animated:YES];
//
//        } else {
//            [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 + 64) animated:YES];
//        }
//    } else {
//        if ([nowType isEqualToString:@"2"]||[nowType isEqualToString:@"3"]) {
//            [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 + 64) animated:YES];
//
//        } else {
//            [_mCollect setContentOffset:CGPointMake(0, _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 + 64) animated:YES];
//        }
//    }//旧代码
    
    
#pragma mark 素材
    if (_overType==NULL||[_overType isEqualToString:@"拼单购"]||[_overType isEqualToString:@"无界商店"]) {
       
    SGoodsInfor_firstPoster *post=[[SGoodsInfor_firstPoster alloc]init];
    if (_overType==NULL) {
         post.goodsInfor= goodsGoodsInfo;
        if (_is_active_5) {
            post.is_active_5=@"5";//爆款专区
            post.type=@"11";
        }
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
        post.LimitBuyInfo= LimitBuyInfo;
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        post.GroupBuyInfo= GroupBuyInfo;
        post.goodid=_goods_id;
        
        if ([group_buy_type_status isEqualToString:@"1"]) {
          post.type=@"21";
            
        }else{
          post.type=@"22";
        }
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
         post.preBuyPreBuyInfo= preBuyPreBuyInfo;
    }
    
        
    if ([_overType isEqualToString:@"无界商店"])
        {
               post.integralBuyIntegralBuyInfo= integralBuyIntegralBuyInfo;
             post.goodid=_goods_id;
        }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
           post.sgiftDetailModel= sgiftDetailModel;
    }
    post.overType=_overType;
    [self.navigationController pushViewController:post animated:YES];
    }
    /*
     *点击详情按钮,定位到详情内容模块
     */
    else
    {
    if (_mCollect.contentOffset.y != goodDetailY) {//判断当前内容显示的位置和_mCollect的偏移是否一样,以判断需不需要滚动
        self.isClickContentBtn = NO;
        self.isClickDetailBtn = YES;//是否点击的是详情按钮
        [_mCollect setContentOffset:CGPointMake(0, goodDetailY > 1 ? goodDetailY : _mCollect.contentOffset.y + 2000) animated:YES];//设置偏移,当已获取到确定的Y坐标后,就使用确定的Y坐标
    }
    }
    
}
#pragma mark - 分享
- (void)rightBtnClick {
    if ([_overType isEqualToString:@"拼单购"]) {
        NSString *shareType;
        if ( [group_buy_type_status  isEqualToString:@"1"]) {
            shareType=@"10";
        }
        else
        {
           shareType=@"9";
        }

        BaseShare *share = [[BaseShare alloc]init];
        NSDictionary *parametersDit = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",_goods_id,@"id",nil];
        NSDictionary *shareParameters = [NSDictionary dictionaryWithObjectsAndKeys:share_img == nil ? @"" : share_img,@"shareGoodsImage",share_title == nil ? @"" : share_title,@"shareGoodsName",share_content == nil ? @"" : share_content,@"content",collect_id == nil ? @"" : collect_id,@"id_val",shareType,@"type",nil];
        [share shareApi:ShareGroupBuyOrder andParameters:parametersDit andViewController:self andShareParameters:shareParameters];
    } else {
        //商品详情
        AShare * shareVC = [[AShare alloc] init];
        if ([_overType isEqualToString:@"无界商店"]) {
            shareVC.thisUrl = [NSString stringWithFormat:@"%@IntegralBuy/integralBuyInfo/integral_buy_id/%@%@.html", SharedWapUrl, _goods_id, [SRegisterLogin shareAppendInviteCode]];
        }
       else if ([_overType isEqualToString:@"赠品专区"]) {
            shareVC.thisUrl = [NSString stringWithFormat:@"%@GiftGoods/giftGoodsInfo/gift_goods_id/%@%@.html", SharedWapUrl, _gift_goods_id, [SRegisterLogin shareAppendInviteCode]];
           collect_id=_gift_goods_id;
        }
        else{
           shareVC.thisUrl = SharedWapGoodsInfoUrl(_goods_id);
        }
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
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                });
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
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                });
                
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
    top = [[SGoodsInfor_firstView alloc] init];
    [_mCollect addSubview:top];
    
    _mCollect.showsVerticalScrollIndicator = NO;
#pragma mark - 价格说明
    [top.priceInterBtn addTarget:self action:@selector(priceInterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark - 代金券说明  手气排行
    [top.dj_ticketBtn addTarget:self action:@selector(dj_ticketBtnClick) forControlEvents:UIControlEventTouchUpInside];
#pragma mark - 无界商店进行兑换
    [top.use_integralBtn addTarget:self action:@selector(use_integralBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _addNowBtn.hidden = YES;
    _addBuyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _addCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (_overType == nil) {
        //普通商品详情、票券区详情
        top.overTimeView.hidden = YES;
        top.overTime_HHH.constant = 0;
        top.needInterView.hidden = YES;
        top.needInter_HHH.constant = 0;
        top.lastTimeView.hidden = YES;
        top.lastTime_HHH.constant = 0;
        top.actionView.hidden = YES;
        top.action_HHH.constant = 0;
        top.blueView.hidden = YES;
        top.blue_HHH.constant = 0;
    }
    if ([_overType isEqualToString:@"限量购"]) {
        top.overTime_needImage.hidden = YES;
        top.overTime_needTitle.hidden = YES;
        top.threeNumView.hidden = YES;
        top.threeNum_HHH.constant = 0;
        top.intergChangeView.hidden = YES;
        top.intergChange_HHH.constant = 0;
        top.needInterView.hidden = YES;
        top.needInter_HHH.constant = 0;
        top.lastTimeView.hidden = YES;
        top.lastTime_HHH.constant = 0;
        top.actionView.hidden = YES;
        top.action_HHH.constant = 0;
        top.proBlue_leftNum.hidden = YES;
        _addNowBtn.hidden = NO;
        [_addNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        top.priceExplainView.hidden = YES;
        top.priceExplain_HHH.constant = 0;
        top.threeNumView.hidden = YES;
        top.threeNum_HHH.constant = 0;
        top.intergChangeView.hidden = YES;
        top.intergChange_HHH.constant = 0;
       // top.introductView.hidden = YES;
       // top.introduct_HHH.constant = 0;
        top.overTimeView.hidden = YES;
        top.overTime_HHH.constant = 0;
        top.needInterView.hidden = YES;
        top.needInter_HHH.constant = 0;
        top.lastTimeView.hidden = YES;
        top.lastTime_HHH.constant = 0;
        top.actionView.hidden = YES;
        top.action_HHH.constant = 0;
        top.blueView.hidden = YES;
        /*
         *设置拼单购中,进度条的颜色
         */
        top.proBlue.progressTintColor = [UIColor redColor];
        top.proBlue.trackTintColor = [UIColor lightGrayColor];
        top.blue_HHH.constant = 0;
        [_addBuyBtn setTitle:@"去拼单" forState:UIControlStateNormal];
    }
    if ([_overType isEqualToString:@"无界预购"]) {
        top.threeNumView.hidden = YES;
        top.threeNum_HHH.constant = 0;
        top.intergChangeView.hidden = YES;
        top.intergChange_HHH.constant = 0;
        _addNowBtn.hidden = NO;
        [_addNowBtn setTitle:@"交付定金" forState:UIControlStateNormal];
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        top.overTimeView.hidden = YES;
        top.overTime_HHH.constant = 0;
        top.priceExplainView.hidden = YES;
        top.priceExplain_HHH.constant = 0;
        top.threeNumView.hidden = YES;
        top.threeNum_HHH.constant = 0;
        top.intergChangeView.hidden = YES;
        top.intergChange_HHH.constant = 0;
        top.needInterView.hidden = YES;
        top.needInter_HHH.constant = 0;
        top.lastTimeView.hidden = YES;
        top.lastTime_HHH.constant = 0;
        top.actionView.hidden = YES;
        top.action_HHH.constant = 0;
        top.blueView.hidden = YES;
        top.blue_HHH.constant = 0;
        top.dj_ticketView.hidden = YES;
        _addCarBtn.hidden = YES;
        _addNowBtn.hidden = NO;
    }
    if ([_overType isEqualToString:@"赠品专区"]) {
        top.overTimeView.hidden = YES;
        top.overTime_HHH.constant = 0;
        top.priceExplainView.hidden = YES;
        top.priceExplain_HHH.constant = 0;
        top.threeNumView.hidden = YES;
        top.threeNum_HHH.constant = 0;
        top.intergChangeView.hidden = YES;
        top.intergChange_HHH.constant = 0;
        top.needInterView.hidden = YES;
        top.needInter_HHH.constant = 0;
        top.lastTimeView.hidden = YES;
        top.lastTime_HHH.constant = 0;
        top.actionView.hidden = YES;
        top.action_HHH.constant = 0;
        top.blueView.hidden = YES;
        top.blue_HHH.constant = 0;
        top.dj_ticketView.hidden = YES;
        _addCarBtn.hidden = YES;
        _addNowBtn.hidden = NO;
    }
    
    //加入购物车
    [_addCarBtn addTarget:self action:@selector(addCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //立即购买
    [_addBuyBtn addTarget:self action:@selector(addBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_zeroCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_zeroCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_oneCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_oneCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_twoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_twoCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_threeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_threeCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_first_fourCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_first_fourCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_groupCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"QGoodsInfor_first_groupCell"];
    
     [_mCollect registerNib:[UINib nibWithNibName:@"SGroupBuyLuckHandListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGroupBuyLuckHandListCell"];

    //Header
    [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_header0Reusa" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header0Reusa"];
    [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_header1Reusa" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header1Reusa"];
    [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_header2Reusa" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header2Reusa"];
    [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_header3Reusa" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header3Reusa"];
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView_clear"];

}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        if ([_overType isEqualToString:@"无界商店"] || _is_active ||[_overType isEqualToString:@"赠品专区"] ) {
            return 0;
        }
       else if ([group_buy_type_status isEqualToString:@"1"]) {
            return group_rank.count;
        }
        else
        {
        if (dj_ticket.count > 2) {
            return 2;
        }
        else
        {
        return dj_ticket.count;
        }
        }
    }
    if (section == 1) {
        if ([_overType isEqualToString:@"限量购"]) {
            return 0;
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            return 0;
        }
        if ([_overType isEqualToString:@"无界商店"]) {
            return 0;
        }
        return goods_active.count;
    }
    if (section == 2) {
        return promotion.count;
    }
    if (section == 3) {
        if ([_overType isEqualToString:@"拼单购"]) {
//            return group_arr.count;//旧代码
            
            /*
             *设置拼单商品详情页面最多只显示两个拼单的信息
             */
            if (group_arr.count > 2) {
                return 2;
            }else{
             return group_arr.count;
            }
        }
        return 0;
    }
    if (section == 4) {
        if ([nowType isEqualToString:@"2"]) {
//            return goods_common_attr.count;
            return 0;
        }
        return 0;
    }
    return arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        if ([_overType isEqualToString:@"限量购"]) {
            return UIEdgeInsetsMake(ScreenW + 380 + 30 - is_EndNew_Bool_num - dj_ticket_num - overTimeView_num , 0, 0, 0);
        }
        if ([_overType isEqualToString:@"拼单购"]) {
            /*
             *体验拼单时 collectionView的sectionInset(因为又添加了进度条 , 以后可以考虑一下直接返回top的最大Y值)
             */
//            if ([group_buy_type_status isEqualToString:@"1"]&&![Url_header isEqualToString:@"api"]) {
//                return UIEdgeInsetsMake(ScreenW + 380 - 170 - is_EndNew_Bool_num - dj_ticket_num + top.blue_HHH.constant + top.introduct_HHH.constant, 0, 0, 0);
//            }
            return UIEdgeInsetsMake(ScreenW + 380 - 170 - is_EndNew_Bool_num - dj_ticket_num +top.blue_HHH.constant + top.introduct_HHH.constant, 0, 0, 0);
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            return UIEdgeInsetsMake(ScreenW + 380 + 180 - is_EndNew_Bool_num - dj_ticket_num - is_integral_num - 50 + action_num - overTimeView_num, 0, 0, 0);
        }
        if ([_overType isEqualToString:@"无界商店"]||[_overType isEqualToString:@"赠品专区"]) {
            return UIEdgeInsetsMake(ScreenW + 250 - is_EndNew_Bool_num - dj_ticket_num, 0, 0, 0);
        }
        
        if (_is_active) { //2980
            return UIEdgeInsetsMake(top.frame.size.height - 10, 0, 0, 0);
        }
        if (_is_active_7) {
            return UIEdgeInsetsMake(ScreenW + 380+50 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num-50-priceView_num, 0, 0, 0);
        }
        return UIEdgeInsetsMake(ScreenW + 380 - is_EndNew_Bool_num - dj_ticket_num - intergChange_num, 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return 0.01;
    }
    return 5;
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return 0.01;
    }
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        return CGSizeMake(ScreenW, 50);
    }
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        CGSize size = {ScreenW,60};
        return size;
    }
    if (section == 2) {
        if (promotion.count == 0) {
            CGSize size = {ScreenW,60};
            return size;
        }
        CGSize size = {ScreenW,120};
        return size;
    }
    if (section == 3) {
        if ([_overType isEqualToString:@"拼单购"]) {
            CGSize size = {ScreenW,370 - ticketList_num - group_arr_num};
            return size;
        }
        CGSize size = {ScreenW,370 - ticketList_num - 60};
        return size;
    }
    if (section == 4) {
        if ([nowType isEqualToString:@"1"]) {
            CGSize size = {ScreenW,1085 - total_num - goods_num - 50 - 50 - 100 - 50 - 50 - 50 - 10 - 10 + wek_web_num};
            return size;
        }
        if ([nowType isEqualToString:@"2"]) {
            CGSize size = {ScreenW,1085 - total_num - goods_num - 50 - 50 - 100 - 50 - 50 - 50 - 10 - 10 + attr_num};
            return size;
        }
        CGSize size = {ScreenW,1085 - total_num - goods_num - 50 - 50 - 100 + package_list_num + after_sale_service_num + price_desc_num};
        return size;
    }
    
    CGSize size = {0.01,0.01};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        CGSize size = {ScreenW,50};
        return size;
    }
    if (section == 5) {
        CGSize size = {ScreenW,5};
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
            QGoodsInfor_first_header0Reusa * header = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header0Reusa" forIndexPath:indexPath];
//            [header.choiceTypeBtn addTarget:self action:@selector(choiceTypeClick_0Reus) forControlEvents:UIControlEventTouchUpInside];
            
            header.choiceContent.text = model_choiceContent;
            [header.choiceTypeBtn addTarget:self action:@selector(choiceTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            reusableview = header;
        } else if (indexPath.section == 2) {
            QGoodsInfor_first_header1Reusa * header = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header1Reusa" forIndexPath:indexPath];
            
            [header.country_logo sd_setImageWithURL:[NSURL URLWithString:country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            header.country_desc.text = country_desc;
            
            if ([country_tax floatValue] > 0) {
                header.price.hidden = NO;
            } else {
                header.price.hidden = YES;
            }
            /*
             *修改进口税显示的信息,添加"元 /件"单位信息
             *无界商店 修改进口税显示的信息,"积分 /件"单位信息 by_fxg
             */
            NSString *replaceText = @"";
            if ([_overType isEqualToString:@"无界商店"]){
                replaceText = @"积分";
            }else{
                replaceText = @"元";
            }
            
            NSMutableAttributedString * attributedStr_cityPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"进口税  %@%@ /件",country_tax,replaceText]];
            [attributedStr_cityPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, country_tax.length + replaceText.length)];
            header.price.attributedText = attributedStr_cityPrice;
            
            if (promotion.count == 0) {
                header.promotionView.hidden = YES;
            } else {
                header.promotionView.hidden = NO;
            }
            
            //促销
            [header.promotionBtn addTarget:self action:@selector(promotionBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            reusableview = header;
        } else if (indexPath.section == 3) {
            header2 = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header2Reusa" forIndexPath:indexPath];
            header2.remarks.text = model_remarks;
            header2.send_Content.text = [NSString stringWithFormat:@"送至    %@%@%@",now_province,now_city,now_area];
         
               header2.price.attributedText = now_freight;
           

            if (ticketList.count == 0) {
                header2.one_ticketList.hidden = YES;
                header2.two_ticketList.hidden = YES;
                header2.ticketView_topHHH.constant = 0;
                header2.ticketView.hidden = YES;
                header2.ticketView_HHH.constant = 0;
                header2.ticketView_sub.hidden = YES;
                header2.ticketView_sub_HHH.constant = 0;
            }
            if (ticketList.count == 1) {
                header2.one_ticketList.hidden = NO;
                header2.two_ticketList.hidden = YES;
                
                if (_overType == nil) {
                    SGoodsGoodsInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"限量购"]) {
                    SLimitBuyLimitBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"拼单购"]) {
                    SGroupBuyGroupBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"无界预购"]) {
                    SPreBuyPreBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                }
                if ([_overType isEqualToString:@"无界商店"]) {
                    SIntegralBuyIntegralBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"赠品专区"]) {
                    SgiftDetailModel * infor = ticketList.firstObject;
                    //                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
            }
            if (ticketList.count > 1) {
                header2.one_ticketList.hidden = NO;
                header2.two_ticketList.hidden = NO;
                
                if (_overType == nil) {
                    SGoodsGoodsInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SGoodsGoodsInfo * infor1 = ticketList[1];
//                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"限量购"]) {
                    SLimitBuyLimitBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SLimitBuyLimitBuyInfo * infor1 = ticketList[1];
//                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"拼单购"]) {
                    SGroupBuyGroupBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SGroupBuyGroupBuyInfo * infor1 = ticketList[1];
//                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"无界预购"]) {
                    SPreBuyPreBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SPreBuyPreBuyInfo * infor1 = ticketList[1];
//                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"无界商店"]) {
                    SIntegralBuyIntegralBuyInfo * infor = ticketList.firstObject;
//                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SIntegralBuyIntegralBuyInfo * infor1 = ticketList[1];
//                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
                if ([_overType isEqualToString:@"赠品专区"]) {
                    SgiftDetailModel * infor = ticketList.firstObject;
                    //                    header2.one_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
                    header2.one_value.text = infor.value_replace;
                    header2.one_condition.text = infor.ticket_name;
                    [header2.one_ticketListBtn setTag:[infor.ticket_id integerValue]];
                    if ([infor.get_receive isEqualToString:@"0"]) {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.one_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                    
                    SgiftDetailModel * infor1 = ticketList[1];
                    //                    header2.two_value.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor1.value];
                    header2.two_value.text = infor1.value_replace;
                    header2.two_condition.text = infor1.ticket_name;
                    [header2.two_ticketListBtn setTag:[infor1.ticket_id integerValue]];
                    if ([infor1.get_receive isEqualToString:@"0"]) {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵"];
                    } else {
                        header2.two_ticketListGround.image = [UIImage imageNamed:@"优惠劵已领"];
                    }
                }
            }
            //领券1
            [header2.one_ticketListBtn addTarget:self action:@selector(one_ticketListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //领券2
            [header2.two_ticketListBtn addTarget:self action:@selector(two_ticketListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
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
                
                SGoodsGoodsInfo * server_infor = goods_server.firstObject;
                [header2.goods_server_oneImage sd_setImageWithURL:[NSURL URLWithString:server_infor.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_oneTitle.text = server_infor.server_name;
                
                
                
            } else if (goods_server.count > 1) {
                header2.goods_server_oneImage.hidden = NO;
                header2.goods_server_oneTitle.hidden = NO;
                header2.goods_server_twoImage.hidden = NO;
                header2.goods_server_twoTitle.hidden = NO;
                
                SGoodsGoodsInfo * server_infor = goods_server.firstObject;
                [header2.goods_server_oneImage sd_setImageWithURL:[NSURL URLWithString:server_infor.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_oneTitle.text = server_infor.server_name;
                
                SGoodsGoodsInfo * server_infor1 = goods_server[1];
                [header2.goods_server_twoImage sd_setImageWithURL:[NSURL URLWithString:server_infor1.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                header2.goods_server_twoTitle.text = server_infor1.server_name;
            }
            
            
            header2.InnView.hidden = YES;
            if ([_overType isEqualToString:@"拼单购"]) {
                if (group_arr.count != 0) {
                    header2.InnView.hidden = NO;
//                    header2.InnTitle.text = @"别人在开团";
                    header2.seeMoreTipLabel.hidden = NO;
                    header2.InnTitle.text = [NSString stringWithFormat:@" %@ 人在拼单",groupCount];
                }
            }
            [header2.serverBtn setTag:1];
            //规格参数
            [header2.serverBtn addTarget:self action:@selector(priceInterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //配送地区
            [header2.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
            //领券
            [header2.couponsBtn addTarget:self action:@selector(couponsBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            /*
             *添加店家查看更多拼单信息事件
             */
            [header2.MoreActivityButton addTarget:self action:@selector(ShowMoreGroup:) forControlEvents:UIControlEventTouchUpInside];
            
            reusableview = header2;
        } else {
            header3 = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QGoodsInfor_first_header3Reusa" forIndexPath:indexPath];
            
            if ([total integerValue] == 0) {
                //商品没有评价
                header3.eva_topHHH.constant = 0;
                header3.eva_TitleView.hidden = YES;
                header3.eva_TitleViewHHH.constant = 0;
                header3.evaHiddenView.hidden = YES;
                header3.evaHiddenView_HHH.constant = 0;
            } else {
                //商品有评价
                header3.eva_topHHH.constant = 10;
                header3.eva_TitleView.hidden = NO;
                header3.eva_TitleViewHHH.constant = 40;
                header3.evaHiddenView.hidden = NO;
                
                if (pictures.count == 0) {
                    //商品评价没有上传图片
                    header3.evaHiddenView_HHH.constant = 100;
                    header3.evaImageView.hidden = YES;
                    header3.evaImageView_HHH.constant = 0;
                } else {
                    //商品评价有上传图片
                    header3.evaHiddenView_HHH.constant = 200;
                    header3.evaImageView.hidden = NO;
                    header3.evaImageView_HHH.constant = 100;
                }
            }
            
            header3.total.text = [NSString stringWithFormat:@"商品评价（%@）",total];
//            [header3.headerImage sd_setImageWithURL:[NSURL URLWithString:user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            /*
             *更换默认占位图
             */
            [header3.headerImage sd_setImageWithURL:[NSURL URLWithString:user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            header3.nickname.text = nickname;
            header3.thisContent.text = content;
            header3.create_time.text = create_time;
            //评价图
            [header3 showModel:pictures];

//            [header3.logo sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            /*
             *更换默认占位图
             */
            [header3.logo sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            header3.merchant_name.text = merchant_name;
            for (UIView * view in header3.starView.subviews) {
                [view removeFromSuperview];
            }
            for (int i = 0; i < [level integerValue]; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                [header3.starView addSubview:imageView];
                imageView.image = [UIImage imageNamed:@"皇冠"];
            }
            header3.all_goods.text = all_goods;
            header3.view_num.text = view_num;
            NSMutableAttributedString * attributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"宝贝描述%@",goods_score]];
            [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, goods_score.length)];
            header3.num1.attributedText = attributedStr1;
            
            NSMutableAttributedString * attributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家服务%@",merchant_score]];
            [attributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, merchant_score.length)];
            header3.num2.attributedText = attributedStr2;
            
            NSMutableAttributedString * attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流服务%@",shipping_score]];
            [attributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, shipping_score.length)];
            header3.num3.attributedText = attributedStr3;
            
            if ([ticket_buy_discount integerValue] == 0) {
                header3.collocationR.backgroundColor = WordColor_sub_sub;
                header3.collocationR.text = @"不可使用代金券";
            } else {
                header3.collocationR.backgroundColor = [UIColor orangeColor];
                header3.collocationR.text = [NSString stringWithFormat:@"最多可用%@%%代金券",ticket_buy_discount];
            }
            header3.group_price.text = [NSString stringWithFormat:@"搭配价：￥%@",group_price];
            header3.integral.text = integral;
            header3.delPriceR.text = [NSString stringWithFormat:@"立省￥%@",goods_price];
            
            [header3 showModelBrr:goods];
            
            
            if (goods.count == 0) {
                
                header3.collocation_topHHH.constant = 0;
                header3.collocation_TitleView.hidden = YES;
                header3.collocation_TitleViewHHH.constant = 0;
                header3.collocationView.hidden = YES;
                header3.collocation_HHH.constant = 0;
                header3.collocation_DownView.hidden = YES;
                header3.collocation_DownViewHHH.constant = 0;
            } else {
                header3.collocation_topHHH.constant = 10;
                header3.collocation_TitleView.hidden = NO;
                header3.collocation_TitleViewHHH.constant = 50;
                header3.collocationView.hidden = NO;
                header3.collocation_HHH.constant = 100;
                header3.collocation_DownView.hidden = NO;
                header3.collocation_DownViewHHH.constant = 50;
            }
            
            header3.package_list.text = package_list;
            header3.after_sale_service.text = after_sale_service;
            header3.price_desc.text = price_desc;
            
            if ([nowType isEqualToString:@"1"]) {
                [header3.down_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [header3.down_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header3.down_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];

                if (goods_desc != nil) {
                    [header3 wk_web:goods_desc];
                }
                header3.attr_table.hidden = YES;
            }
            if ([nowType isEqualToString:@"2"]) {
                [header3.down_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header3.down_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [header3.down_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
                header3.attr_table.hidden = NO;

                attr_num = 0;
                for (NSDictionary * infor in goods_common_attr) {
                            NSArray *arr=infor[@"list"];
                            attr_num += arr.count;
                    }
                attr_num = attr_num * 50 + goods_common_attr.count * 50;
                [header3 showAttrModel:goods_common_attr andType:_overType];
                
            }
            if ([nowType isEqualToString:@"3"]) {
                [header3.down_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header3.down_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
                [header3.down_threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                header3.attr_table.hidden = YES;

            }
            if ([nowType isEqualToString:@"1"] || [nowType isEqualToString:@"2"]) {
                header3.thisWk_web.hidden = NO;
                
                
                header3.package_list_HHH.constant = 0;
                header3.after_sale_service_HHH.constant = 0;
                header3.price_desc_HHH.constant = 0;
                header3.package_listView.hidden = YES;
                header3.after_sale_serviceView.hidden = YES;
                header3.price_descView.hidden = YES;
                
                header3.downOne.hidden = YES;
                header3.downTwo.hidden = YES;
                header3.donwThree.hidden = YES;
                header3.downOne_HHH.constant = 0;
                header3.downTwo_HHH.constant = 0;
                header3.downThree_HHH.constant = 0;
                header3.downTwo_topHHH.constant = 0;
                header3.downThree_topHHH.constant = 0;
                
            } else if ([nowType isEqualToString:@"3"]) {
                header3.thisWk_web.hidden = YES;

                header3.package_list_HHH.constant = package_list_num;
                header3.after_sale_service_HHH.constant = after_sale_service_num;
                header3.price_desc_HHH.constant = price_desc_num;
                header3.package_listView.hidden = NO;
                header3.after_sale_serviceView.hidden = NO;
                header3.price_descView.hidden = NO;
                
                header3.downOne.hidden = NO;
                header3.downTwo.hidden = NO;
                header3.donwThree.hidden = NO;
                header3.downOne_HHH.constant = 50;
                header3.downTwo_HHH.constant = 50;
                header3.downThree_HHH.constant = 50;
                header3.downTwo_topHHH.constant = 10;
                header3.downThree_topHHH.constant = 10;
            }
            header3.QGoodsInfor_first_header3Reusa_HTML = ^(NSInteger num) {
                wek_web_num = num + 15;
                [ _mCollect reloadData];
            };
            //全部评价
            [header3.evaBtn addTarget:self action:@selector(evaBtnClick) forControlEvents:UIControlEventTouchUpInside];
            //商品介绍
            header3.QGoodsInfor_first_header3Reusa_downOneBtn = ^{
                nowType = @"1";
                [_mCollect reloadData];
            };
            //规格参数
            header3.QGoodsInfor_first_header3Reusa_downTwoBtn = ^{
                nowType = @"2";
                attr_num = 0;
                for (NSDictionary * infor in goods_common_attr) {
                    NSArray *arr=infor[@"list"];
                    attr_num += arr.count;
                }
                attr_num = attr_num * 50  + goods_common_attr.count * 50;
                [header3 showAttrModel:goods_common_attr andType:_overType];

                [_mCollect reloadData];
            };
            //包装售后
            header3.QGoodsInfor_first_header3Reusa_downThreeBtn = ^{
                nowType = @"3";
                [_mCollect reloadData];
            };
            //查看分类
            [header3.oneBtn addTarget:self action:@selector(lookTypeClick) forControlEvents:UIControlEventTouchUpInside];
            //进店逛逛
            [header3.twoBtn addTarget:self action:@selector(shopAroundClick) forControlEvents:UIControlEventTouchUpInside];
            //搭配购
            [header3.groupGoodsBtn addTarget:self action:@selector(groupGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
            //看图
            header3.QGoodsInfor_first_header3Reusa_showImage = ^{
                NSMutableArray * photos = [NSMutableArray arrayWithCapacity:html_imageArr.count];
                
                for (int i = 0; i < html_imageArr.count; i++) {
                    ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                    photo.photoURL = [NSURL URLWithString:html_imageArr[i]];
                    [photos addObject:photo];
                }
                
                ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
                // 淡入淡出效果
                // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
                // 数据源/delegate
                pickerBrowser.editing = YES;
                pickerBrowser.photos = photos.mutableCopy;
                // 能够删除
                pickerBrowser.delegate = self;
                // 当前选中的值
                pickerBrowser.currentIndex = 0;
                // 展示控制器
                [pickerBrowser showPickerVc:self];
            };
            
            reusableview = header3;
        }
        
    }// header;
    if (kind == UICollectionElementKindSectionFooter) {
        
        if (indexPath.section == 4) {
           
            
            
            UICollectionReusableView * footer = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            for (UIView * view in footer.subviews) {
                [view removeFromSuperview];
            }
             if (![_overType isEqualToString:@"赠品专区"]) {
            UILabel * footer_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
            [footer addSubview:footer_title];
            footer_title.text = @"猜你喜欢";
            footer_title.font = [UIFont systemFontOfSize:14];
            footer_title.textColor = WordColor_sub;
            footer_title.textAlignment = NSTextAlignmentCenter;
             }
            
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
    eva.goods_id = collect_id;
    [self.navigationController pushViewController:eva animated:YES];
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //可使用代金券情况
    if (indexPath.section == 0) {
        if ([group_buy_type_status isEqualToString:@"1"]) {
           SGroupBuyLuckHandListCell * oneCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGroupBuyLuckHandListCell" forIndexPath:indexPath];
             SGroupBuyGroupBuyInfo * infor = group_rank[indexPath.row];
            
            oneCell.lab_name.text=infor.user_name;
            oneCell.lab_price.text=infor.user_count;
            [oneCell.ima_head sd_setImageWithURL:[NSURL URLWithString:infor.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            if ([infor.rank isEqualToString:@"1"]) {
                oneCell.lab_rank.hidden=YES;
                oneCell.ima_grade.hidden=NO;
                oneCell.ima_grade.image=[UIImage imageNamed:@"手气-1"];
            }
            else if ([infor.rank isEqualToString:@"2"])
            {
                oneCell.lab_rank.hidden=YES;
                  oneCell.ima_grade.hidden=NO;
                oneCell.ima_grade.image=[UIImage imageNamed:@"手气-2"];
            }
            else if ([infor.rank isEqualToString:@"3"])
            {
                oneCell.lab_rank.hidden=YES;
                oneCell.ima_grade.hidden=NO;
                oneCell.ima_grade.image=[UIImage imageNamed:@"手气-3"];
            }
            else
            {
                oneCell.lab_rank.hidden=NO;
                oneCell.lab_rank.text=infor.rank;
                oneCell.ima_grade.hidden=YES;
        
            }
            return oneCell;
    
        }else{

        SGoodsInfor_first_oneCell * oneCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_oneCell" forIndexPath:indexPath];
        
        if (choice_shop_price == nil) {
            if (_overType == nil) {
                SGoodsGoodsInfo * infor = dj_ticket[indexPath.row];
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
            }
            if ([_overType isEqualToString:@"限量购"]) {
                SLimitBuyLimitBuyInfo  * infor = dj_ticket[indexPath.row];
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
            }
            if ([_overType isEqualToString:@"拼单购"]) {
                SGroupBuyGroupBuyInfo  * infor = dj_ticket[indexPath.row];
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
            }
            if ([_overType isEqualToString:@"无界预购"]) {
                SPreBuyPreBuyInfo  * infor = dj_ticket[indexPath.row];
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
            }
            if ([_overType isEqualToString:@"无界商店"]) {
                SIntegralBuyIntegralBuyInfo  * infor = dj_ticket[indexPath.row];
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
            }
            if ([_overType isEqualToString:@"赠品专区"]) {
                SgiftDetailModel  * infor = dj_ticket[indexPath.row];
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
            }
        } else {
            
            SGoodsAttrApi  * infor = dj_ticket[indexPath.row];
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
        }
        
        
        return oneCell;
        }
    }
    //活动
    if (indexPath.section == 1) {
        SGoodsInfor_first_zeroCell * oneCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_zeroCell" forIndexPath:indexPath];
        
        if (_overType == nil) {
            SGoodsGoodsInfo * infor = goods_active[indexPath.row];
            oneCell.act_desc.text = infor.act_desc;
        }
        
        //限量购原图是没有的，所以隐藏
//        if ([_overType isEqualToString:@"限量购"]) {
//            SLimitBuyLimitBuyInfo * infor = goods_active[indexPath.row];
//            oneCell.act_desc.text = infor.act_desc;
//        }
        
        if ([_overType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * infor = goods_active[indexPath.row];
            oneCell.act_desc.text = infor.act_desc;
        }
        //无界预购原图是没有的，所以隐藏
//        if ([_overType isEqualToString:@"无界预购"]) {
//            SPreBuyPreBuyInfo * infor = goods_active[indexPath.row];
//            oneCell.act_desc.text = infor.act_desc;
//        }
        //无界商店原图是没有的，所以隐藏
//        if ([_overType isEqualToString:@"无界商店"]) {
//            SIntegralBuyIntegralBuyInfo * infor = goods_active[indexPath.row];
//            oneCell.act_desc.text = infor.act_desc;
//        }
        
        return oneCell;
    }
    //促销
    if (indexPath.section == 2) {
        SGoodsInfor_first_twoCell * twoCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_twoCell" forIndexPath:indexPath];
        
        if (_overType == nil) {
            SGoodsGoodsInfo * infor = promotion[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                twoCell.blueR.backgroundColor = MyBlue;
                twoCell.blueR.text = @"满减";
            } else {
                twoCell.blueR.backgroundColor = MyPowder;
                twoCell.blueR.text = @"满折";
            }
            twoCell.thisTitle.text = infor.title;
        }
        if ([_overType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo * infor = promotion[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                twoCell.blueR.backgroundColor = MyBlue;
                twoCell.blueR.text = @"满减";
            } else {
                twoCell.blueR.backgroundColor = MyPowder;
                twoCell.blueR.text = @"满折";
            }
            twoCell.thisTitle.text = infor.title;
        }
        if ([_overType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * infor = promotion[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                twoCell.blueR.backgroundColor = MyBlue;
                twoCell.blueR.text = @"满减";
            } else {
                twoCell.blueR.backgroundColor = MyPowder;
                twoCell.blueR.text = @"满折";
            }
            twoCell.thisTitle.text = infor.title;
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo * infor = promotion[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                twoCell.blueR.backgroundColor = MyBlue;
                twoCell.blueR.text = @"满减";
            } else {
                twoCell.blueR.backgroundColor = MyPowder;
                twoCell.blueR.text = @"满折";
            }
            twoCell.thisTitle.text = infor.title;
        }
        if ([_overType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo * infor = promotion[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                twoCell.blueR.backgroundColor = MyBlue;
                twoCell.blueR.text = @"满减";
            } else {
                twoCell.blueR.backgroundColor = MyPowder;
                twoCell.blueR.text = @"满折";
            }
            twoCell.thisTitle.text = infor.title;
        }
        
        return twoCell;
    }
    //无界驿站
    if (indexPath.section == 3) {
        if ([_overType isEqualToString:@"拼单购"]) {
            QGoodsInfor_first_groupCell * cell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"QGoodsInfor_first_groupCell" forIndexPath:indexPath];
            
            SGroupBuyGroupBuyInfo * list = group_arr[indexPath.row];
            [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_user.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.nickname.text = list.head_user.nickname;
            cell.model = group_arr[indexPath.row];
            
            return cell;
        }
        SGoodsInfor_first_threeCell * threeCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_threeCell" forIndexPath:indexPath];
        
        return threeCell;
    }
    //规格参数
    if (indexPath.section == 4) {
        SGoodsInfor_first_fourCell * fourCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_first_fourCell" forIndexPath:indexPath];
        
        if (_overType == nil) {
            SGoodsGoodsInfo * infor = goods_common_attr[indexPath.row];
            fourCell.attr_name.text = infor.attr_name;
            fourCell.attr_value.text = infor.attr_value;
        }
        if ([_overType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo * infor = goods_common_attr[indexPath.row];
            fourCell.attr_name.text = infor.attr_name;
            fourCell.attr_value.text = infor.attr_value;
        }
        if ([_overType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * infor = goods_common_attr[indexPath.row];
            fourCell.attr_name.text = infor.attr_name;
            fourCell.attr_value.text = infor.attr_value;
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo * infor = goods_common_attr[indexPath.row];
            fourCell.attr_name.text = infor.attr_name;
            fourCell.attr_value.text = infor.attr_value;
        }
        if ([_overType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo * infor = goods_common_attr[indexPath.row];
            fourCell.attr_name.text = infor.attr_name;
            fourCell.attr_value.text = infor.attr_value;
        }
        
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
    
    if (_overType == nil) {
        SGoodsGoodsInfo * list = arr[indexPath.row];
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
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * list = arr[indexPath.row];
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
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * list = arr[indexPath.row];
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
    }
    if ([_overType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * list = arr[indexPath.row];
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
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * list = arr[indexPath.row];
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
    }
    if ([_overType isEqualToString:@"赠品专区"]) {
        SgiftDetailModel * list = arr[indexPath.row];
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
    }
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_overType == nil) {
            SGoodsGoodsInfo * infor = goods_active[indexPath.row];
            
            if ([infor.act_type isEqualToString:@"1"]) {
                SIndianaInfor * info = [[SIndianaInfor alloc] init];
                info.one_buy_id = infor.act_id;
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"2"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"无界预购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"3"]) {
                SLotInfor * lot = [[SLotInfor alloc] init];
                lot.auction_id = infor.act_id;
                lot.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lot animated:YES];
            }
            if ([infor.act_type isEqualToString:@"4"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"限量购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"5"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"拼单购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
        }
        
        if ([_overType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * infor = goods_active[indexPath.row];
            if ([infor.act_type isEqualToString:@"1"]) {
                SIndianaInfor * info = [[SIndianaInfor alloc] init];
                info.one_buy_id = infor.act_id;
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"2"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"无界预购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"3"]) {
                SLotInfor * lot = [[SLotInfor alloc] init];
                lot.auction_id = infor.act_id;
                lot.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lot animated:YES];
            }
            if ([infor.act_type isEqualToString:@"4"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"限量购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
            if ([infor.act_type isEqualToString:@"5"]) {
                SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
                info.goods_id = infor.act_id;
                info.overType = @"拼单购";
                info.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:info animated:YES];
            }
        }

    }
    if (indexPath.section == 3) {
        if ([_overType isEqualToString:@"拼单购"]) {
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
            
            SGroupBuyGroupBuyInfo * list = group_arr[indexPath.row];
#pragma mark -  拼单购 参团 ： 先进入参团界面
            SFightGroups * join = [[SFightGroups alloc] init];
            join.group_buy_order_id = list.id;
            join.goods_id = collect_id;
            join.group_buy_id = _goods_id;
            join.product_id = product_id;
            join.merchant_id = merchant_id;
            join.shop_price_buy = shop_price_buy;
            join.good_img_buy = good_img_buy;
            join.goods_attr_arr = goods_attr_arr;
            join.contrastArr = contrastArr;
            join.GivenIntegral = self.GroupIntegral;
            join.group_buy_type_status = group_buy_type_status;
            join.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:join animated:YES];
        }
    }
    if (indexPath.section == 5) {
        if (_overType == nil) {
            SGoodsGoodsInfo * list = arr[indexPath.row];
            SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
            infor.goods_id = list.goods_id;
            
            [self.navigationController pushViewController:infor animated:YES];
        }
        if ([_overType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo * list = arr[indexPath.row];
            SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
            infor.goods_id = list.goods_id;
            [self.navigationController pushViewController:infor animated:YES];
        }
        if ([_overType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * list = arr[indexPath.row];
            SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
            infor.goods_id = list.goods_id;
            [self.navigationController pushViewController:infor animated:YES];
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo * list = arr[indexPath.row];
            SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
            infor.goods_id = list.goods_id;
            [self.navigationController pushViewController:infor animated:YES];
        }
        if ([_overType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo * list = arr[indexPath.row];
            SGoodsInfor_first * infor = [[SGoodsInfor_first alloc] init];
            infor.goods_id = list.goods_id;
            [self.navigationController pushViewController:infor animated:YES];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenW) {
        _moveTopBtn.hidden = NO;
    } else {
        _moveTopBtn.hidden = YES;
    }
//    if (group_arr.count != 0) {
//        if (arr.count%2 == 0) {
//            if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = NO;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 450 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = NO;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 450 - 20 + 64) {
//                nav.oneLine.hidden = NO;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            }
//        } else {
//            if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = NO;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 450 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = NO;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 450 - 20 + 64) {
//                nav.oneLine.hidden = NO;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            }
//        }
//    } else {
//        if (arr.count%2 == 0) {
//            if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = NO;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = NO;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * arr.count/2 - 185 - 200 - 450 - 20 + 64) {
//                nav.oneLine.hidden = NO;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            }
//        } else {
//            if (scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = NO;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 20 + 64 && scrollView.contentOffset.y >= _mCollect.contentSize.height - wek_web_num - (ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 - 20 + 64) {
//                nav.oneLine.hidden = YES;
//                nav.twoLine.hidden = NO;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            } else if (scrollView.contentOffset.y < _mCollect.contentSize.height - wek_web_num - ( ScreenW/2 - 2.5 + 40 + 30 + 30) * ((arr.count - 1)/2 + 1) - 185 - 200 - 450 - 20 + 64) {
//                nav.oneLine.hidden = NO;
//                nav.twoLine.hidden = YES;
//                nav.threeLine.hidden = YES;
//                [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
//                [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
//            }
//        }
//    }//旧代码
    

    /*
     *只有当点击了评论按钮的时候,执行滚动到评论位置的代码
     */
    if (self.isClickContentBtn) {
        if (header3.frame.origin.y > 1) {
            if (goodContentY <= 1) {
                goodContentY = header3.frame.origin.y;
                [scrollView setContentOffset:CGPointMake(0, header3.frame.origin.y) animated:goodDetailY > 1 ? YES : NO ];
            }
        }
    }
   
#pragma mark 素材
    
    else if (self.isClickDetailBtn) {
        
          if (_overType==NULL||[_overType isEqualToString:@"拼单购"]||[_overType isEqualToString:@"无界商店"] ){
          }
        else
        {
            /*
             *只有当点击了详情按钮的时候,执行滚动到详情位置的代码
             */
        if (header3.frame.origin.y > 1) {
            if (goodDetailY <= 1) {
                goodDetailY = header3.frame.origin.y + header3.goodIntroduceTitleContainView.frame.origin.y - 10;
                [scrollView setContentOffset:CGPointMake(0, header3.frame.origin.y + header3.goodIntroduceTitleContainView.frame.origin.y - 10) animated:goodContentY > 1 ? YES : NO];
            }
        }
        }
    }
    
    /*
     *根据当前的偏移量,设置三个按钮的选中状态
     */
    if (header3.frame.origin.y > 1) {//只有当header3的内容显示的时候,才设置,否则全部显示选中商品按钮
        if (scrollView.contentOffset.y >= header3.frame.origin.y + header3.goodIntroduceTitleContainView.frame.origin.y - 10) {
            if (_overType==NULL||[_overType isEqualToString:@"拼单购"]||[_overType isEqualToString:@"无界商店"]) {}
            else
            {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = YES;
            nav.threeLine.hidden = NO;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        } else if (scrollView.contentOffset.y < header3.frame.origin.y + header3.goodIntroduceTitleContainView.frame.origin.y - 10 && scrollView.contentOffset.y >= header3.frame.origin.y) {
            nav.oneLine.hidden = YES;
            nav.twoLine.hidden = NO;
            nav.threeLine.hidden = YES;
            [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        } else if (scrollView.contentOffset.y < header3.frame.origin.y) {
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

/*
 *当停止滚动的时候,恢复两个判断是否点击按钮的状态为NO
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.isClickContentBtn = NO;
    self.isClickDetailBtn = NO;
}

#pragma mark - 加入购物车 还有其他
- (void)addCarBtnClick {
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
    
    if ([_addCarBtn.titleLabel.text isEqualToString:@"加入购物车"]) {
        //        [self choiceTypeClick:@"加入购物车"];
        
        overAgein = @"2";//选完规格要跳转!加入购物车
        if (choice_shop_price == nil) {
            [self choiceTypeBtnClick];
            return;
        }
        
        SCartAddCart * addCart = [[SCartAddCart alloc] init];
        addCart.goods_id = collect_id;
        addCart.product_id = choice_product_id;
        addCart.num = choice_num;
        [MBProgressHUD showMessage:nil toView:self.view];
        [addCart sCartAddCartSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                overAgein = nil;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    

    if ([_overType isEqualToString:@"拼单购"]) {
        
        /**********************临时解决方案跳转到普通商品类型的详情页面**********************/
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = collect_id;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        
//        overAgein = @"1";//选完规格要跳转!立即购买
//
//        if (choice_shop_price == nil) {
//            [self choiceTypeBtnClick];
//            return;
//        }
//
//        group_buy_isno = @"1";//拼单购 立即购买
////        [self choiceTypeClick:@"立即购买"];
//
//        SOrderConfirm * con = [[SOrderConfirm alloc] init];
//        con.merchant_id = merchant_id;
//        con.goods_id = collect_id;
//        con.num = choice_num;
//        con.product_id = choice_product_id;
//        if ([_overType isEqualToString:@"拼单购"]) {
//            con.special_type = @"拼单购";
//            if ([group_buy_isno isEqualToString:@"1"]) {
//                con.special_type_sub = @"1";//1直接购买 2拼单(开团) 3拼单(参团)
//            } else if ([group_buy_isno isEqualToString:@"2"]) {
//                con.special_type_sub = @"2";//1直接购买 2拼单(开团) 3拼单(参团)
//            } else if ([group_buy_isno isEqualToString:@"3"]) {
//                con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
//            }
//            con.group_buy_id = _goods_id;
//        }
//        if ([_overType isEqualToString:@"无界预购"]) {
//            con.special_type = @"无界预购";
//            con.pre_id = _goods_id;
//        }
//        if ([_overType isEqualToString:@"无界商店"]) {
//            con.special_type = @"无界商店";
//            con.integralBuy_id = _goods_id;
//        }
//        [self.navigationController pushViewController:con animated:YES];
//        overAgein = nil;

    }
}
#pragma mark - 交付定金 立即兑换
- (IBAction)addNowBtn:(UIButton *)sender {
    if (SLimited_isno == YES) {
        return;
    }
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
    if ([sender.titleLabel.text isEqualToString:@"交付定金"]) {
//        [self choiceTypeClick:@"立即购买"];
    }
    /*
     *增加BuyForNow成员变量判断无界商店规格选择和付款的跳转
     */
    if ([sender.titleLabel.text isEqualToString:@"立即兑换"] && [BuyForNow isEqualToString:@""]) {
//        [self choiceTypeClick:@"立即兑换"];
        /*
         *用于在点击立即兑换,选择完商品的规格,直接跳转到确认订单页
         */
        overAgein = @"1";
        [self choiceTypeBtnClick];
    //    }
    }
    /*
     *增加BuyForNow成员变量判断无界商店规格选择和付款的跳转
     */
    if ([sender.titleLabel.text isEqualToString:@"立即购买"] || [BuyForNow isEqualToString:@"立即购买"]) {
        if ([_overType isEqualToString:@"限量购"]) {
            group_buy_isno = @"3";//拼单购 开团
        }
//        [self choiceTypeClick:@"立即购买"];
        
        overAgein = @"1";//选完规格要跳转!立即购买
        if (choice_shop_price == nil) {
            [self choiceTypeBtnClick];
            return;
        }
        
        SOrderConfirm * con = [[SOrderConfirm alloc] init];
        con.merchant_id = merchant_id;
        con.goods_id = collect_id;
        con.num = choice_num;
        con.product_id = choice_product_id;
       
        if ([_overType isEqualToString:@"拼单购"]) {
            con.special_type = @"拼单购";
            if ([group_buy_isno isEqualToString:@"1"]) {
                con.special_type_sub = @"1";//1直接购买 2拼单(开团) 3拼单(参团)
            } else if ([group_buy_isno isEqualToString:@"2"]) {
                con.special_type_sub = @"2";//1直接购买 2拼单(开团) 3拼单(参团)
            } else if ([group_buy_isno isEqualToString:@"3"]) {
                con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
            }
            con.group_buy_id = _goods_id;
        }
        if ([_overType isEqualToString:@"无界预购"]) {
            con.special_type = @"无界预购";
            con.pre_id = _goods_id;
        }
        if ([_overType isEqualToString:@"无界商店"]) {
            con.special_type = @"无界商店";
//            con.integralBuy_id = _goods_id;//旧代码
            /*
             *传递无界商店选中的商品的属性id
             */
            con.integralBuy_id = choice_integral_buy_id;
        }
        if ([_overType isEqualToString:@"赠品专区"]) {
            con.special_type = @"赠品专区";
            //            con.integralBuy_id = _goods_id;//旧代码
            /*
             *传递无界商店选中的商品的属性id
             */
            con.giftGoods_id = _gift_goods_id;
        }
        [self.navigationController pushViewController:con animated:YES];
        overAgein = nil;

    }
}
//- (void)choiceTypeClick_0Reus {
//    [self addBuyBtnClick];
//}
#pragma mark - 选择规格属性(最新版)
- (void)choiceTypeBtnClick {
    if ([model_mall_status integerValue] == 0) {
        [MBProgressHUD showError:@"商品已售罄" toView:self.view];
        return;
    }
    
    if ([_overType isEqualToString:@"拼单购"]) {
        if ([group_buy_type_status isEqualToString:@"1"]) {
            //免费体验
            group_buy_isno = @"1";//拼单购 免费体验
        } else {
            group_buy_isno = @"2";//拼单购 开团
        }
    }
    
    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
    editView.scr_HHH.constant = ScreenH;
    editView.goods_id = collect_id;
    editView.product_id = product_id;
    editView.buy_goods_type = _overType;
    if (_is_active) {
         editView.is_active =_is_active;
    }
   
    if ([_overType isEqualToString:@"拼单购"]) {
        editView.group_buy_type_status = @"2";//默认为拼单类型
        if ([group_buy_type_status isEqualToString:@"1"]) {
            // 此商品为 体验商品时 隐藏库存 加减按钮等相关UI
            editView.group_buy_type_status = @"1";
            editView.cart_add_button.hidden = YES;
            editView.cart_minus_button.hidden = YES;
            editView.cart_buyNumber_label.hidden = YES;
            editView.cart_number_label.hidden = YES;
            editView.cart_repertoryNum_label.hidden = YES;
            editView.maxNum.hidden = YES;
        }
    }
    [editView showModel];
    [editView goodsInfor_now:@"GYM"];
    if ([_overType isEqualToString:@"拼单购"]) {
        editView.SShopCar_editView_showPrice = ^{
            if ([group_buy_isno isEqualToString:@"1"]) {
                editView.thisPrice.text = [NSString stringWithFormat:@"￥%@",shop_onePrice_buy];
            } else {
                editView.thisPrice.text = [NSString stringWithFormat:@"￥%@",shop_price_buy];
            }
        };
    }
    //返回
    editView.SShopCar_editView_back = ^{
        /*
         *恢复"overAgein"为nil,解决防止用户先点击立即购买,但没有选择商品规格,再通过商品详情页内的选择规格选项,选择商品规格后,出现的直接跳转到确认订单的问题
         */
        overAgein = nil;
        [editView removeFromSuperview];
    };
    //选好属性详情展示
    editView.SShopCar_editView_now = ^(NSString *shop_price, NSString *market_price, NSString *red_return_integral, NSString *wy_price, NSString *yx_price, NSString *goods_num, NSString * choiceContent, NSString * num, NSString * now_product_id, NSArray * model_dj_ticket, NSString * integral, NSString *model_group_buy_id, NSString *p_shop_price, NSString *model_p_integral, NSString * model_integral_buy_id, NSString * model_use_integral ,NSString * model_gift_goods_id, NSString * model_use_voucher) {
        [editView removeFromSuperview];
//        firt_isno = NO;
        
//        top.shop_price.text = shop_price;//旧代码
        
        /*
         *当数无界商店的时候,不显示店铺价格
         */
        if (![_overType isEqualToString:@"无界商店"]&&![_overType isEqualToString:@"赠品专区"]) {
            top.shop_price.text = shop_price;
        }
        /*
         *拼单购显示已团商品件数,不显示市场价格
         */
        if ([_overType isEqualToString:@"拼单购"]) {
//            top.market_price.text = [NSString stringWithFormat:@"已团%@件",alreadyGroupGoodCount];
            top.market_price.text = [NSString stringWithFormat:@"已参与%@人",alreadyGroupGoodCount];
            
            /*
             *设置拼单购商品,单独购买时对应的价格
             */
#warning 需要判断一下,已防止未登录状态登陆后,显示的独立购买积分显示不正确的问题
//            [_addCarBtn setTitle:[NSString stringWithFormat:@"￥%@\n独立购买",p_shop_price] forState:UIControlStateNormal];
            pIntegral = model_p_integral;
//            [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n独立购买",model_p_integral]] forState:UIControlStateNormal];
            /*
             *更改规格后,发起拼单按钮的价格也随之改变
             *根据是否体验拼单显示按钮的文字
             */
            if ([group_buy_type_status isEqualToString:@"1"]) {
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"￥%@\n体验拼单",top.shop_price.text] forState:UIControlStateNormal];
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n体验拼单",red_return_integral] forState:UIControlStateNormal];
                [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n手气￥%@元",top.integral.text,top.shop_price.text] forState:UIControlStateNormal];
                [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n独单买￥%@元",model_p_integral,p_shop_price]] forState:UIControlStateNormal];
            }else{
//                [_addBuyBtn setTitle:[NSString stringWithFormat:@"￥%@\n发起拼单",top.shop_price.text] forState:UIControlStateNormal];
                /*
                 *普通拼单时,用户点击发起拼单,并且规格选完后,设置selectOpenGroup为YES,再次点击发起拼单时,不再弹出提示框
                 */
                self.selectOpenGroup = YES;
                [_addBuyBtn setTitle:[NSString stringWithFormat:@"送%@积分\n发起拼单",red_return_integral] forState:UIControlStateNormal];
                [_addCarBtn setAttributedTitle:[self AttributeFontStringWithString:[NSString stringWithFormat:@"送%@积分\n独立购买",model_p_integral]] forState:UIControlStateNormal];
            }
        }else{
            top.market_price.text = [NSString stringWithFormat:@"￥%@",market_price];
        }
        top.integral.text = red_return_integral;
        top.wy_price.text = [NSString stringWithFormat:@"￥%@",wy_price];
        top.yx_price.text = [NSString stringWithFormat:@"￥%@",yx_price];
        //        top.sell_num.text = [NSString stringWithFormat:@"销量 %@",infor.data.goodsInfo.sell_num];
        top.goods_num.text = [NSString stringWithFormat:@"库存 %@",goods_num];
        top.use_integral.text = [NSString stringWithFormat:@"此商品可以使用%@积分兑换",integral];
        


        choice_shop_price = shop_price;
        choice_market_price = market_price;
        choice_red_return_integral = red_return_integral;
        choice_wy_price = wy_price;
        choice_yx_price = yx_price;
        choice_goods_num = goods_num;
        model_choiceContent = [NSString stringWithFormat:@"%@ x%@",[choiceContent stringByReplacingOccurrencesOfString:@"+" withString:@""],num];
        choice_num = num;
        choice_product_id = now_product_id;
        dj_ticket = model_dj_ticket;
        choice_integral = integral;
        choice_group_buy_id = model_group_buy_id;
        
        //无界商店
        /*
         *根据无界商店返回的数据,刷新无界商店商品详情显示的信息
         */
        choice_integral_buy_id = model_integral_buy_id;
        wuJie_use_integral = model_use_integral;
        if ([_overType isEqualToString:@"无界商店"]) {
            top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@积分",wuJie_use_integral];
            top.integral.text = [NSString stringWithFormat:@"库存 %@",goods_num];
//            [_addNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            /*
             *选择完商品规格后,跳转到确认订单
             */
            BuyForNow = @"立即购买";
        }
        if ([_overType isEqualToString:@"赠品专区"]) {
            top.shop_priceLeft.text = [NSString stringWithFormat:@"此物品兑换，需要%@赠品券",model_use_voucher];
            top.integral.text = [NSString stringWithFormat:@"库存 %@",goods_num];
            
            _gift_goods_id=model_gift_goods_id;
  
            BuyForNow = @"立即购买";
        }
        [_mCollect reloadData];
        
        //立即购买
        if ([overAgein isEqualToString:@"1"]) {
            /*
             *无界商店时,调用addNowBtn:方法
             */
            if ([_overType isEqualToString:@"无界商店"]||[_overType isEqualToString:@"赠品专区"]) {
                [self addNowBtn:_addNowBtn];
            }else{
                if (_order_id.length!=0) {
                    [self jishouBtnPress];
                }
                else
                {
                  [self addBuyBtnClick];
                }
                
            }
        }
        //加入购物车
        if ([overAgein isEqualToString:@"2"]) {
            [self addCarBtnClick];
        }
        
      
        //无界商店
        /*
         *暂时注销不是从直接购买选完商品属性直接跳转到确定订单页的代码
         */
//        if (overAgein == nil && [_overType isEqualToString:@"无界商店"]) {
//            [self addBuyBtnClick];
//        }
        
    };
}
#pragma mark - 立即购买
- (void)addBuyBtnClick {
    overAgein = @"1";//选完规格要跳转!立即购买
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
    if ([_overType isEqualToString:@"拼单购"]) {
        if ([group_buy_type_status isEqualToString:@"1"]) {
            //免费体验
            group_buy_isno = @"1";//拼单购 免费体验
            
            //判断当前体验拼单的商品,是否团已满
            if (diffNum.integerValue > 0) {//> ">0" 表示当前体验商品还没有满团
                //判断当前用户是否体验过免费拼单活动
                if (isAlreadyExperienceGroupBuy.integerValue > 0) {// "1" 体验过拼单,不允许再点击
                    _addBuyBtn.backgroundColor = WordColor_sub_sub;
//                    [MBProgressHUD showSuccess:@"您已参与" toView:self.view];
                    [self shouQiTanKuangAction];
                    return;
                }else{
                    _addBuyBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:0 blue:0 alpha:1];
                }
            }else{
                _addBuyBtn.backgroundColor = WordColor_sub_sub;
                [MBProgressHUD showSuccess:@"本商品拼单活动已完成" toView:self.view];
                return;
            }
        } else {
            group_buy_isno = @"2";//拼单购 开团
            /*
             *未选择过发起拼单,弹出提示框
             *判断是否可以参与拼单的信息,有则显示拼单方式的弹框
             */
            if (group_arr.count > 0) {
                if (!self.isSelectOpenGroup) {
                    [self ShowSelectJoinGroupOrOpenGroupAlert];
                    return;
                }
            }
        }
    }
    
    
    if (choice_shop_price == nil) {
        [self choiceTypeBtnClick];
        return;
    }
    
    SOrderConfirm * con = [[SOrderConfirm alloc] init];
    con.merchant_id = merchant_id;
    con.goods_id = collect_id;
    con.num = choice_num;
    con.product_id = choice_product_id;
    if ([_overType isEqualToString:@"拼单购"]) {
        con.special_type = @"拼单购";
        con.group_buy_id = choice_group_buy_id;
        if ([group_buy_isno isEqualToString:@"1"]) {
            con.special_type_sub = @"1";//1直接购买 2拼单(开团) 3拼单(参团)
        } else if ([group_buy_isno isEqualToString:@"2"]) {
            con.special_type_sub = @"2";//1直接购买 2拼单(开团) 3拼单(参团)
        } else if ([group_buy_isno isEqualToString:@"3"]) {
            con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
        }
        //此行代码导致拼单购选择产品规格有问题
//        con.group_buy_id = _goods_id;
    }
    if ([_overType isEqualToString:@"赠品专区"]) {
         con.special_type = @"赠品专区";
          //con.pre_id
        con.giftGoods_id=_gift_goods_id;
    
    }
    if ([_overType isEqualToString:@"无界预购"]) {
        con.special_type = @"无界预购";
        con.pre_id = _goods_id;
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        con.special_type = @"无界商店";
//        con.integralBuy_id = _goods_id;//旧代码
        /*
         *传递无界商店选中的商品的属性id
         */
        con.integralBuy_id = choice_integral_buy_id;
    }
    
    [self.navigationController pushViewController:con animated:YES];
    overAgein = nil;
    
//    [self choiceTypeClick:@"立即购买"];
}
//#pragma mark - 选择商品规格、类型(旧版)
//- (void)choiceTypeClick:(NSString *)isno {
//    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
//    editView.scr_HHH.constant = ScreenH;
//    editView.goods_id = collect_id;
//    editView.product_id = product_id;
//    [editView showModel];
//    [editView addBuy:isno];//类型：加入购物车、立即购买
////    [editView goodsInfor_now:@"GYM"];
//    if ([_overType isEqualToString:@"拼单购"]) {
//        editView.SShopCar_editView_showPrice = ^{
//            if ([group_buy_isno isEqualToString:@"1"]) {
//                editView.thisPrice.text = [NSString stringWithFormat:@"￥%@",shop_onePrice_buy];
//            } else {
//                editView.thisPrice.text = [NSString stringWithFormat:@"￥%@",shop_price_buy];
//            }
//        };
//
//    }
//    //返回
//    editView.SShopCar_editView_back = ^{
//        [editView removeFromSuperview];
////        [self showModel];
//    };
//    //购物车下单
//    editView.SShopCar_editView_submit = ^{
//        [editView removeFromSuperview];
////        [self showModel];
//    };
//    //立即购买
//    editView.SShopCar_editView_addBuy = ^(NSString *num, NSString *now_product_id) {
//        [editView removeFromSuperview];
//        SOrderConfirm * con = [[SOrderConfirm alloc] init];
//        con.merchant_id = merchant_id;
//        con.goods_id = collect_id;
//        con.num = num;
//        con.product_id = now_product_id;
//        if ([_overType isEqualToString:@"拼单购"]) {
//            con.special_type = @"拼单购";
//            if ([group_buy_isno isEqualToString:@"1"]) {
//                con.special_type_sub = @"1";//1直接购买 2拼单(开团) 3拼单(参团)
//            } else if ([group_buy_isno isEqualToString:@"2"]) {
//                con.special_type_sub = @"2";//1直接购买 2拼单(开团) 3拼单(参团)
//            } else if ([group_buy_isno isEqualToString:@"3"]) {
//                con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
//            }
//            con.group_buy_id = _goods_id;
//        }
//        if ([_overType isEqualToString:@"无界预购"]) {
//            con.special_type = @"无界预购";
//            con.pre_id = _goods_id;
//        }
//        if ([_overType isEqualToString:@"无界商店"]) {
//            con.special_type = @"无界商店";
//            con.integralBuy_id = _goods_id;
//        }
//        [self.navigationController pushViewController:con animated:YES];
//    };

//}

/*
 主人,您已参与此商品拼手气活动,不可重复参与哦!
 看看进度
 继续逛逛
 */

#pragma mark - 点击手气弹框
-(void)shouQiTanKuangAction{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:@"主人,您已参与此商品拼手气活动,不可重复参与哦!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"继续逛逛"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"看看进度"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self kankanJinDuAction];
                                                       }];
    [alertC addAction:sureAction];
    [alertC addAction:cancleAction];
    [self presentViewController:alertC animated:YES completion:^{}];
}

-(void)kankanJinDuAction{
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"2";
    list.coming = YES;
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark - 代金券 手气
- (void)dj_ticketBtnClick {
    if ([group_buy_type_status isEqualToString:@"1"]) {
        LuckHandList *list=[[LuckHandList alloc]init];
        list.a_id=_a_id;
        [self.navigationController pushViewController:list animated:YES];
        
    }else{
        SPromotion_OPEN * open = [[SPromotion_OPEN alloc] init];
        open.modalPresentationStyle = UIModalPresentationOverFullScreen;
        open.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:open animated:YES completion:nil];
        [open showModel:dj_ticket andType:_overType andClassType:@"代金券" andTypeContent:vouchers_desc];
        open.thisTitle.text = @"可使用代金券情况";
        open.SPromotion_OPEN_Back = ^{
            [open dismissViewControllerAnimated:YES completion:nil];
        };
    }
    
}
#pragma mark - 兑换(无界商店)
- (void)use_integralBtnClick {
    
    if ([integral_buy_id isEqualToString:@"0"]) {
        STicketFight * fight = [[STicketFight alloc] init];
        fight.hidesBottomBarWhenPushed = YES;
        fight.type = @"3";
        [self.navigationController pushViewController:fight animated:YES];
    }else{
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = integral_buy_id;
        info.overType = @"无界商店";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
}
#pragma mark - 促销
- (void)promotionBtnClick {
    
    SPromotion_OPEN * open = [[SPromotion_OPEN alloc] init];
    open.modalPresentationStyle = UIModalPresentationOverFullScreen;
    open.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:open animated:YES completion:nil];
    [open showModel:promotion andType:_overType andClassType:@"促销" andTypeContent:@""];
    open.thisTitle.text = @"促销详情";
    open.SPromotion_OPEN_Back = ^{
        [open dismissViewControllerAnimated:YES completion:nil];
    };
}
#pragma mark - 领券
- (void)couponsBtnClick {
    SCoupons_OPEN * open = [[SCoupons_OPEN alloc] init];
    open.modalPresentationStyle = UIModalPresentationOverFullScreen;
    open.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:open animated:YES completion:nil];
    [open showModel:ticketList andType:_overType];
    open.SCoupons_OPEN_Back = ^{
        [open dismissViewControllerAnimated:YES completion:nil];
        [self showModel];
    };
}

/*
 *弹出的更多拼单弹框
 */
#pragma mark - 更多的参团信息
-(void)ShowMoreGroup:(UIButton *)btn{
    ShowMoreGroupView * moreGroupView = [ShowMoreGroupView CreatShowMoreGroupView];
    moreGroupView.frame = self.view.bounds;
    moreGroupView.groupArr = group_arr;
    __weak typeof(self) WeakSelf = self;
    moreGroupView.jumpFightGroupBlock = ^(SGroupBuyGroupBuyInfo * list) {
        [WeakSelf JumpFightGroupDetailWith:list];
    };
    self.moreGroupView = moreGroupView;
    [self.view addSubview:moreGroupView];
}

#pragma mark - 领券1
- (void)one_ticketListBtnClick:(UIButton *)btn {
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
    SGoodsGetTicket * get = [[SGoodsGetTicket alloc] init];
    if (_overType == nil) {
        SGoodsGoodsInfo * infor = ticketList.firstObject;
        get.ticket_id = infor.ticket_id;
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = ticketList.firstObject;
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = ticketList.firstObject;
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = ticketList.firstObject;
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = ticketList.firstObject;
        get.ticket_id = infor.ticket_id;
        
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [get sGoodsGetTicketSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            [self showModel];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 领券2
- (void)two_ticketListBtnClick:(UIButton *)btn {
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
    SGoodsGetTicket * get = [[SGoodsGetTicket alloc] init];
    if (_overType == nil) {
        SGoodsGoodsInfo * infor = ticketList[1];
        get.ticket_id = infor.ticket_id;
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = ticketList[1];
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = ticketList[1];
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = ticketList[1];
        get.ticket_id = infor.ticket_id;
        
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = ticketList[1];
        get.ticket_id = infor.ticket_id;
        
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [get sGoodsGetTicketSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            [self showModel];

        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 配送地区
- (void)sendBtnClick {
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, NAVIGATION_BAR_HEIGHT)];
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
    //如果当前商品没有三级分类,不跳转
    SGoodsCategoryCateIndex * index = [[SGoodsCategoryCateIndex alloc] init];
    index.cate_id = cate_id;
    [index sGoodsCategoryCateIndexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SGoodsCategoryCateIndex * list = (SGoodsCategoryCateIndex *)data;
        for (int i = 0; i < list.data.two_cate.count; i++) {
            SGoodsCategoryCateIndex * index = list.data.two_cate[i];
            if ([index.cate_id isEqualToString:pcate_id]) {
                
                //旧版跳转界面
//                SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
//                class_sub.cate_type = @"7";
//                class_sub.two_cate_id = cate_id;
//                class_sub.short_name = two_cate_name;
//                class_sub.class_num = i + 1;
//                [self.navigationController pushViewController:class_sub animated:YES];
//                return ;
                
                /*
                 *新版挑战界面
                 *修改商品详情页中的查看分类的跳转界面的显示,改为和线上商城首页顶部分类相同的页面
                 */
                SOnlineShop_ClassInfoList_more * more = [[SOnlineShop_ClassInfoList_more alloc] init];
                more.Top_Cate_ID = top_cate_id;
                more.Cate_ID = cate_id;
                more.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:more animated:YES];
                
            }
        }
    } andFailure:^(NSError *error) {
    }];
    
    

    
}
#pragma mark - 进店逛逛
- (void)shopAroundClick {
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = merchant_id;
    [self.navigationController pushViewController:infor animated:YES];
}
#pragma mark - 搭配购
- (void)groupGoodsBtnClick {
    SPurchase * pur = [[SPurchase alloc] init];
    pur.goods_id = collect_id;
    [self.navigationController pushViewController:pur animated:YES];
}
- (IBAction)downHomeBtn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)downCarBtn:(UIButton *)sender {
    SShopCar * car = [[SShopCar alloc] init];
    car.type = YES;
    car.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:car animated:YES];
}
- (IBAction)downMessBtn:(UIButton *)sender {
    
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
    /*
     *店铺的联系方式
     */
    list.merchant_phone = merchant_phone;
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

#pragma mark - 获取webView中的所有图片URL
- (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [webString substringWithRange:range];
        
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
       if (match.count>0) {
            
       
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
     
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        //将提取出的图片URL添加到图片数组中
        if (imagekUrl.length>0) {
             [imageurlArray addObject:imagekUrl];
        }
        //   NSLog(@"----------------");
        }
        else
        {
         //  NSLog(@"%@",match);
        }
    }

    return imageurlArray;
}
#pragma mark - 轮播图图片展示
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    NSMutableArray * photos = [NSMutableArray arrayWithCapacity:banner_imgaeArr.count];
    for (int i = 0; i < banner_imgaeArr.count; i++) {
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
        photo.photoURL = [NSURL URLWithString:banner_imgaeArr[i]];
        [photos addObject:photo];
    }
    
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    pickerBrowser.photos = photos.mutableCopy;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = index;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

#pragma mark - 拼单独立购买按钮不同字体
-(NSAttributedString *)AttributeFontStringWithString:(NSString *)string{
    NSRange range = [string rangeOfString:@"\n"];
    NSMutableAttributedString * attritubedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attritubedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, range.location)];
    
    /*
     *当金额过长的时候,设置"\n"后半句字体的显示
     */
    NSString * subStr = [string substringFromIndex:range.location + 1];
    CGRect textRect = [subStr boundingRectWithSize:CGSizeMake(_addBuyBtn.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    if (textRect.size.width >= _addBuyBtn.bounds.size.width) {
        [attritubedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(range.location + 1, subStr.length)];
    }
    return attritubedStr;
}


#pragma mark - 跳转到拼单详情
-(void)JumpFightGroupDetailWith:(SGroupBuyGroupBuyInfo *)list{
    
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
    
    
    SFightGroups * join = [[SFightGroups alloc] init];
    join.group_buy_order_id = list.id;
    join.goods_id = collect_id;
    join.group_buy_id = _goods_id;
    join.product_id = product_id;
    join.merchant_id = merchant_id;
    join.shop_price_buy = shop_price_buy;
    join.good_img_buy = good_img_buy;
    join.goods_attr_arr = goods_attr_arr;
    join.contrastArr = contrastArr;
    join.GivenIntegral = self.GroupIntegral;
    join.group_buy_type_status = group_buy_type_status;
    join.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:join animated:YES];
}


#pragma mark - 倒计时
//更新cell中的倒计时的时间显示
-(void)updateTimeInVisibleCells{
    
    
    NSMutableArray  *cells = [self.mCollect.visibleCells mutableCopy]; //取出屏幕可见cell
    
    /*
     *倒计时弹出框内的拼单
     */
    if (self.moreGroupView != nil) {
        [cells addObjectsFromArray:self.moreGroupView.MoreGroupCollection.visibleCells];
    }
    
    //获取当前控制器显示的拼团的cell
    NSMutableArray * countDownCellArr = [NSMutableArray array];
    for (UICollectionViewCell *cell in cells) {
        if ([cell isKindOfClass:[QGoodsInfor_first_groupCell class]]) {
            [countDownCellArr addObject:cell];
        }
    }
    for (QGoodsInfor_first_groupCell * cell in countDownCellArr) {
        NSIndexPath * indexPath = nil;
        /*
         *根据不同的cell的reuseIdentifier计算cell再collection中的indexPath
         */
        if ([cell.reuseIdentifier isEqualToString:@"QGoodsInfor_first_groupCell"]) {
            indexPath = [self.mCollect indexPathForCell:cell];
        }else if ([cell.reuseIdentifier isEqualToString:@"GroupCellID"]){
            indexPath = [self.moreGroupView.MoreGroupCollection indexPathForCell:cell];
        }
        
        cell.isBeginDelay = [[self.timerArr[indexPath.row] objectForKey:@"isDelay"] boolValue];//获取当前是否是延迟状态
        
        if (!cell.isEnd) {
            NSDictionary * dict = [self getNowTimeWithString:self.timerArr[indexPath.row]];
            cell.countDownStr = [dict objectForKey:@"showTime"];
            cell.isEnd = [[dict objectForKey:@"isEnd"] boolValue];
        }
        
    }
}
//获取当前倒计时剩余的时间
-(NSDictionary *)getNowTimeWithString:(NSMutableDictionary *)timeDict{
    NSString * aTimeString = nil;
    if ([[timeDict objectForKey:@"isDelay"] isEqualToString:@"0"]) {//没有延迟过
        aTimeString = [timeDict objectForKey:@"endTime"];
    }else{//已经延迟过
        aTimeString = [timeDict objectForKey:@"delayTime"];
    }
    
    NSTimeInterval timeInterval = (aTimeString.longLongValue*1000 - self.countDownStartTimeStr);
    NSTimeInterval newTimeInterval = timeInterval/1000;
    
    long days = (long)(newTimeInterval/(3600*24));
    long hours = (long)((newTimeInterval-days*24*3600)/3600);
    long minutes = (long)(newTimeInterval-(days*24*3600+hours*3600))/60;
    long seconds = (long)(newTimeInterval-(days*24*3600+hours*3600+minutes*60));
    long msecs =(long)(timeInterval-(days*24*3600+hours*3600+minutes*60+seconds)*1000)/10;
    
    if (days) {
        /*
         *修复拼单团的倒计时,只显示整天的信息
         */
        hours += days*24;//将天数转换成小时数
    }
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;NSString *MsecStr;
    //天
    dayStr = [NSString stringWithFormat:@"%ld",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%02ld",hours];
    //分钟
    minutesStr = [NSString stringWithFormat:@"%02ld",minutes];
    //秒
    secondsStr = [NSString stringWithFormat:@"%02ld",seconds];
    //毫秒
    MsecStr = [NSString stringWithFormat:@"%ld",msecs];
    
    
    if (hours<=0&&minutes<=0&&seconds<=0) {
        //不是延迟阶段,更改isDelay的状态
        if ([[timeDict objectForKey:@"isDelay"] isEqualToString:@"0"]) {//没有延迟过
            //显示要延迟的时间
            [timeDict setObject:@"1" forKey:@"isDelay"];
        }else{
            //已经延迟的话,直接显示00:00:00:00
            NSMutableDictionary * endDict = [NSMutableDictionary dictionary];
            [endDict setObject:@1 forKey:@"isEnd"];
            [endDict setObject:@"00:00:00:00" forKey:@"showTime"];
            return endDict;
        }
    }
    
    NSMutableDictionary * endDict = [NSMutableDictionary dictionary];
    [endDict setObject:@0 forKey:@"isEnd"];
    [endDict setObject:[NSString stringWithFormat:@"%@:%@:%@:%@",hoursStr , minutesStr,secondsStr,MsecStr] forKey:@"showTime"];
    return endDict;
}
//创建倒计时的定时器
- (void)CreatCountDown{

    if (!self.countDown) {
        self.countDown = [[CountDown alloc] init];
        __weak __typeof(self) weakSelf= self;
        ///每0.01秒回调一次
        [self.countDown countDownWithPER_SECBlock:^{
            [weakSelf updateTimeInVisibleCells];
            weakSelf.countDownStartTimeStr+=10;//因为是毫秒,所以每秒自加10
        }];
    }
}
//获取拼团活动的倒计时结束的时间
-(NSMutableArray *)GetActivityEndTime{
    NSMutableArray * mutableArr = [NSMutableArray array];
    for (SGroupBuyGroupBuyInfo * model in group_arr) {
        self.countDownStartTimeStr = model.sys_time.longLongValue*1000;
        NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
        if (model.sys_time.longLongValue < model.end_time.longLongValue) {
            [mutableDict setObject:@"0" forKey:@"isDelay"];
        }else{
            [mutableDict setObject:@"1" forKey:@"isDelay"];
        }
        [mutableDict setObject:model.end_time forKey:@"endTime"];
        [mutableDict setObject:model.end_true_time forKey:@"delayTime"];
        [mutableArr addObject:mutableDict];
    }
    return mutableArr;
}
-(void)stopTimer{
    [self.countDown destoryTimer];
    self.countDown = nil;
}

/*
 *普通拼单,发起拼单提示框
 */
#pragma mark - 普通拼单购,发起拼单提示框
-(void)ShowSelectJoinGroupOrOpenGroupAlert{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"参与拼单  Or  发起拼单 ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * JoinAction = [UIAlertAction actionWithTitle:@"参与拼单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self ShowMoreGroup:nil];
    }];
    UIAlertAction * openGroupAction = [UIAlertAction actionWithTitle:@"发起拼单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choiceTypeBtnClick];
    }];
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
    [alertVC addAction:JoinAction];
    [alertVC addAction:openGroupAction];
//    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma  除去空值+++++++
-(NSMutableArray *)notNullData:(NSArray *)arr
{
    NSMutableArray *arrdata=[NSMutableArray array];
    if (_overType == nil) {
       
        for (  SGoodsGoodsInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
            
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SGoodsGoodsInfo *infor_sub = (SGoodsGoodsInfo*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                    
                }
                
            }];
            NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
            [arrdata addObject:dic];
        }
    }
    if ([_overType isEqualToString:@"限量购"]) {
        
        for (  SLimitBuyLimitBuyInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
            
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SLimitBuyLimitBuyInfo *infor_sub = (SLimitBuyLimitBuyInfo*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                    
                }
                
            }];
            NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
            [arrdata addObject:dic];
        }
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        for (  SGroupBuyGroupBuyInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
          
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SGroupBuyGroupBuyInfo *infor_sub = (SGroupBuyGroupBuyInfo*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                    
                }
               
            }];
              NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
              [arrdata addObject:dic];
        }
        
    }
    if ([_overType isEqualToString:@"无界预购"]) {
     
        for (  SPreBuyPreBuyInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SPreBuyPreBuyInfo *infor_sub = (SPreBuyPreBuyInfo*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                }
            }];
            NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
            [arrdata addObject:dic];
        }
    }
    if ([_overType isEqualToString:@"无界商店"]) {
        for (  SIntegralBuyIntegralBuyInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
            
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SIntegralBuyIntegralBuyInfo *infor_sub = (SIntegralBuyIntegralBuyInfo*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                    
                }
                
            }];
            NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
            [arrdata addObject:dic];
        }
    }
    if ([_overType isEqualToString:@"赠品专区"]) {
        for (  SIntegralBuyIntegralBuyInfo * infor in arr) {
            NSMutableArray *arr1=[NSMutableArray arrayWithArray:infor.list];
            
            [arr1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SgiftDetailModel *infor_sub = (SgiftDetailModel*)obj;
                if (infor_sub.attr_value.length==0) {
                    [arr1 removeObject:infor_sub];
                    
                }
                
            }];
            NSDictionary *dic=@{@"tittle":infor.title,@"list":arr1};
            [arrdata addObject:dic];
        }
    }
    
    
    return arrdata;
}
#pragma mark  寄售
-(void)jishouBtnPress
{
    overAgein = @"1";//选完规格要跳转!立即购买
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
    if (choice_shop_price == nil) {
        [self choiceTypeBtnClick];
        return;
    }

    CleanSOrderConfirm * con = [[CleanSOrderConfirm alloc] init];
    con.goods_id = _goods_id;
    con.num = choice_num;
    con.product_id = _product_id;
    con.order_id=_order_id;
   [self.navigationController pushViewController:con animated:YES];
    overAgein = nil;
}
@end
