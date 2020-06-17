//
//  SMerchantAuctionList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantAuctionListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SMerchantAuctionListFailureBlock) (NSError * error);

@interface SMerchantAuctionList : NSObject
@property (nonatomic, copy) NSString * merchant_id;//店铺id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SMerchantAuctionList * data;
@property (nonatomic, copy) NSString * is_collect;//"是否收藏",//在会员登录情况下出现
//@property (nonatomic, copy) NSString * merchant_id;//"商家ID",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
@property (nonatomic, copy) NSString * merchant_desc;// "店铺描述",
@property (nonatomic, copy) NSString * merchant_slogan;//"店铺口号",//用于显示
@property (nonatomic, copy) NSString * logo;//"店铺logo",
@property (nonatomic, copy) NSString * announce;//":'店铺公告',
@property (nonatomic, copy) NSString * ticket_num;//": "2",//优惠券数量

//优惠券列表
@property (nonatomic, copy) NSArray * ticket_list;
@property (nonatomic, copy) NSString * ticket_id;//": "优惠券id",
@property (nonatomic, copy) NSString * ticket_name;//": "优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//": "优惠券描述",
@property (nonatomic, copy) NSString * ticket_type;//": "优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//": "12",//满减=>金额 满折=>折扣 满赠=>商品id
@property (nonatomic, copy) NSString * condition;//": "满足条件",
//@property (nonatomic, copy) NSString * merchant_id;//": "店铺ID",
@property (nonatomic, copy) NSString * end_time;//": "失效时间",
@property (nonatomic, copy) NSString * start_time;//": "开始时间"
//@property (nonatomic, copy) NSString * ticket_num;//": "优惠券总数量",
@property (nonatomic, copy) NSString * use_num;//": "被领取数量",
//@property (nonatomic, copy) NSString * logo;//’:商家logo
@property (nonatomic, copy) NSString * is_get;//”:'1 已领取  0未领取'

@property (nonatomic, copy) NSArray * goods_list;
@property (nonatomic, copy) NSString * auction_id;//"拍卖id",
//@property (nonatomic, copy) NSString * start_time;//"拍卖开始时间",
@property (nonatomic, copy) NSString * start_price;//
//@property (nonatomic, copy) NSString * end_time;//"结束时间",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家id",
@property (nonatomic, copy) NSString * country_logo;//'国家logo'//当国家ID大于0的时候出现
@property (nonatomic, copy) NSString * ticket_buy_id;//"票券id"
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"//当票券ID大于0的时候出现
@property (nonatomic, copy) NSString * market_price;//

- (void)sMerchantAuctionListSuccess:(SMerchantAuctionListSuccessBlock)success andFailure:(SMerchantAuctionListFailureBlock)failure;
@end
