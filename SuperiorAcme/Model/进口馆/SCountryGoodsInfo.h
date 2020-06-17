//
//  SCountryGoodsInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCountryGoodsInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCountryGoodsInfoFailureBlock) (NSError * error);

@interface SCountryGoodsInfo : NSObject
@property (nonatomic, copy) NSString * goods_id;//商品ID

@property (nonatomic, strong) SCountryGoodsInfo * data;
@property (nonatomic, copy) NSString * msg_tip;//消息提醒数, //在会员登录情况下才有
@property (nonatomic, copy) NSString * is_collect;//"是否收藏", //在会员登录情况下查看
@property (nonatomic, copy) NSString * cart_num;//"购物车数量", //在会员登录情况下查看
@property (nonatomic, copy) NSString * share_url;//": "http://wjyp.txunda.com",//分享链接
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_content;//": "分享内容"

@property (nonatomic, strong) SCountryGoodsInfo * goodsInfo;
//@property (nonatomic, copy) NSString * goods_id;//"商品id ",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"售价",
@property (nonatomic, copy) NSString * integral;//"赠送积分",
@property (nonatomic, copy) NSString * goods_desc;//"商品图文详情",//HTML格式
@property (nonatomic, copy) NSString * goods_brief;//"商品简介",
@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"是否属于票券区",//大于 0 表示属于票券区
@property (nonatomic, copy) NSString * country_id;//"国家ID",// 0表示中国
@property (nonatomic, copy) NSString * country_logo;//国家logo
@property (nonatomic, copy) NSString * country_desc;//"商品进口国家描述",//如：越南进口，本地发货
@property (nonatomic, copy) NSString * country_tax;//"进口税",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"商品享受购物券折扣"

@property (nonatomic, strong) SCountryGoodsInfo * mInfo;
//@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
@property (nonatomic, copy) NSString * easemob_account;//"商家环信账号",
@property (nonatomic, copy) NSString * level;//"店铺等级",
@property (nonatomic, copy) NSString * logo;//"店铺logo",
@property (nonatomic, copy) NSString * view_num;//"关注人数"
@property (nonatomic, copy) NSString * all_goods;//"宝贝总数",
@property (nonatomic, copy) NSString * goods_score;//"宝贝评分",
@property (nonatomic, copy) NSString * merchant_score;//"卖家评分",
@property (nonatomic, copy) NSString * shipping_score;//"物流评分"

//店铺优惠活动
@property (nonatomic, copy) NSArray * promotion;
@property (nonatomic, copy) NSString * title;//"优惠活动名称",
@property (nonatomic, copy) NSString * promotion_id;//"优惠id",
@property (nonatomic, copy) NSString * type;//"类型" //1.满减 2满折

//优惠券列表
@property (nonatomic, copy) NSArray * ticketList;
@property (nonatomic, copy) NSString * ticket_id;//"优惠券ID",
@property (nonatomic, copy) NSString * ticket_name;//"优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//"优惠券详情",
@property (nonatomic, copy) NSString * ticket_type;//"优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//"面额", //满减=>金额 满折=>折扣 满赠=>商品id
@property (nonatomic, copy) NSString * condition;//"满足条件",
@property (nonatomic, copy) NSString * start_time;//"开始时间",
@property (nonatomic, copy) NSString * end_time;//"结束时间"

//产品规格列表
@property (nonatomic, copy) NSArray * goods_common_attr;
//@property (nonatomic, copy) NSString * id;//"规格编号",
//@property (nonatomic, copy) NSString * attr_name;//"规格名称",
//@property (nonatomic, copy) NSString * attr_value;//"规格值"

//商品属性
@property (nonatomic, copy) NSArray * goodsAttr;
@property (nonatomic, copy) NSString * id;//"id",
@property (nonatomic, copy) NSString * aid;//"属性ID"
@property (nonatomic, copy) NSString * attr_name;//"属性名称",
@property (nonatomic, copy) NSString * attr_value;//"属性值"
@property (nonatomic, copy) NSString * attr_price;//"属性附加价格"

//商品图片轮播图列表
@property (nonatomic, copy) NSArray * goods_banner;
@property (nonatomic, copy) NSString * path;//"轮播图"

//属性图片列表
@property (nonatomic, copy) NSArray * attr_images;
@property (nonatomic, copy) NSString * attr_id;//"属性id",
@property (nonatomic, copy) NSString * pic;//"属性图片"

//货品
@property (nonatomic, copy) NSArray * product;
//@property (nonatomic, copy) NSString * id;//"75",
//@property (nonatomic, copy) NSString * goods_id;//"12",
@property (nonatomic, copy) NSString * goods_attr;//"属性组合 属性id用 | 隔开",
@property (nonatomic, copy) NSString * product_sn;//"货品号",
@property (nonatomic, copy) NSString * product_number;//"货品库存"

@property (nonatomic, strong) SCountryGoodsInfo * comment;
@property (nonatomic, copy) NSString * total;
//评论主体
@property (nonatomic, strong) SCountryGoodsInfo * body;
@property (nonatomic, copy) NSString * comment_id;//"评论ID",
//@property (nonatomic, copy) NSString * goods_id;//"商品ID",
//@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * user_id;//"用户ID",
@property (nonatomic, copy) NSString * nickname;//"用户昵称",
@property (nonatomic, copy) NSString * content;//"评论内容",
@property (nonatomic, copy) NSString * all_star;//"评论星级",
@property (nonatomic, copy) NSString * product_id;//"货品ID",
@property (nonatomic, copy) NSString * order_goods_id;// "1",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * user_head_pic;//"用户头像",
@property (nonatomic, copy) NSString * good_attr;//"所评价商品属性",
@property (nonatomic, copy) NSString * goods_num;//"所买数量",
//@property (nonatomic, copy) NSString * shop_price;//"售价",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * order_type;//"订单类型" ////0普通订单 1团购订单 2无界预购 3竞拍汇 4积分夺宝 5无界商店 6汽车购 7房产购 8线下商城
//评论主体
@property (nonatomic, copy) NSArray * pictures;
//@property (nonatomic, copy) NSString * path;//"图片路径"

- (void)sCountryGoodsInfoSuccess:(SCountryGoodsInfoSuccessBlock)success andFailure:(SCountryGoodsInfoFailureBlock)failure;
@end
