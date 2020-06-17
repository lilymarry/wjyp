//
//  SuperiorAcme_Url.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#ifndef SuperiorAcme_Url_h
#define SuperiorAcme_Url_h


//#define Url_header @"test"
//#define Url_header @"test3"
//#define Url_header @"dev"
//#define Url_header @"test2"
#define Url_header @"api"

#define SgiftBase_url [NSString stringWithFormat:@"http://%@.wujiemall.com/Api/", Url_header]

#define Base_url [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Api/", Url_header]
//拜师码的BaseUrl
#define BaiShi_Base_url [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Api/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header]
//商家码的BaseUrl
#define Merchant_Base_url(stage_merchant_id) [NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/confirmation/stage_merchant_id/%@%@.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header, stage_merchant_id, [SRegisterLogin shareAppendInviteCode]]
//帮助中心url
#define HelpCenter_url [NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/Article/helpCenter/type/0.html?Accept_type=ios", [Url_header isEqualToString:@"api"] ? @"www" : Url_header]

//登录用户的邀请码
#define INVITE_CODE @"INVITE_CODE"

#define AUTH_CODE @"auth_code"

//分享baseurl 上架 test 改为  www
#define SharedWapUrl [NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header]

//wap商品详情url
#define SharedWapGoodsInfoUrl(goods_id) [NSString stringWithFormat:@"%@Goods/goodsInfo/goods_id/%@%@.html", SharedWapUrl, goods_id, [SRegisterLogin shareAppendInviteCode]]
//wap店铺url
#define SharedWapStoreUrl(merchant_id) [NSString stringWithFormat:@"%@Merchant/merIndex/merchant_id/%@%@.html", SharedWapUrl, merchant_id, [SRegisterLogin shareAppendInviteCode]]
//wap店铺详情url
#define SharedWapStoreInfoUrl(merchant_id) [NSString stringWithFormat:@"%@Merchant/merInfo/merchant_id/%@%@.html", SharedWapUrl, merchant_id, [SRegisterLogin shareAppendInviteCode]]


//是否为X
//#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define KIsiPhoneX \
({BOOL KIsiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
KIsiPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(KIsiPhoneX);})
// 状态栏高度
#define STATUS_BAR_HEIGHT (KIsiPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (KIsiPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (KIsiPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (KIsiPhoneX ? 34.f : 0.f)

//获取经纬度
#define GET_LNG [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"]//获取经度
#define GET_LAT [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"]//获取纬度

//分享
#pragma mark - 参团分享
#define ShareGroupBuyOrder @"GroupBuyOrder/mkShareUrl"

#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

#pragma mark - 导航色
#define navigationColor [UIColor colorWithRed:245/255.0 green:70/255.0 blue:151/255.0 alpha:1]
//登录注册模块
//#pragma mark - 发送短信验证码
//#define SRegisterSendVerify_Url @"Register/sendVerify"
//#pragma mark - 注册第一步
//#define SRegisterRegisterOne_Url @"Register/registerOne"
//#pragma mark - 验证短信验证码
//#define SRegisterCheckVerify_Url @"Register/checkVerify"
//#pragma mark - 用户注册
//#define SRegisterRegister_Url @"Register/register"
//#pragma mark - 用户登录
//#define SRegisterLogin_Url @"Register/login"
//#pragma mark - 忘记密码
//#define SRegisterResetPassword_Url @"Register/resetPassword"
//#pragma mark - 三方登录
//#define SRegisterOtherLogin_Url @"Register/otherLogin"
//#pragma mark - 三方登录绑定手机
//#define SRegisterOtherLoginBind_Url @"Register/otherLoginBind"

//文章模块
//#pragma mark - APP文章
//#define SArticleGetArticle_Url @"Article/getArticle"
//#pragma mark - 关于我们
//#define SArticleAboutUs_Url @"Article/aboutUs"
//#pragma mark - 意见反馈问题类型
//#define SArticleFeedbackType_Url @"Article/feedbackType"
//#pragma mark - 意见反馈
//#define SArticleFeedback_Url @"Article/feedback"
//#pragma mark - 帮助中心
//#define SArticleHelpCenter_Url @"Article/helpCenter"

//无界书院
//#pragma mark - 无界书院首页
//#define SAcademyAcademyIndex_Url @"Academy/academyIndex"
//#pragma mark - 文章详情
//#define SAcademyAcademyInfo_Url @"Academy/academyInfo"

//收货地址
//#pragma mark - 收货地址列表
//#define SAddressAddressList_Url @"Address/addressList"
//#pragma mark - 设置默认收货地址
//#define SAddressSetDefault_Url @"Address/setDefault"
//#pragma mark - 获取一条收货地址
//#define SAddressGetOneAddress_Url @"Address/getOneAddress"
//#pragma mark - 添加收货地址
//#define SAddressAddAddress_Url @"Address/addAddress"
//#pragma mark - 编辑收货地址
//#define SAddressEditAddress_Url @"Address/editAddress"
//#pragma mark - 删除收货地址
//#define SAddressDelAddress_Url @"Address/delAddress"
//#pragma mark - 获取区域列表
//#define SAddressGetRegion_Url @"Address/getRegion"
//#pragma mark - 获取街道列表
//#define SAddressGetStreet_Url @"Address/getStreet"

//会员模块
//#pragma mark - 获取个人资料
//#define SUserUserInfo_Url @"User/userInfo"
//#pragma mark - 修改个人资料
//#define SUserEditInfo_Url @"User/editInfo"
//#pragma mark - 实名认证
//#define SUserAddAuth_Url @"User/addAuth"
//#pragma mark - 修改登录密码
//#define SUserChangePassword_Url @"User/changePassword"
//#pragma mark - 个人设置
//#define SUserSetting_Url @"User/setting"
//#pragma mark - 获取实名认证信息
//#define SUserGetAuth_Url @"User/getAuth"
//#pragma mark - 修改支付密码
//#define SUserRePayPwd_Url @"User/rePayPwd"
//#pragma mark - 更换绑定手机
//#define SUserChangePhone_Url @"User/changePhone"
//#pragma mark - 我的评价
//#define SUserMyCommentList_Url @"User/myCommentList"
//#pragma mark - 我的足迹
//#define SUserMyfooter_Url @"User/myfooter"
//#pragma mark - 我的购物券
//#define SUserVouchersList_Url @"User/vouchersList"
//#pragma mark - 购物券明细
//#define SUserVouchersLog_Url @"User/vouchersLog"
//#pragma mark - 我的积分
//#define SUserMyIntegral_Url @"User/myIntegral"
//#pragma mark - 设置登录密码
//#define SUserSetPassword_Url @"User/setPassword"
//#pragma mark - 设置支付密码
//#define SUserSetPayPwd_Url @"User/setPayPwd"
//#pragma mark - 个人中心
//#define SUserUserCenter_Url @"User/userCenter"
//#pragma mark - 卡券包-优惠券
//#define SUserMyTicket_Url @"User/myTicket"

//#pragma mark - 获取经营范围
//#define SUserGetRange_Url @"User/getRange"
//#pragma mark - 会员推荐商户
//#define SUserMerchantRefer_Url @"User/merchantRefer"
//#pragma mark - 获取推荐商家列表
//#define SUserReferList_Url @"User/referList"
//#pragma mark - 会员成长
//#define SUserUserDevelop_Url @"User/userDevelop"
//#pragma mark - 成长值明细
//#define SUserUserDevelopLog_Url @"User/userDevelopLog"
//#pragma mark - 增加成长值
//#define SUserAddPoint_Url @"User/addPoint"
//#pragma mark - 会员等级
//#define SUserUserRank_Url @"User/userRank"
//#pragma mark - 注册码
//#define SUserGetSignCode_Url @"User/getSignCode"
//#pragma mark - 工作成绩
//#define SUserGradeRank_Url @"User/gradeRank"
//#pragma mark - 我的分享
//#define SUserMyShare_Url @"User/myShare"
//#pragma mark - 我的推荐
//#define SUserMyRecommend_Url @"User/myRecommend"
//#pragma mark - 我的推荐(新)
//#define SUserMyRecommendNew_Url @"User/myRecommendNew"
//#pragma mark - 分享回调
//#define SUserShareBack_Url @"User/shareBack"
//#pragma mark - 忘记支付密码
//#define SUserResetPayPwd_Url @"User/resetPayPwd"
//#pragma mark - 积分明细
//#define SUserIntegralLog_Url @"User/integralLog"
//#pragma mark - 分享好友
//#define SUserShareFriend_Url @"User/shareFriend"
//#pragma mark - 删除足迹
//#define SUserDelFooter_Url @"User/delFooter"
//#pragma mark - 推荐商家详情
//#define SUserReferInfo_Url @"User/referInfo"
//#pragma mark - 绑定第三方
//#define SUserBindOther_Url @"User/bindOther"
//#pragma mark - 解除绑定
//#define SUserRemoveBind_Url @"User/removeBind"
//#pragma mark - 个人认证
//#define SUserPersonalAuth_Url @"User/personalAuth"
//#pragma mark - 个人认证详情
//#define SUserPersonalAuthInfo_Url @"User/personalAuthInfo"
//#pragma mark - 企业认证
//#define SUserCompAuth_Url @"User/compAuth"
//#pragma mark - 会员卡列表
//#define SUserUserCard_Url @"User/userCard"
//
//#pragma mark - 验证支付密码
//#define SUserVerificationPayPwd_Url @"User/verificationPayPwd"
//#pragma mark - 积分兑换
//#define SUserChangeIntegral_Url @"User/changeIntegral"
//#pragma mark - 积分自动兑换
//#define SUserChangeIntegralStatus_Url @"User/changeIntegralStatus"
//#pragma mark - 获取兑换详情信息
//#define SUserAutoChange_Url @"User/autoChange"
//#pragma mark - 申请无界推广员
//#define SUserCreateSeniorMember_Url @"User/promoters"

//会员收藏
//#pragma mark - 用户收藏
//#define SUserCollectCollectList_Url @"UserCollect/collectList"
//#pragma mark - 加入我的收藏
//#define SUserCollectAddCollect_Url @"UserCollect/addCollect"
//#pragma mark - 删除收藏品
//#define SUserCollectDelCollect_Url @"UserCollect/delCollect"
//#pragma mark - 取消收藏
//#define SUserCollectDelOneCollect_Url @"UserCollect/delOneCollect"

//商品模块
//#pragma mark - 商品列表页
//#define SGoodsGoodsList_Url @"Goods/goodsList"
//#pragma mark - 商品详情
//#define SGoodsGoodsInfo_Url @"Goods/goodsInfo"
//#pragma mark - 三级分类商品列表
//#define SGoodsThreeList_Url @"Goods/threeList"
//#pragma mark - 搜索
//#define SGoodsSearch_Url @"Goods/search"
//#pragma mark - 领取优惠券
//#define SGoodsGetTicket_Url @"Goods/getTicket"
//#pragma mark - 搭配购列表
//#define SGoodsGroupGoodsList_Url @"Goods/groupGoodsList"

//积分抽奖模块
//#pragma mark - 积分抽奖首页
//#define SOneBuyOneBuyIndex_Url @"OneBuy/oneBuyIndex"
//#pragma mark - 积分抽奖详情页
//#define SOneBuyOneBuyInfo_Url @"OneBuy/oneBuyInfo"

//拼团购模块
//#pragma mark - 拼团购首页
//#define SGroupBuyGroupBuyIndex_Url @"GroupBuy/groupBuyIndex"
//#pragma mark - 拼团购详情页
//#define SGroupBuyGroupBuyInfo_Url @"GroupBuy/groupBuyInfo"
//#pragma mark - 参团页
//#define SGroupBuyGoGroup_Url @"GroupBuy/goGroup"
//#pragma mark - 三级分类商品列表
//#define SGroupBuyThreeList_Url @"GroupBuy/threeList"

//竞拍汇模块
//#pragma mark - 竞拍汇首页
//#define SAuctionAuctionIndex_Url @"Auction/auctionIndex"
//#pragma mark - 竞拍汇详情页
//#define SAuctionAuctionInfo_Url @"Auction/auctionInfo"
//#pragma mark - 设置提醒
//#define SAuctionRemindMe_Url @"Auction/remindMe"

//无界预购
//#pragma mark - 无界预购首页
//#define SPreBuyPreBuyIndex_Url @"PreBuy/preBuyIndex"
//#pragma mark - 三级分类商品列表
//#define SPreBuyThreeList_Url @"PreBuy/threeList"
//#pragma mark - 无界预购详情
//#define SPreBuyPreBuyInfo_Url @"PreBuy/preBuyInfo"

//限量购
//#pragma mark - 限量购首页
//#define SLimitBuyLimitBuyIndex_Url @"LimitBuy/limitBuyIndex"
//#pragma mark - 限量购详情
//#define SLimitBuyLimitBuyInfo_Url @"LimitBuy/limitBuyInfo"
//#pragma mark - 设置提醒限量购
//#define SLimitBuyRemindMe_Url @"LimitBuy/remindMe"

//票券区
//#pragma mark - 票券区首页
//#define STicketBuyTicketBuyIndex_Url @"TicketBuy/ticketBuyIndex"
//#pragma mark - 票券区商品详情
//#define STicketBuyTicketBuyInfo_Url @"TicketBuy/ticketBuyInfo"
//#pragma mark - 三级分类商品
//#define STicketBuyThreeList_Url @"TicketBuy/threeList"

//主题街
//#pragma mark - 主题街展示页
//#define SThemeThemeList_Url @"Theme/themeList"
//#pragma mark - 主题商品页
//#define SThemeThemeGoods_Url @"Theme/themeGoods"
//#pragma mark - 商品详情页
//#define SThemeGoodsInfo_Url @"Theme/goodsInfo"

//无界商店
//#pragma mark - 无界商店首页
//#define SIntegralBuyIntegralBuyIndex_Url @"IntegralBuy/integralBuyIndex"
//#pragma mark - 无界商店详情
//#define SIntegralBuyIntegralBuyInfo_Url @"IntegralBuy/integralBuyInfo"
//#pragma mark - 三级分类商品
//#define SIntegralBuyThreeList_Url @"IntegralBuy/threeList"

//商家模块
//#pragma mark - 店铺首页
//#define SMerchantMerIndex_Url @"Merchant/merIndex"
//#pragma mark - 店铺详情
//#define SMerchantMerInfo_Url @"Merchant/merInfo"
//#pragma mark - 商品页
//#define SMerchantGoodsList_Url @"Merchant/goodsList"
//#pragma mark - 获取评论列表
//#define SMerchantCommentList_Url @"Merchant/commentList"
//#pragma mark - 活动商品-拼团购
//#define SMerchantGroupList_Url @"Merchant/groupList"
/*
 *店铺活动商品拼单购新接口
 */
//#define SGroupBuyMerchantGroupBuyList_Url @"GroupBuy/merchantGroupBuyList"
//#pragma mark - 活动商品-无界预购
//#define SMerchantPreList_Url @"Merchant/preList"
//#pragma mark - 活动商品-一元购
//#define SMerchantOneBuyList_Url @"Merchant/oneBuyList"
//#pragma mark - 活动商品-竞拍汇
//#define SMerchantAuctionList_Url @"Merchant/auctionList"
//#pragma mark - 商家资质
//#define SMerchantLicense_Url @"Merchant/license"
//#pragma mark - 举报商家
//#define SMerchantReport_Url @"Merchant/report"
//#pragma mark - 活动商品-限量购
//#define SMerchantLimitList_Url @"Merchant/limitList"
//#pragma mark - 举报类型
//#define SMerchantReportType_Url @"Merchant/reportType"

//进口馆
//#pragma mark - 进口馆首页
//#define SCountryCountryIndex_Url @"Country/countryIndex"
//#pragma mark - 选定国家商品列表
//#define SCountryCountryGoods_Url @"Country/countryGoods"
//#pragma mark - 商品详情
//#define SCountryGoodsInfo_Url @"Country/goodsInfo"
//#pragma mark - 三级分类商品
//#define SCountryThreeList_Url @"Country/threeList"

//福利社
//#pragma mark - 优惠券
//#define SWelfareTicketList_Url @"Welfare/ticketList"
//#pragma mark - 领取优惠券
//#define SWelfareGetTicket_Url @"Welfare/getTicket"
//#pragma mark - 红包列表
//#define SWelfareFaceList_Url @"Welfare/faceList"
//#pragma mark - 红包广告
//#define SWelfareBonusList_Url @"Welfare/bonusList"
//#pragma mark - 领取红包
//#define SWelfareGetBonus_Url @"Welfare/getBonus"
//#pragma mark - 红包分享内容
//#define SWelfareShareContent_Url @"Welfare/shareContent"

//汽车购
//#pragma mark - 汽车筛选页
//#define SCarBuyCarSelect_Url @"CarBuy/carSelect"
//#pragma mark - 汽车列表页
//#define SCarBuyCarList_Url @"CarBuy/carList"
//#pragma mark - 汽车详情
//#define SCarBuyCarInfo_Url @"CarBuy/carInfo"
//#pragma mark - 评价列表
//#define SCarBuyCommentList_Url @"CarBuy/commentList"

//商品分类模块
//#pragma mark - 分类页面
//#define SGoodsCategoryCateIndex_Url @"GoodsCategory/cateIndex"

//房产购
//#pragma mark - 楼盘列表
//#define SHouseBuyHouseList_Url @"HouseBuy/houseList"
//#pragma mark - 楼盘详情
//#define SHouseBuyHouseInfo_Url @"HouseBuy/houseInfo"
//#pragma mark - 户型列表
//#define SHouseBuyHouseStyleList_Url @"HouseBuy/houseStyleList"
//#pragma mark - 户型详情
//#define SHouseBuyStyleInfo_Url @"HouseBuy/styleInfo"
//#pragma mark - 评价列表
//#define SHouseBuyCommentList_Url @"HouseBuy/commentList"

//产业孵化
//#pragma mark - 企业列表页
//#define SCompanyDevelopCompanyList_Url @"CompanyDevelop/companyList"
//#pragma mark - 企业简介
//#define SCompanyDevelopCompanyInfo_Url @"CompanyDevelop/companyInfo"

//首页
//#pragma mark - App首页
//#define SIndexIndex_Url @"Index/index"
//#pragma mark - 获取头条列表
//#define SIndexHeadLineList_Url @"Index/headLineList"
//#pragma mark - 头条详情
//#define SIndexHeadInfo_Url @"Index/headInfo"

//会员余额
//#pragma mark - 余额首页
//#define SUserBalanceBalanceIndex_Url @"UserBalance/balanceIndex"
//#pragma mark - 线上充值
//#define SUserBalanceUpMoney_Url @"UserBalance/upMoney"
//#pragma mark - 线下充值
//#define SUserBalanceUnderMoney_Url @"UserBalance/underMoney"
//#pragma mark - 银行卡类型获取
//#define SUserBalanceGetBankType_Url @"UserBalance/getBankType"
//#pragma mark - 添加银行卡
//#define SUserBalanceAddBank_Url @"UserBalance/addBank"
//#pragma mark - 获取银行卡列表
//#define SUserBalanceBankList_Url @"UserBalance/bankList"
//#pragma mark - 删除银行卡
//#define SUserBalanceDelBank_Url @"UserBalance/delBank"
//#pragma mark - 提现首页
//#define SUserBalanceCashIndex_Url @"UserBalance/cashIndex"
//#pragma mark - 提现操作
//#define SUserBalanceGetCash_Url @"UserBalance/getCash"
//#pragma mark - 转账
//#define SUserBalanceChangeMoney_Url @"UserBalance/changeMoney"
//
//#pragma mark - 赠送蓝色代金券
//#define SUserBalanceChangeBlueCoupon_Url @"User/gifVoucher"
//#pragma mark - 赠送蓝色代金券赠送
//#define SUserBalanceBlueCouponLog_Url @"User/gifVoucherList"
//#pragma mark - 赠送蓝色代金券某条明细
//#define SUserBalanceBlueCouponLogDetail_Url @"User/gifVoucherListDetail"
//
//
//#pragma mark - 余额明细
//#define SUserBalanceBalanceLog_Url @"UserBalance/balanceLog"
//#pragma mark - 根据ID或者手机获取真实姓名
//#define SUserBalanceGetUserName_Url @"UserBalance/getUserName"
//#pragma mark - 线下充值详情
//#define SUserBalanceGetUnderInfo_Url @"UserBalance/getUnderInfo"
//#pragma mark - 线下充值列表
//#define SUserBalanceUnderMoneys_Url @"UserBalance/underMoneys"
//#pragma mark - 平台银行卡列表
//#define SUserBalancePlatformAccount_Url @"UserBalance/platformAccount"
//#pragma mark - 编辑银行卡
//#define SUserBalanceEditBank_Url @"UserBalance/editBank"
//#pragma mark - 充值订单列表
//#define SUserBalanceUserBalanceHjs_Url @"UserBalance/userBalanceHjs"
//#pragma mark - 充值订单详情
//#define SUserBalanceHjsInfo_Url @"UserBalance/hjsInfo"
//#pragma mark - 删除订单
//#define SUserBalanceDelHjsInfo_Url @"UserBalance/delHjsInfo"
//#pragma mark - 搜索银行卡
//#define SUserBalanceSearchBank_Url @"UserBalance/searchBank"

//会员消息中心
//#pragma mark - 消息中心页
//#define SUserMessageNewMsg_Url @"UserMessage/newMsg"
//#pragma mark - 通知消息列表
//#define SUserMessageMsgList_Url @"UserMessage/msgList"
//#pragma mark - 订单消息列表
//#define SUserMessageOrderMsgList_Url @"UserMessage/orderMsgList"
//#pragma mark - 公告消息列表
//#define SUserMessageAnnounceList_Url @"UserMessage/announceList"
//#pragma mark - 获取公告内容
//#define SUserMessageAnnounceInfo_Url @"UserMessage/announceInfo"

//购物车模块
//#pragma mark - 加入购物车
//#define SCartAddCart_Url @"Cart/addCart"
//#pragma mark - 购物车列表
//#define SCartCartList_Url @"Cart/cartList"
//#pragma mark - 编辑购物车
//#define SCartEditCart_Url @"Cart/editCart"
//#pragma mark - 删除购物车
//#define SCartDelCart_Url @"Cart/delCart"
//#pragma mark - 移入购物车
//#define SCartAddCollect_Url @"Cart/addCollect"

//汽车购订单
//#pragma mark - 新增汽车购订单
//#define SCarOrderAddOrder_Url @"CarOrder/addOrder"
//#pragma mark - 余额支付
//#define SCarOrderBalancePay_Url @"CarOrder/balancePay"
//#pragma mark - 积分支付
//#define SCarOrderIntegralPay_Url @"CarOrder/integralPay"
//#pragma mark - 订单列表
//#define SCarOrderOrderList_Url @"CarOrder/orderList"
//#pragma mark - 订单详情
//#define SCarOrderOrderInfo_Url @"CarOrder/orderInfo"
//#pragma mark - 评价界面
//#define SCarOrderCommentPage_Url @"CarOrder/commentPage"
//#pragma mark - 新增评价
//#define SCarOrderAddComment_Url @"CarOrder/addComment"
//#pragma mark - 取消订单
//#define SCarOrderCancelOrder_Url @"CarOrder/cancelOrder"
//#pragma mark - 删除订单
//#define SCarOrderDeleteOrder_Url @"CarOrder/deleteOrder"
//
////支付模块
//#pragma mark - 获取支付宝支付参数
//#define SPayGetAlipayParam_Url @"Pay/getAlipayParam"
//#pragma mark - 查询订单
//#define SPayFindPayResult_Url @"Pay/findPayResult"
//#pragma mark - 余额支付
//#define SBalancePayBalancePay_Url @"BalancePay/BalancePay"
//#pragma mark - 积分支付
//#define SIntegralPayIntegralPay_Url @"IntegralPay/integralPay"
//#pragma mark - 微信支付
//#define SPayGetJsTine_Url @"Pay/getJsTine"
//#pragma mark - 微信充值
//#define SPayGetHjsp_Url @"Pay/getHjsp"
//
////房产购订单
//#pragma mark - 新增汽车购订单
//#define SHouseOrderAddOrder_Url @"HouseOrder/addOrder"
//#pragma mark - 余额支付
//#define SHouseOrderBalancePay_Url @"HouseOrder/balancePay"
//#pragma mark - 积分支付
//#define SHouseOrderIntegralPay_Url @"HouseOrder/integralPay"
//#pragma mark - 订单列表
//#define SHouseOrderOrderList_Url @"HouseOrder/orderList"
//#pragma mark - 订单详情
//#define SHouseOrderOrderInfo_Url @"HouseOrder/orderInfo"
//#pragma mark - 评价界面
//#define SHouseOrderCommentPage_Url @"HouseOrder/commentPage"
//#pragma mark - 新增评价
//#define SHouseOrderAddComment_Url @"HouseOrder/addComment"
//#pragma mark - 取消订单
//#define SHouseOrderCancelOrder_Url @"HouseOrder/cancelOrder"
//#pragma mark - 删除订单
//#define SHouseOrderDeleteOrder_Url @"HouseOrder/deleteOrder"
//
////订单模块
//#pragma mark - 商品下单确认订单
//#define SOrderSetOrder_Url @"Order/setOrder"
//#pragma mark - 购物车结算页
//#define SOrderShoppingCart_Url @"Order/shoppingCart"
//#pragma mark - 订单列表
//#define SOrderOrderList_Url @"Order/orderList"
//#pragma mark - 取消订单
//#define SOrderCancelOrder_Url @"Order/cancelOrder"
//#pragma mark - 余额支付
//#define SOrderBalancePay_Url @"Order/balancePay"
//#pragma mark - 删除订单
//#define SOrderDeleteOrder_Url @"Order/deleteOrder"
//#pragma mark - 订单详情
//#define SOrderDetails_Url @"Order/details"
//#pragma mark - 评论主页
//#define SOrderCommentindex_Url @"Order/Commentindex"
//#pragma mark - 评论商品
//#define SOrderCommentGoods_Url @"Order/CommentGoods"
//#pragma mark - 评论订单
//#define SOrderCommentOrder_Url @"Order/CommentOrder"
//#pragma mark - 确认收货
//#define SOrderReceiving_Url @"Order/receiving"
//#pragma mark - 延长收货
//#define SOrderDelayReceiving_Url @"Order/delayReceiving"
//
//#pragma mark - 拼单购延长收货
//#define SGroupBuyOrderDelayReceiving_Url @"GroupBuyOrder/delayReceiving"
//
//#pragma mark - 订单物流
//#define SOrderOrderLogistics_Url @"Order/orderLogistics"
//#pragma mark - 提醒发货
//#define SOrderRemind_Url @"Order/remind"
//
//#pragma mark - 拼单购提醒发货
//#define SGroupBuyOrderRemind_Url @"GroupBuyOrder/remind"
//
//#pragma mark - 物流信息
//#define SOrderOrderLogistics_Info @"Order/logistics"
//
////拼单够订单模块
//#pragma mark - 添加订单
//#define SGroupBuyOrderSetOrder_Url @"GroupBuyOrder/setOrder"
//#pragma mark - 结算页
//#define SGroupBuyOrderShoppingCart_Url @"GroupBuyOrder/shoppingCart"
//#pragma mark - 余额支付
//#define SGroupBuyOrderBalancePay_Url @"GroupBuyOrder/balancePay"
//#pragma mark - 取消订单
//#define SGroupBuyOrderCancelOrder_Url @"GroupBuyOrder/cancelOrder"
//#pragma mark - 删除订单
//#define SGroupBuyOrderDeleteOrder_Url @"GroupBuyOrder/deleteOrder"
//#pragma mark - 订单列表
//#define SGroupBuyOrderOrderList_Url @"GroupBuyOrder/orderList"
//#pragma mark - 我要参团
//#define SGroupBuyOrderOffered_Url @"GroupBuyOrder/offered"
//#pragma mark - 确认收货
//#define SGroupBuyOrderReceiving_Url @"GroupBuyOrder/receiving"
//#pragma mark - 订单详情
//#define SGroupBuyOrderDetails_Url @"GroupBuyOrder/details"
//#pragma mark - 拼单购商品属性
//#define SGroupBuyGoodsAttrApi_Url @"GroupBuy/attrApi"
//#pragma mark - 拼单购商品属性
//#define SIntegralBuyAttrApi_Url @"IntegralBuy/attrApi"
//
////预购订单模块
//#pragma mark - 预购结算页
//#define SPreOrderPreShoppingCart_Url @"PreOrder/preShoppingCart"
//#pragma mark - 添加订单
//#define SPreOrderPreSetOrder_Url @"PreOrder/preSetOrder"
//#pragma mark - 取消订单
//#define SPreOrderPreCancelOrder_Url @"PreOrder/preCancelOrder"
//#pragma mark - 删除订单
//#define SPreOrderPreDeleteOrder_Url @"PreOrder/preDeleteOrder"
//#pragma mark - 订单列表
//#define SPreOrderPreOrderList_Url @"PreOrder/preOrderList"
//#pragma mark - 订单详情
//#define SPreOrderPreDetails_Url @"PreOrder/preDetails"
//#pragma mark - 余额支付
//#define SPreOrderPreBalancePay_Url @"PreOrder/preBalancePay"
//#pragma mark - 确认收货
//#define SPreOrderPreReceiving_Url @"PreOrder/preReceiving"
//
////比价购
//#pragma mark - 结算页
//#define SAuctionOrderShoppingCart_Url @"AuctionOrder/ShoppingCart"
//#pragma mark - 添加订单
//#define SAuctionOrderSetOrder_Url @"AuctionOrder/SetOrder"
//#pragma mark - 订单列表
//#define SAuctionOrderOrderList_Url @"AuctionOrder/OrderList"
//#pragma mark - 详情页
//#define SAuctionOrderPreDetails_Url @"AuctionOrder/preDetails"
//#pragma mark - 取消订单
//#define SAuctionOrderCancelOrder_Url @"AuctionOrder/CancelOrder"
//#pragma mark - 删除订单
//#define SAuctionOrderDeleteOrder_Url @"AuctionOrder/DeleteOrder"
//#pragma mark - 确认收货
//#define SAuctionOrderReceiving_Url @"AuctionOrder/Receiving"
//#pragma mark - 保证金判断
//#define SAuctionOrderAuct_Url @"AuctionOrder/auct"
//
////积分抽奖
//#pragma mark - 结算页
//#define SIntegralOrderShoppingCart_Url @"IntegralOrder/ShoppingCart"
//#pragma mark - 添加订单
//#define SIntegralOrderSetOrder_Url @"IntegralOrder/SetOrder"
//#pragma mark - 订单列表
//#define SIntegralOrderOrderList_Url @"IntegralOrder/orderList"
//#pragma mark - 取消订单
//#define SIntegralOrderCancelOrder_Url @"IntegralOrder/cancelOrder"
//#pragma mark - 删除订单
//#define SIntegralOrderDeleteOrder_Url @"IntegralOrder/DeleteOrder"
//#pragma mark - 订单详情
//#define SIntegralOrderDetails_Url @"IntegralOrder/details"
//#pragma mark - 确认收货
//#define SIntegralOrderReceiving_Url @"IntegralOrder/receiving"
//#pragma mark - 支付
//#define SIntegralOrderBalancePay_Url @"IntegralOrder/balancePay"

//售后模块
//#pragma mark - 售后原因
//#define SAfterSaleCause_Url @"AfterSale/cause"
//#pragma mark - 发起售后
//#define SAfterSaleBackApply_Url @"AfterSale/backApply"
//#pragma mark - 展示售后信息
//#define SAfterSaleShowAfter_Url @"AfterSale/showAfter"
//#pragma mark - 快递列表
//#define SAfterSaleShipping_Url @"AfterSale/shipping"
//#pragma mark - 添加快递单号
//#define SAfterSaleAddShipping_Url @"AfterSale/addShipping"
//#pragma mark -  取消售后
//#define SAfterSaleCancelAfter_Url @"AfterSale/cancelAfter"
//#pragma mark - 售后类型及货物状态
//#define SAfterSaleBackApplyType_Url @"AfterSale/backApplyType"
//#pragma mark - 根据单号获取物流公司
//#define SAfterSaleGetCompanyName_Url @"AfterSale/get_company_name"
//
//
////限量购模块
//#pragma mark - 添加订单
//#define SLimitBuyOrderSetOrder_Url @"LimitBuyOrder/setOrder"
//#pragma mark - 订单列表
//#define SLimitBuyOrderOrderList_Url @"LimitBuyOrder/orderList"
//#pragma mark - 结算页
//#define SLimitBuyOrderShoppingCart_Url @"LimitBuyOrder/shoppingCart"
//#pragma mark - 取消订单
//#define SLimitBuyOrderCancelOrder_Url @"LimitBuyOrder/cancelOrder"
//#pragma mark - 删除订单
//#define SLimitBuyOrderDeleteOrder_Url @"LimitBuyOrder/deleteOrder"
//#pragma mark - 订单详情
//#define SLimitBuyOrderDetails_Url @"LimitBuyOrder/details"
//#pragma mark - 确认收货
//#define SLimitBuyOrderReceiving_Url @"LimitBuyOrder/receiving"
//
////无界商店模块
//#pragma mark - 结算页
//#define SIntegralBuyOrderShoppingCart_Url @"IntegralBuyOrder/ShoppingCart"
//#pragma mark - 添加订单
//#define SIntegralBuyOrderSetOrder_Url @"IntegralBuyOrder/SetOrder"
//#pragma mark - 订单列表
//#define SIntegralBuyOrderOrderList_Url @"IntegralBuyOrder/OrderList"
//#pragma mark - 订单详情
//#define SIntegralBuyOrderDetails_Url @"IntegralBuyOrder/details"
//#pragma mark - 删除订单
//#define SIntegralBuyOrderDeleteOrder_Url @"IntegralBuyOrder/DeleteOrder"
//#pragma mark - 取消订单
//#define SIntegralBuyOrderCancelOrder_Url @"IntegralBuyOrder/CancelOrder"
//#pragma mark - 确认收货
//#define SIntegralBuyOrderReceiving_Url @"IntegralBuyOrder/Receiving"
//
////线下商铺模块
//#pragma mark - 线下商铺
//#define SOfflineStoreOfflineStore_Url @"OfflineStore/Index"
//
////公共商品属性
//#pragma mark - 公共商品属性
//#define SGoodsAttrApi_Url @"Goods/attrApi"
//
////运费
//#pragma mark - 商品详情运费
//#define SFreightFreight_Url @"Freight/freight"
//#pragma mark - 订单运费
//#define SFreightSplit_Url @"Freight/splitNew"
//
////环信
////#pragma mark - 客服环信账号
////#define SEasemobBind_Url @"Easemob/bind"
//
////会员卡订单
//#pragma mark - 结算页
//#define SMemberOrderSettlement_Url @"MemberOrder/settlement"
//#pragma mark - 添加订单并支付
//#define SMemberOrderSetOrder_Url @"MemberOrder/setOrder"
//#pragma mark - 使用券金额
//#define SMemberOrderTicket_Url @"MemberOrder/ticket"
//#pragma mark - 会员卡列表消息
//#define SMemberOrderMess_Url @"MemberOrder/mess"
//#pragma mark - 购买会员卡订单列表
//#define SMemberOrderMemberOrderList_Url @"MemberOrder/memberOrderList"
//#pragma mark - 会员卡订单详情
//#define SMemberOrderMemberOrderInfo_Url @"MemberOrder/memberOrderInfo"
//#pragma mark - 删除会员订单
//#define SMemberOrderDelMemberOrder_Url @"MemberOrder/delMemberOrder"
//
////会员卡支付状态查询
//#pragma mark - 支付状态查询
//#define SMemberAliPayFindPayResult_Url @"MemberAliPay/findPayResult"

//联盟商家推荐
//#pragma mark - 联盟/无界驿站推荐
//#define SRecommendingAddBusiness_Url @"Recommending/addBusiness"
//#pragma mark - 联盟商家类型
//#define SRecommendingBusinessType_Url @"Recommending/businessType"
//#pragma mark - 联盟商家列表
//#define SRecommendingBusinessList_Url @"Recommending/businessList"
//#pragma mark - 联盟商家列表详情
//#define SRecommendingBusinessInfo_Url @"Recommending/businessInfo"
//#pragma mark - 商家推荐广告
//#define SRecommendingAdvertImg_Url @"Recommending/advertImg"

////发票、公益宝贝
//#pragma mark - 列表展示内容
//#define SInvoiceInvoice_Url @"Invoice/invoice"
//#pragma mark - 发票明细列表
//#define SInvoiceType_Url @"Invoice/type"

//扫码
//#pragma mark - 扫码登录
//#define ScanQRCodeLogin_url @"Register/qr_login"

#endif /* SuperiorAcme_Url_h */
