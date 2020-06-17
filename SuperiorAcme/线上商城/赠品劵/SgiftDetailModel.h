//
//  SgiftDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftDetailModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SgiftDetailModelFailureBlock) (NSError * error);
@interface SgiftDetailModel : NSObject
@property (nonatomic, copy) NSString * gift_goods_id;//无界商店商品编号
@property (nonatomic, copy) NSString * p;//


@property (nonatomic, strong) SgiftDetailModel * data;

//属性图片列表
@property (nonatomic, copy) NSArray * attr_images;
@property (nonatomic, copy) NSString * cart_num;//"购物车数量", //在会员登录情况下查看
@property (nonatomic, strong) SgiftDetailModel * cheap_group;

@property (nonatomic, strong) SgiftDetailModel * comment;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, strong) SgiftDetailModel * body;

//属性列表
@property (nonatomic, copy) NSArray * first_list;
@property (nonatomic, copy) NSString * first_list_name;//": "颜色",        // 属性名
@property (nonatomic, copy) NSArray * first_list_val;
@property (nonatomic, copy) NSString * val;//": "红色"

//属性比对列表
@property (nonatomic, copy) NSArray * first_val;
@property (nonatomic, copy) NSString * arrtValue;
@property (nonatomic, copy) NSString * arrtValue_andr;
@property (nonatomic, copy) NSString * examine;
@property (nonatomic, copy) NSString * examine_time;
@property (nonatomic, copy) NSString * examine_id;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_img;
@property (nonatomic, copy) NSString * goods_num;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * price_id;
@property (nonatomic, copy) NSString * settlement_price;
@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * special;
@property (nonatomic, copy) NSString * special_id;
@property (nonatomic, copy) NSString * special_name;
@property (nonatomic, copy) NSString * special_time;
@property (nonatomic, copy) NSString * use_voucher;
@property (nonatomic, copy) NSString * wy_price_special;
@property (nonatomic, copy) NSString * yx_price_special;

@property (nonatomic, strong) SgiftDetailModel * goodsInfo;
@property (nonatomic, copy) NSString * a_fee_new;
@property (nonatomic, copy) NSString * after_sale_service;
@property (nonatomic, copy) NSString * all_goods_num;
@property (nonatomic, copy) NSString * arrt_name;
@property (nonatomic, copy) NSString * arrt_value;
@property (nonatomic, copy) NSString * auction_id;
@property (nonatomic, copy) NSString * blue_discount;
@property (nonatomic, copy) NSString * buy_status;
@property (nonatomic, copy) NSString * cat_id;
@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, copy) NSString * country_desc;
@property (nonatomic, copy) NSString * country_id;
@property (nonatomic, copy) NSString * country_logo;
@property (nonatomic, copy) NSString * country_tax;
@property (nonatomic, copy) NSString * country_tax_rate;
@property (nonatomic, copy) NSString * delivery_price;
@property (nonatomic, copy) NSString * discount;


@property (nonatomic, copy) NSArray * dj_ticket;
@property (nonatomic, copy) NSString * type;//": "1"//类型 1红券  2黄券 3蓝券
@property (nonatomic, copy) NSString * discount_desc;//": "本产品最多可以使用30%红券抵扣现金"，//描述

@property (nonatomic, copy) NSString * end_date;
@property (nonatomic, copy) NSString * exchange_num;//"已兑换数量"
@property (nonatomic, copy) NSString * g_sell_num;

@property (nonatomic, copy) NSArray * goods_active;
@property (nonatomic, copy) NSString * goods_brief;//"商品简介",
@property (nonatomic, copy) NSString * goods_code;
@property (nonatomic, copy) NSString * goods_desc;//"属性id",
@property (nonatomic, copy) NSString * goods_name;//"属性图片"
@property (nonatomic, copy) NSString * group_buy_id;//"商品简介",
@property (nonatomic, copy) NSString * integral;
@property (nonatomic, copy) NSString * integral_buy_id;//"属性id",
@property (nonatomic, copy) NSString * is_active;//"属性图片"
@property (nonatomic, copy) NSString * is_buy;//"商品简介",
@property (nonatomic, copy) NSString * is_end;
@property (nonatomic, copy) NSString * is_end_desc;//"属性id",
@property (nonatomic, copy) NSString * is_new_goods;//"属性图片"
@property (nonatomic, copy) NSString * is_new_goods_desc;//"商品简介",
@property (nonatomic, copy) NSString * limit_buy_id;
@property (nonatomic, copy) NSString * mall_status;//"属性id",
//@property (nonatomic, copy) NSString * market_price;//"属性图片"
@property (nonatomic, copy) NSString * merchant_id;//"商品简介",
@property (nonatomic, copy) NSString * one_buy_id;
@property (nonatomic, copy) NSString * package_list;//"属性id",
@property (nonatomic, copy) NSString * pcate_id;//"属性图片"
@property (nonatomic, copy) NSString * pre_buy_id;//"商品简介",
@property (nonatomic, copy) NSString * red_return_integral;
@property (nonatomic, copy) NSString * sales;//"属性id",
@property (nonatomic, copy) NSString * sell_num;//"属性图片"
//@property (nonatomic, copy) NSString * settlement_price;//"商品简介",
//@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * ticket_buy_discount;//"属性id",
@property (nonatomic, copy) NSString * ticket_buy_id;//"属性图片"
@property (nonatomic, copy) NSString * top_cate_id;//"商品简介",
@property (nonatomic, copy) NSString * two_cate_name;
@property (nonatomic, copy) NSString * use_integral;//"属性id",
//@property (nonatomic, copy) NSString * use_voucher;//"属性图片"
@property (nonatomic, copy) NSString * wy_price;//"属性图片"
@property (nonatomic, copy) NSString * yellow_discount;//"商品简介",
@property (nonatomic, copy) NSString * yellow_return_integral;
@property (nonatomic, copy) NSString * yx_price;//"属性id",

//商品图片轮播图列表
@property (nonatomic, copy) NSArray * goods_banner;
@property (nonatomic, copy) NSString * path;//"轮播图"


//产品规格列表
@property (nonatomic, copy) NSArray * goods_common_attr;
@property (nonatomic, copy) NSArray * list;
//@property (nonatomic, copy) NSString * id;//"id",
@property (nonatomic, copy) NSString * attr_name;//"属性名称",
@property (nonatomic, copy) NSString * attr_value;//"属性值"
@property (nonatomic, copy) NSString * specification;//"属性名称",
@property (nonatomic, copy) NSString * unit;//"属性值"
@property (nonatomic, copy) NSString * title;//"优惠活动名称",

//价格说明
@property (nonatomic, copy) NSArray * goods_price_desc;
@property (nonatomic, copy) NSString * icon;//": "http://wjyp.txunda.com/Uploads/GoodsPriceDesc/2017-11-13/5a092c91a8bce.png",//图标
@property (nonatomic, copy) NSString * price_name;//": "无忧价",//价格名称
@property (nonatomic, copy) NSString * desc;//": "这是一段无忧价的价格说明"//价格说明文字

//商品服务信息
@property (nonatomic, copy) NSArray * goods_server;
//@property (nonatomic, copy) NSString * id;//": "2",
@property (nonatomic, copy) NSString * server_name;//": "七天无理由退换货",//服务标题

//猜你喜欢
@property (nonatomic, copy) NSArray * guess_goods_list;

@property (nonatomic, copy) NSString * country_name;//": "卖出数量",

// 属性值
@property (nonatomic, copy) NSString * is_attr;//@""未选中 @"1"选中 @"2"无库存
@property (nonatomic, copy) NSString * is_cart;//@""未选中 @"1"选中 @"2"无库存
@property (nonatomic, copy) NSString * is_collect;//@""未选中 @"1"选中 @"2"无库存
@property (nonatomic, strong) SgiftDetailModel * mInfo;
@property (nonatomic, copy) NSString * all_goods;//"宝贝总数",
@property (nonatomic, copy) NSString * goods_score;//"宝贝评分",
@property (nonatomic, copy) NSString * level;//"店铺等级",
@property (nonatomic, copy) NSString * logo;//"店铺logo",
@property (nonatomic, copy) NSString * merchant_easemob_account;//": "150582059257251",//商家客服账号
@property (nonatomic, copy) NSString * merchant_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-19/59c0ff9493ec1.png",//商家客服头像
//@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
@property (nonatomic, copy) NSString * merchant_nickname;//": "hi po n",//客服昵称
@property (nonatomic, copy) NSString * merchant_score;//"卖家评分",
@property (nonatomic, copy) NSString * merchant_phone;//"商家环信账号",
@property (nonatomic, copy) NSString * view_num;//"关注人数"
@property (nonatomic, copy) NSString * score;//"物流评分"
@property (nonatomic, copy) NSString * send_score;//"关注人数"
@property (nonatomic, copy) NSString * shipping_score;//"物流评分"

@property (nonatomic, copy) NSString * msg_tip;// 消息提醒数, //在会员登录情况下才有
@property (nonatomic, copy) NSString * price_desc;//": "1.无忧价：无忧价格说明。\r\n2.优享价：优享价说明\r\n3.折扣：折扣说明。\r\n4.异常问题：异常问题说明",//价格说明
//店铺优惠活动
@property (nonatomic, copy) NSArray * promotion;
@property (nonatomic, copy) NSString * remarks;//": "本品由得一蜂业旗舰店从境内发货，并提供下单后2小时内发货。"   //注释内容
//优惠组合
@property (nonatomic, copy) NSString * send_city;//": "双十一最佳搭配，超省组合",//优惠组合名称
@property (nonatomic, copy) NSString * send_fee;//": "98.80",//优惠组合价格
@property (nonatomic, copy) NSString * share_img;//": "0",//赠送积分
@property (nonatomic, copy) NSString * share_url;//": "10%",//最多可使用多少代金券

//优惠券列表
@property (nonatomic, copy) NSArray * ticketList;
@property (nonatomic, copy) NSString * vouchers_desc;//代金券说明

@property (nonatomic, copy) NSString * share_content;//": "分享内容"

@property (nonatomic, copy) NSArray * easemob_account;
@property (nonatomic, copy) NSString * hx;//": "151237607243994",         //商家客服账号
@property (nonatomic, copy) NSString * nickname;//": "无界新人",            //商家客服昵称
@property (nonatomic, copy) NSString * head_pic;//": ""                         //商家客服账号头像


@property (nonatomic, copy) NSString * product_id;//    商品属性id （特殊商品时需传）

@property (nonatomic, copy) NSString * act_type;//": "1",//1免费抽奖，2无界预购，3拍卖，4限量购，5拼单购
@property (nonatomic, copy) NSString * act_id;//": "2",//id
@property (nonatomic, copy) NSString * act_desc;//": "本商品正在进行免费抽奖活动"//描述

@property (nonatomic, copy) NSString * promotion_id;//"优惠id",

@property (nonatomic, copy) NSString * ticket_id;//"优惠券ID",
@property (nonatomic, copy) NSString * ticket_name;//"优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//"优惠券详情",
@property (nonatomic, copy) NSString * ticket_type;//"优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//"面额", //满减=>金额 满折=>折扣 满赠=>商品id

/*
 *添加优惠券描述属性
 */
@property (nonatomic, copy) NSString * value_replace;//优惠券描述

@property (nonatomic, copy) NSString * condition;//"满足条件",
@property (nonatomic, copy) NSString * start_time;//"开始时间",
@property (nonatomic, copy) NSString * end_time;//"结束时间"
@property (nonatomic, copy) NSString * get_receive;//": "0"//0未领取 1已领取

//商品属性
@property (nonatomic, copy) NSArray * goodsAttr;

@property (nonatomic, copy) NSString * aid;//"属性ID",

@property (nonatomic, copy) NSString * attr_price;//"属性附加价格"

@property (nonatomic, copy) NSString * attr_id;//"属性id",
@property (nonatomic, copy) NSString * pic;//"属性图片"

//商品属性列表
@property (nonatomic, copy) NSArray * goods_attr;

@property (nonatomic, copy) NSArray * attr_list;

@property (nonatomic, copy) NSString * goods_attr_id;//": "697",//商品属性值id

@property (nonatomic, assign) BOOL goods_attr_BOOL;//是否选中

//货品
@property (nonatomic, copy) NSArray * product;

@property (nonatomic, copy) NSString * goods_attr_str;//"属性组合",
@property (nonatomic, copy) NSString * product_sn;//"货品号",
@property (nonatomic, copy) NSString * product_number;//"货品库存"


@property (nonatomic, copy) NSString * comment_id;//"评论ID",

@property (nonatomic, copy) NSString * user_id;//"用户ID",

@property (nonatomic, copy) NSString * content;//"评论内容",
@property (nonatomic, copy) NSString * all_star;//"评论星级",

@property (nonatomic, copy) NSString * order_goods_id;//"1",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * user_head_pic;//用户头像",
@property (nonatomic, copy) NSString * good_attr;//"所评价商品属性",

@property (nonatomic, copy) NSString * order_type;//"订单类型" ////0普通订单 1团购订单 2无界预购 3竞拍汇 4积分夺宝 5无界商店 6汽车购 7房产购 8线下商城
//评论图片列表
@property (nonatomic, copy) NSArray * pictures;

@property (nonatomic, copy) NSString * group_name;//": "双十一最佳搭配，超省组合",//优惠组合名称
@property (nonatomic, copy) NSString * group_price;//": "98.80",//优惠组合价格

@property (nonatomic, copy) NSString * goods_price;//": "0"//商品总价、
//商品
@property (nonatomic, copy) NSArray * goods;
@property (nonatomic, copy) NSString * val_isno;//@""未选中 @"1"选中 @"2"无库存



@property (nonatomic, assign) BOOL RBtn_BOOL;


- (void)SgiftDetailModelSuccess:(SgiftDetailModelSuccessBlock)success andFailure:(SgiftDetailModelFailureBlock)failure;
@end
