//
//  SAOnLineMallURLConstant.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAOnLineMallURLConstant : NSObject

#pragma mark - ****************   商品模块   ******************

#pragma mark - 商品列表页
extern NSString *const SGoodsGoodsList_Url;

#pragma mark - 商品详情
extern NSString *const SGoodsGoodsInfo_Url;

#pragma mark - 三级分类商品列表
extern NSString *const SGoodsThreeList_Url;

#pragma mark - 搜索
extern NSString *const SGoodsSearch_Url;

#pragma mark - 领取优惠券
extern NSString *const SGoodsGetTicket_Url;

#pragma mark - 搭配购列表
extern NSString *const SGoodsGroupGoodsList_Url;

#pragma mark - ****************   积分抽奖模块   ******************

#pragma mark - 积分抽奖首页
extern NSString *const SOneBuyOneBuyIndex_Url;

#pragma mark - 积分抽奖详情页
extern NSString *const SOneBuyOneBuyInfo_Url;

#pragma mark - ****************   拼团购模块   ******************

#pragma mark - 拼团购首页
extern NSString *const SGroupBuyGroupBuyIndex_Url;

#pragma mark - 拼团购详情页
extern NSString *const SGroupBuyGroupBuyInfo_Url;

#pragma mark - 参团页
extern NSString *const SGroupBuyGoGroup_Url;

#pragma mark - 三级分类商品列表
extern NSString *const SGroupBuyThreeList_Url;


#pragma mark - ****************   竞拍汇模块   ******************

#pragma mark - 竞拍汇首页
extern NSString *const SAuctionAuctionIndex_Url;

#pragma mark - 竞拍汇详情页
extern NSString *const SAuctionAuctionInfo_Url;

#pragma mark - 设置提醒
extern NSString *const SAuctionRemindMe_Url;


#pragma mark - ****************   无界预购   ******************

#pragma mark - 无界预购首页
extern NSString *const SPreBuyPreBuyIndex_Url;

#pragma mark - 三级分类商品列表
extern NSString *const SPreBuyThreeList_Url;

#pragma mark - 无界预购详情
extern NSString *const SPreBuyPreBuyInfo_Url;


#pragma mark - ****************   限量购   ******************

#pragma mark - 限量购首页
extern NSString *const SLimitBuyLimitBuyIndex_Url;

#pragma mark - 限量购详情
extern NSString *const SLimitBuyLimitBuyInfo_Url;

#pragma mark - 设置提醒限量购
extern NSString *const SLimitBuyRemindMe_Url;

#pragma mark - ****************   票券区   ******************

#pragma mark - 票券区首页
extern NSString *const STicketBuyTicketBuyIndex_Url;

#pragma mark - 票券区商品详情
extern NSString *const STicketBuyTicketBuyInfo_Url;

#pragma mark - 三级分类商品
extern NSString *const STicketBuyThreeList_Url;


#pragma mark - ****************   主题街   ******************

#pragma mark - 主题街展示页
extern NSString *const SThemeThemeList_Url;

#pragma mark - 主题商品页
extern NSString *const SThemeThemeGoods_Url;

#pragma mark - 商品详情页
extern NSString *const SThemeGoodsInfo_Url;

#pragma mark - ****************   无界商店   ******************

#pragma mark - 无界商店首页
extern NSString *const SIntegralBuyIntegralBuyIndex_Url;

#pragma mark - 无界商店详情
extern NSString *const SIntegralBuyIntegralBuyInfo_Url;

#pragma mark - 三级分类商品
extern NSString *const SIntegralBuyThreeList_Url;

#pragma mark - 无界商店取消订单
extern NSString *const SIntegralBuyCancelOrder_Url;

#pragma mark - 无界商店延长收货
extern NSString *const SIntegralBuyDelayReceiving_Url;


#pragma mark - ****************   商家模块   ******************

#pragma mark - 店铺首页
extern NSString *const SMerchantMerIndex_Url;

#pragma mark - 店铺详情
extern NSString *const SMerchantMerInfo_Url;

#pragma mark - 商品页
extern NSString *const SMerchantGoodsList_Url;

#pragma mark - 获取评论列表
extern NSString *const SMerchantCommentList_Url;

#pragma mark - 活动商品-拼团购
extern NSString *const SMerchantGroupList_Url;

#pragma mark - 店铺活动商品拼单购新接口
extern NSString *const SGroupBuyMerchantGroupBuyList_Url;

#pragma mark - 活动商品-无界预购
extern NSString *const SMerchantPreList_Url;

#pragma mark - 活动商品-一元购
extern NSString *const SMerchantOneBuyList_Url;

#pragma mark - 活动商品-竞拍汇
extern NSString *const SMerchantAuctionList_Url;

#pragma mark - 商家资质
extern NSString *const SMerchantLicense_Url;

#pragma mark - 举报商家
extern NSString *const SMerchantReport_Url;

#pragma mark - 活动商品-限量购
extern NSString *const SMerchantLimitList_Url;

#pragma mark - 举报类型
extern NSString *const SMerchantReportType_Url;

#pragma mark - ****************   进口馆   ******************

#pragma mark - 进口馆首页
extern NSString *const SCountryCountryIndex_Url;

#pragma mark - 选定国家商品列表
extern NSString *const SCountryCountryGoods_Url;

#pragma mark - 商品详情
extern NSString *const SCountryGoodsInfo_Url;

#pragma mark - 三级分类商品
extern NSString *const SCountryThreeList_Url;


#pragma mark - ****************   福利社   ******************

#pragma mark - 优惠券
extern NSString *const SWelfareTicketList_Url;

#pragma mark - 领取优惠券
extern NSString *const SWelfareGetTicket_Url;

#pragma mark - 红包列表
extern NSString *const SWelfareFaceList_Url;

#pragma mark - 红包广告
extern NSString *const SWelfareBonusList_Url;

#pragma mark - 领取红包
extern NSString *const SWelfareGetBonus_Url;

#pragma mark - 红包分享内容
extern NSString *const SWelfareShareContent_Url;

#pragma mark - ****************  汽车购   ******************

#pragma mark -  汽车筛选页
extern NSString *const SCarBuyCarSelect_Url;

#pragma mark -  汽车列表页
extern NSString *const SCarBuyCarList_Url;

#pragma mark -  汽车详情
extern NSString *const SCarBuyCarInfo_Url;

#pragma mark -  评价列表
extern NSString *const SCarBuyCommentList_Url;


#pragma mark - ****************  商品分类模块   ******************

#pragma mark -  分类页面
extern NSString *const SGoodsCategoryCateIndex_Url;

#pragma mark - ****************  房产购   ******************

#pragma mark -  楼盘列表
extern NSString *const SHouseBuyHouseList_Url;

#pragma mark -  楼盘详情
extern NSString *const SHouseBuyHouseInfo_Url;

#pragma mark -  户型列表
extern NSString *const SHouseBuyHouseStyleList_Url;


#pragma mark -  户型详情
extern NSString *const SHouseBuyStyleInfo_Url;

#pragma mark -  评价列表
extern NSString *const SHouseBuyCommentList_Url;

#pragma mark - ****************  产业孵化   ******************

#pragma mark -  企业列表页
extern NSString *const SCompanyDevelopCompanyList_Url;

#pragma mark -  企业简介
extern NSString *const SCompanyDevelopCompanyInfo_Url;

#pragma mark - ****************  首页   ******************

#pragma mark -  App首页
extern NSString *const SIndexIndex_Url;

#pragma mark -  获取头条列表
extern NSString *const SIndexHeadLineList_Url;

#pragma mark -  头条详情
extern NSString *const SIndexHeadInfo_Url;

#pragma mark - *********** 购物车模块 ***************
#pragma mark - 加入购物车
extern NSString *const SCartAddCart_Url;
#pragma mark - 购物车列表
extern NSString *const SCartCartList_Url;
#pragma mark - 编辑购物车
extern NSString *const SCartEditCart_Url;
#pragma mark - 删除购物车
extern NSString *const SCartDelCart_Url;
#pragma mark - 移入购物车
extern NSString *const SCartAddCollect_Url;

//汽车购订单
#pragma mark - 新增汽车购订单
extern NSString *const SCarOrderAddOrder_Url ;
#pragma mark - 余额支付
extern NSString *const SCarOrderBalancePay_Url ;
#pragma mark - 积分支付
extern NSString *const SCarOrderIntegralPay_Url;
#pragma mark - 订单列表
extern NSString *const SCarOrderOrderList_Url;
#pragma mark - 订单详情
extern NSString *const SCarOrderOrderInfo_Url;
#pragma mark - 评价界面
extern NSString *const SCarOrderCommentPage_Url ;
#pragma mark - 新增评价
extern NSString *const SCarOrderAddComment_Url;
#pragma mark - 取消订单
extern NSString *const SCarOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SCarOrderDeleteOrder_Url ;

//支付模块
#pragma mark - 获取支付宝支付参数
extern NSString *const SPayGetAlipayParam_Url ;
#pragma mark - 查询订单
extern NSString *const SPayFindPayResult_Url ;
#pragma mark - 余额支付
extern NSString *const SBalancePayBalancePay_Url;
#pragma mark - 积分支付
extern NSString *const SIntegralPayIntegralPay_Url;
#pragma mark - 微信支付
extern NSString *const SPayGetJsTine_Url;
#pragma mark - 微信充值
extern NSString *const SPayGetHjsp_Url ;

//房产购订单
#pragma mark - 新增汽车购订单
extern NSString *const SHouseOrderAddOrder_Url ;
#pragma mark - 余额支付
extern NSString *const SHouseOrderBalancePay_Url;
#pragma mark - 积分支付
extern NSString *const SHouseOrderIntegralPay_Url ;
#pragma mark - 订单列表
extern NSString *const SHouseOrderOrderList_Url ;
#pragma mark - 订单详情
extern NSString *const SHouseOrderOrderInfo_Url ;
#pragma mark - 评价界面
extern NSString *const SHouseOrderCommentPage_Url ;
#pragma mark - 新增评价
extern NSString *const SHouseOrderAddComment_Url;
#pragma mark - 取消订单
extern NSString *const SHouseOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SHouseOrderDeleteOrder_Url;

//订单模块
#pragma mark - 商品下单确认订单
extern NSString *const SOrderSetOrder_Url ;
#pragma mark - 购物车结算页
extern NSString *const SOrderShoppingCart_Url ;
#pragma mark - 订单列表
extern NSString *const SOrderOrderList_Url ;
#pragma mark - 取消订单
extern NSString *const SOrderCancelOrder_Url ;
#pragma mark - 余额支付
extern NSString *const SOrderBalancePay_Url ;
#pragma mark - 删除订单
extern NSString *const SOrderDeleteOrder_Url ;
#pragma mark - 订单详情
extern NSString *const SOrderDetails_Url;
#pragma mark - 评论主页
extern NSString *const SOrderCommentindex_Url ;
#pragma mark - 评论商品
extern NSString *const SOrderCommentGoods_Url ;
#pragma mark - 评论订单
extern NSString *const SOrderCommentOrder_Url;
#pragma mark - 确认收货
extern NSString *const SOrderReceiving_Url ;
#pragma mark - 延长收货
extern NSString *const SOrderDelayReceiving_Url ;

#pragma mark - 拼单购延长收货
extern NSString *const SGroupBuyOrderDelayReceiving_Url;

#pragma mark - 订单物流
extern NSString *const SOrderOrderLogistics_Url ;
#pragma mark - 提醒发货
extern NSString *const SOrderRemind_Url ;

#pragma mark - 拼单购提醒发货
extern NSString *const SGroupBuyOrderRemind_Url;

#pragma mark - 无界商店提醒发货
extern NSString *const IntegralBuyOrderRemind_Url;

#pragma mark - 物流信息
extern NSString *const SOrderOrderLogistics_Info;

//拼单够订单模块
#pragma mark - 添加订单
extern NSString *const SGroupBuyOrderSetOrder_Url ;
#pragma mark - 结算页
extern NSString *const SGroupBuyOrderShoppingCart_Url ;
#pragma mark - 余额支付
extern NSString *const SGroupBuyOrderBalancePay_Url;
#pragma mark - 取消订单
extern NSString *const SGroupBuyOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SGroupBuyOrderDeleteOrder_Url;
#pragma mark - 订单列表
extern NSString *const SGroupBuyOrderOrderList_Url;
#pragma mark - 我要参团
extern NSString *const SGroupBuyOrderOffered_Url;
#pragma mark - 确认收货
extern NSString *const SGroupBuyOrderReceiving_Url;
#pragma mark - 订单详情
extern NSString *const SGroupBuyOrderDetails_Url;
#pragma mark - 拼单购商品属性
extern NSString *const SGroupBuyGoodsAttrApi_Url ;
#pragma mark - 拼单购商品属性
extern NSString *const SIntegralBuyAttrApi_Url;

//预购订单模块
#pragma mark - 预购结算页
extern NSString *const SPreOrderPreShoppingCart_Url;
#pragma mark - 添加订单
extern NSString *const SPreOrderPreSetOrder_Url ;
#pragma mark - 取消订单
extern NSString *const SPreOrderPreCancelOrder_Url ;
#pragma mark - 删除订单
extern NSString *const SPreOrderPreDeleteOrder_Url ;
#pragma mark - 订单列表
extern NSString *const SPreOrderPreOrderList_Url ;
#pragma mark - 订单详情
extern NSString *const SPreOrderPreDetails_Url;
#pragma mark - 余额支付
extern NSString *const SPreOrderPreBalancePay_Url;
#pragma mark - 确认收货
extern NSString *const SPreOrderPreReceiving_Url;

//比价购
#pragma mark - 结算页
extern NSString *const SAuctionOrderShoppingCart_Url;
#pragma mark - 添加订单
extern NSString *const SAuctionOrderSetOrder_Url;
#pragma mark - 订单列表
extern NSString *const SAuctionOrderOrderList_Url ;
#pragma mark - 详情页
extern NSString *const SAuctionOrderPreDetails_Url;
#pragma mark - 取消订单
extern NSString *const SAuctionOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SAuctionOrderDeleteOrder_Url ;
#pragma mark - 确认收货
extern NSString *const SAuctionOrderReceiving_Url;
#pragma mark - 保证金判断
extern NSString *const SAuctionOrderAuct_Url;

//积分抽奖
#pragma mark - 结算页
extern NSString *const SIntegralOrderShoppingCart_Url;
#pragma mark - 添加订单
extern NSString *const SIntegralOrderSetOrder_Url;
#pragma mark - 订单列表
extern NSString *const SIntegralOrderOrderList_Url ;
#pragma mark - 取消订单
extern NSString *const SIntegralOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SIntegralOrderDeleteOrder_Url;
#pragma mark - 订单详情
extern NSString *const SIntegralOrderDetails_Url;
#pragma mark - 确认收货
extern NSString *const SIntegralOrderReceiving_Url;
#pragma mark - 支付
extern NSString *const SIntegralOrderBalancePay_Url;


//售后模块
#pragma mark - 售后原因
extern NSString *const SAfterSaleCause_Url ;
#pragma mark - 发起售后
extern NSString *const SAfterSaleBackApply_Url;
#pragma mark - 展示售后信息
extern NSString *const SAfterSaleShowAfter_Url;
#pragma mark - 快递列表
extern NSString *const SAfterSaleShipping_Url ;
#pragma mark - 添加快递单号
extern NSString *const SAfterSaleAddShipping_Url ;
#pragma mark -  取消售后
extern NSString *const SAfterSaleCancelAfter_Url;
#pragma mark - 售后类型及货物状态
extern NSString *const SAfterSaleBackApplyType_Url;
#pragma mark - 根据单号获取物流公司
extern NSString *const SAfterSaleGetCompanyName_Url;


//限量购模块
#pragma mark - 添加订单
extern NSString *const SLimitBuyOrderSetOrder_Url ;
#pragma mark - 订单列表
extern NSString *const SLimitBuyOrderOrderList_Url;
#pragma mark - 结算页
extern NSString *const SLimitBuyOrderShoppingCart_Url ;
#pragma mark - 取消订单
extern NSString *const SLimitBuyOrderCancelOrder_Url;
#pragma mark - 删除订单
extern NSString *const SLimitBuyOrderDeleteOrder_Url;
#pragma mark - 订单详情
extern NSString *const SLimitBuyOrderDetails_Url;
#pragma mark - 确认收货
extern NSString *const SLimitBuyOrderReceiving_Url;

//无界商店模块
#pragma mark - 结算页
extern NSString *const SIntegralBuyOrderShoppingCart_Url;
#pragma mark - 添加订单
extern NSString *const SIntegralBuyOrderSetOrder_Url;
#pragma mark - 订单列表
extern NSString *const SIntegralBuyOrderOrderList_Url;
#pragma mark - 订单详情
extern NSString *const SIntegralBuyOrderDetails_Url;
#pragma mark - 删除订单
extern NSString *const SIntegralBuyOrderDeleteOrder_Url;
#pragma mark - 取消订单
extern NSString *const SIntegralBuyOrderCancelOrder_Url;
#pragma mark - 确认收货
extern NSString *const SIntegralBuyOrderReceiving_Url;

//线下商铺模块
#pragma mark - 线下商铺
extern NSString *const SOfflineStoreOfflineStore_Url;
#pragma mark - 线下商铺首页附近店铺
extern NSString *const SOfflineStoreOfflineStoreList_Url;

//公共商品属性
#pragma mark - 公共商品属性
extern NSString *const SGoodsAttrApi_Url;

//运费
#pragma mark - 商品详情运费
extern NSString *const SFreightFreight_Url;
#pragma mark - 订单运费
extern NSString *const SFreightSplit_Url;


//会员卡订单
#pragma mark - 结算页
extern NSString *const SMemberOrderSettlement_Url ;
#pragma mark - 添加订单并支付
extern NSString *const SMemberOrderSetOrder_Url;
#pragma mark - 使用券金额
extern NSString *const SMemberOrderTicket_Url;
#pragma mark - 会员卡列表消息
extern NSString *const SMemberOrderMess_Url;
#pragma mark - 购买会员卡订单列表
extern NSString *const SMemberOrderMemberOrderList_Url;
#pragma mark - 会员卡订单详情
extern NSString *const SMemberOrderMemberOrderInfo_Url;
#pragma mark - 删除会员订单
extern NSString *const SMemberOrderDelMemberOrder_Url;

//会员卡支付状态查询
#pragma mark - 支付状态查询
extern NSString *const SMemberAliPayFindPayResult_Url;


//发票、公益宝贝
#pragma mark - 列表展示内容
extern NSString *const SInvoiceInvoice_Url ;
#pragma mark - 发票明细列表
extern NSString *const SInvoiceType_Url;

@end
