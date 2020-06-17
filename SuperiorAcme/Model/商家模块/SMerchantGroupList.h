//
//  SMerchantGroupList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantGroupListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SMerchantGroupListFailureBlock) (NSError * error);

@interface SMerchantGroupList : NSObject
@property (nonatomic, copy) NSString * merchant_id;//店铺id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SMerchantGroupList * data;
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
@property (nonatomic, copy) NSString * group_buy_id;//"团购ID"
@property (nonatomic, copy) NSString * group_price;//"团购价",
@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * group_num;//"团购所需人数",
@property (nonatomic, copy) NSString * total;//"本活动总参团人",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片g",
@property (nonatomic, copy) NSString * country_id;// "国家ID",
@property (nonatomic, copy) NSString * ticket_buy_id;//"抵扣券id",
@property (nonatomic, copy) NSString * country_logo;//"国家图片",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"
//两个参团人头像
@property (nonatomic, copy) NSArray * append_person;
@property (nonatomic, copy) NSString * log_id;//": "团编号",
@property (nonatomic, copy) NSString * user_id;//": "开团者id",
@property (nonatomic, copy) NSString * head_pic;//": "开团者头像"

/*
 *区别普通拼单商品和体验拼单商品
 */
@property (nonatomic, copy) NSString * group_type;//"类型 1试用品拼单 2常规拼单",

- (void)sMerchantGroupListSuccess:(SMerchantGroupListSuccessBlock)success andFailure:(SMerchantGroupListFailureBlock)failure;
@end
