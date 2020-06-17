//
//  SAuctionAuctionInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionAuctionInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAuctionAuctionInfoFailureBlock) (NSError * error);

@interface SAuctionAuctionInfo : NSObject
@property (nonatomic, copy) NSString * auction_id;//拍卖id
@property (nonatomic, copy) NSString * p;

@property (nonatomic, strong) SAuctionAuctionInfo * data;
@property (nonatomic, copy) NSString * cart_num;//": "购物车数量", //在会员登录情况下查看
@property (nonatomic, copy) NSString * msg_tip;//": 消息提醒数, //在会员登录情况下才有
@property (nonatomic, copy) NSString * is_collect;//": "是否收藏", //在会员登录情况下查看
@property (nonatomic, copy) NSString * share_url;//": "http://wjyp.txunda.com",//分享链接
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_content;//": "分享内容"
@property (nonatomic, copy) NSString * vouchers_desc;//代金券说明


@property (nonatomic, copy) NSString * price_desc;//": "1.无忧价：无忧价格说明。\r\n2.优享价：优享价说明\r\n3.折扣：折扣说明。\r\n4.异常问题：异常问题说明",//价格说明
@property (nonatomic, copy) NSString * mybid;//": 我的出价id, //登录情况下才有

@property (nonatomic, strong) SAuctionAuctionInfo * goodsInfo;
@property (nonatomic, copy) NSString * goods_id;//": "商品id ",
@property (nonatomic, copy) NSString * cate_id;//": "商品三级分类id",
@property (nonatomic, copy) NSString * two_cate_name;//": "休闲食品",//二级分类名称
@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * market_price;//": "市场价",
@property (nonatomic, copy) NSString * shop_price;//": "售价",
@property (nonatomic, copy) NSString * integral;//": "赠送积分",
@property (nonatomic, copy) NSString * goods_desc;//": "商品图文详情",//HTML格式
@property (nonatomic, copy) NSString * goods_brief;//": "商品简介",
@property (nonatomic, copy) NSString * merchant_id;//": "店铺id",
@property (nonatomic, copy) NSString * sell_num;//": "销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//": "是否属于票券区",//大于 0 表示属于票券区
@property (nonatomic, copy) NSString * country_id;//": "国家ID",// 0表示中国
@property (nonatomic, copy) NSString * country_logo;//":国家logo
@property (nonatomic, copy) NSString * country_desc;//": "商品进口国家描述",//如：越南进口，本地发货
@property (nonatomic, copy) NSString * country_tax;//": "进口税",
@property (nonatomic, copy) NSString * is_new_goods;//": "1",//是否是新品  0不是 1是
@property (nonatomic, copy) NSString * is_new_goods_desc;//": "此件商品是旧货八五成新",//新品描述
@property (nonatomic, copy) NSString * is_end;//": "0",//是否临期 0未临期 1临期
@property (nonatomic, copy) NSString * is_end_desc;//": "此商品属于临期商品，商品保质期到期日为2017-20-30",//临期描述
@property (nonatomic, copy) NSString * goods_num;//": "库存"，
@property (nonatomic, copy) NSString * package_list;//": "包装清单",
@property (nonatomic, copy) NSString * after_sale_service;//": "售后服务",
@property (nonatomic, copy) NSString * integral_buy_id;//": "积分兑换id，如果不为0 显示此商品可使用xxx积分兑换，如想使用积分兑换，亲到无界商店中进行兑换"。xxx使用user_integral字段
@property (nonatomic, copy) NSString * use_integral;//": "12",//积分兑换需要多少积分
@property (nonatomic, copy) NSString * wy_price;//": "19.50",//无忧价
@property (nonatomic, copy) NSString * yx_price;//": "19.00",//优享价
@property (nonatomic, copy) NSString * auct_name;//": "拍卖名称",
@property (nonatomic, copy) NSString * auct_desc;//": "拍卖描述",
@property (nonatomic, copy) NSString * start_price;//": "起拍价",
@property (nonatomic, copy) NSString * now_price;//": "当前价",
@property (nonatomic, copy) NSString * add_price;//": "加价幅度",
@property (nonatomic, copy) NSString * leave_price;//": "保留价",
@property (nonatomic, copy) NSString * delay_time;//": "延时周期",
@property (nonatomic, copy) NSString * base_money;//": "保证金",
@property (nonatomic, copy) NSString * start_time;//": "1510675200",//开始时间
@property (nonatomic, copy) NSString * end_time;//": "1510761599",//结束时间
@property (nonatomic, copy) NSString * click_num;//": "4",//围观
@property (nonatomic, copy) NSString * apply_num;//": "0",//报名人数
@property (nonatomic, copy) NSString * remind_num;//": "0",提醒数
@property (nonatomic, copy) NSString * is_remind;//": "0"//是否设置提醒 0没有1已设置
@property (nonatomic, copy) NSString * stage_status;//": "正在进行 2017-11-15结束",//拍卖进度提示
//商品正在进行的活动
@property (nonatomic, copy) NSArray * goods_active;
@property (nonatomic, copy) NSString * act_type;//": "1",//1免费抽奖，2无界预购，3拍卖，4限量购，5拼单购
@property (nonatomic, copy) NSString * act_id;//": "2",//id
@property (nonatomic, copy) NSString * act_desc;//": "本商品正在进行免费抽奖活动"//描述
//代金券
@property (nonatomic, copy) NSArray * dj_ticket;
@property (nonatomic, copy) NSString * type;//": "1"//类型 1红券  2黄券 3蓝券
@property (nonatomic, copy) NSString * discount_desc;//": "本产品最多可以使用30%红券抵扣现金"，//描述

//价格说明
@property (nonatomic, copy) NSArray * goods_price_desc;
@property (nonatomic, copy) NSString * icon;//": "http://wjyp.txunda.com/Uploads/GoodsPriceDesc/2017-11-13/5a092c91a8bce.png",//图标
@property (nonatomic, copy) NSString * price_name;//": "无忧价",//价格名称
@property (nonatomic, copy) NSString * desc;//": "这是一段无忧价的价格说明"//价格说明文字

@property (nonatomic, strong) SAuctionAuctionInfo * mInfo;
//@property (nonatomic, copy) NSString * merchant_id;//": "店铺id",
@property (nonatomic, copy) NSString * merchant_name;//": "店铺名称",
@property (nonatomic, copy) NSString * level;//": "店铺等级",
@property (nonatomic, copy) NSString * logo;//": "店铺logo",
@property (nonatomic, copy) NSString * view_num;//";: "关注人数"
@property (nonatomic, copy) NSString * easemob_account;//": "商家环信账号",
@property (nonatomic, copy) NSString * all_goods;//": "7",
@property (nonatomic, copy) NSString * goods_score;//": "宝贝评分",
@property (nonatomic, copy) NSString * merchant_score;//": "卖家评分",
@property (nonatomic, copy) NSString * shipping_score;//": "物流评分"
@property (nonatomic, copy) NSString * merchant_easemob_account;//": "150582059257251",//商家客服账号
@property (nonatomic, copy) NSString * merchant_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-19/59c0ff9493ec1.png",//商家客服头像
@property (nonatomic, copy) NSString * merchant_nickname;//": "hi po n",//客服昵称

//店铺优惠活动
@property (nonatomic, copy) NSArray * promotion;
@property (nonatomic, copy) NSString * title;//": "优惠活动名称",
@property (nonatomic, copy) NSString * promotion_id;//": "优惠id",
//@property (nonatomic, copy) NSString * type;//": "类型" //1.满减 2满折

//优惠券列表
@property (nonatomic, copy) NSArray * ticketList;
@property (nonatomic, copy) NSString * ticket_id;//": "优惠券ID",
@property (nonatomic, copy) NSString * ticket_name;//": "优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//": "优惠券详情",
@property (nonatomic, copy) NSString * ticket_type;//": "优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//": "面额", //满减=>金额 满折=>折扣 满赠=>商品id
@property (nonatomic, copy) NSString * condition;//": "满足条件",
//@property (nonatomic, copy) NSString * start_time;//": "开始时间",
//@property (nonatomic, copy) NSString * end_time;//": "结束时间"

//产品规格列表
@property (nonatomic, copy) NSArray * goods_common_attr;
@property (nonatomic, copy) NSString * id;//": "规格编号",
@property (nonatomic, copy) NSString * attr_name;//": "规格名称",
@property (nonatomic, copy) NSString * attr_value;//": "规格值"

//商品属性列表
@property (nonatomic, copy) NSArray * goods_attr;
//@property (nonatomic, copy) NSString * attr_name;//": "尺寸",//属性名称
//属性列表
@property (nonatomic, copy) NSArray * attr_list;
//@property (nonatomic, copy) NSString * id;//": "54",
@property (nonatomic, copy) NSString * goods_attr_id;//": "697",//商品属性值id
//@property (nonatomic, copy) NSString * attr_name;//": "尺寸", //属性名
//@property (nonatomic, copy) NSString * attr_value;//": "M",   //属性值
@property (nonatomic, copy) NSString * attr_price;//": "20.00"//属性附加价格

//商品图片轮播图列表
@property (nonatomic, copy) NSArray * goods_banner;
@property (nonatomic, copy) NSString * path;//": "轮播图"

@property (nonatomic, strong) SAuctionAuctionInfo * comment;
@property (nonatomic, copy) NSString * total;//": "总评论数"
@property (nonatomic, strong) SAuctionAuctionInfo * body;
@property (nonatomic, copy) NSString * comment_id;//": "评论ID",
//@property (nonatomic, copy) NSString * goods_id;//": "商品ID",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * user_id;//": "用户ID",
@property (nonatomic, copy) NSString * nickname;//": "用户昵称",
@property (nonatomic, copy) NSString * content;//": "评论内容",
@property (nonatomic, copy) NSString * all_star;//": "评论星级",
@property (nonatomic, copy) NSString * product_id;//": "货品ID",
@property (nonatomic, copy) NSString * order_goods_id;//": "1",
@property (nonatomic, copy) NSString * create_time;//": "创建时间",
@property (nonatomic, copy) NSString * user_head_pic;//": "用户头像",
@property (nonatomic, copy) NSString * good_attr;//": "所评价商品属性",
//@property (nonatomic, copy) NSString * goods_num;//": "所买数量",
//@property (nonatomic, copy) NSString * shop_price;//": "售价",
@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
@property (nonatomic, copy) NSString * order_type;//": "订单类型" ////0普通订单 1团购订单 2无界预购 3竞拍汇 4一元夺宝 5无界商店 6汽车购 7房产购 8线下商城
//评论图片列表
@property (nonatomic, copy) NSArray * pictures;
//@property (nonatomic, copy) NSString * path;//": "图片路径"

//商品服务信息
@property (nonatomic, copy) NSArray * goods_server;
//@property (nonatomic, copy) NSString * id;//": "2",
@property (nonatomic, copy) NSString * server_name;//": "七天无理由退换货",//服务标题
//@property (nonatomic, copy) NSString * desc;//": "自实际收货日期的次日起七天内，商品完好无损，可进行无理由退换货，产生多余运费由买家承担。",//服务描述
//@property (nonatomic, copy) NSString * icon;//": "服务图标"

@property (nonatomic, copy) NSArray * auction_log;
@property (nonatomic, copy) NSString * log_id;//": "出价id",
@property (nonatomic, copy) NSString * bid_price;//": "出价",
@property (nonatomic, copy) NSString * bid_time;//": "出价时间",
@property (nonatomic, copy) NSString * bid_time_format;//"://年-月-日 时:分
//@property (nonatomic, copy) NSString * nickname;//": "昵称"

//猜你喜欢
@property (nonatomic, copy) NSArray * guess_goods_list;
//@property (nonatomic, copy) NSString * goods_id;//": "商品id",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "是否是折扣商品",//0 不是 大于0就是
@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率",//在是折扣商品时才会有
//@property (nonatomic, copy) NSString * country_id;//": "国家id",
//@property (nonatomic, copy) NSString * country_logo;//": "国家logo"
//@property (nonatomic, copy) NSString * shop_price;//": "售价",
//@property (nonatomic, copy) NSString * market_price;//": "市场价",
//@property (nonatomic, copy) NSString * sell_num;//": "卖出数量",


- (void)sAuctionAuctionInfoSuccess:(SAuctionAuctionInfoSuccessBlock)success andFailure:(SAuctionAuctionInfoFailureBlock)failure;
@end
