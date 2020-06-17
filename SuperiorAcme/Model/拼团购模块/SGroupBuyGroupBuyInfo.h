//
//  SGroupBuyGroupBuyInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyGroupBuyInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyGroupBuyInfoFailureBlock) (NSError * error);

@interface SGroupBuyGroupBuyInfo : NSObject
@property (nonatomic, copy) NSString * group_buy_id;//团购id
@property (nonatomic, copy) NSString * p;//

@property (nonatomic, copy) NSString * buy_status;//0是已下架商品 1是上架商品
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * data;
@property (nonatomic, copy) NSString * remarks;//": "本品由得一蜂业旗舰店从境内发货，并提供下单后2小时内发货。"   //注释内容
@property (nonatomic, copy) NSString * msg_tip;//消息提醒数, //在会员登录情况下才有
@property (nonatomic, copy) NSString * is_collect;//"是否收藏", //在会员登录情况下查看
@property (nonatomic, copy) NSString * cart_num;// "购物车数量", //在会员登录情况下查看
@property (nonatomic, copy) NSString * group_price;//"团购价",
@property (nonatomic, copy) NSString * one_price;//"单买价"
@property (nonatomic, copy) NSString * total;//"已团件数"
@property (nonatomic, copy) NSString * share_url;//": "http://wjyp.txunda.com",//分享链接
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_content;//": "分享内容"
@property (nonatomic, copy) NSString * price_desc;//": "1.无忧价：无忧价格说明。\r\n2.优享价：优享价说明\r\n3.折扣：折扣说明。\r\n4.异常问题：异常问题说明",//价格说明
@property (nonatomic, copy) NSString * vouchers_desc;//代金券说明
@property (nonatomic, copy) NSArray * easemob_account;
@property (nonatomic, copy) NSString * hx;//": "151237607243994",         //商家客服账号
@property (nonatomic, copy) NSString * nickname;//": "无界新人",            //商家客服昵称
@property (nonatomic, copy) NSString * head_pic;//": ""                         //商家客服账号头像
@property (nonatomic, copy) NSString * group_type;//拼单购 商品类型  1：体验  2：拼单

@property (nonatomic, strong) SGroupBuyGroupBuyInfo * goodsInfo;
@property (nonatomic, copy) NSString * goods_id;//"商品id ",
@property (nonatomic, copy) NSString * product_id;//    商品属性id （特殊商品时需传）
@property (nonatomic, copy) NSString * cate_id;//": "商品三级分类id",
@property (nonatomic, copy) NSString * two_cate_name;//": "休闲食品",//二级分类名称
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;// "售价",
@property (nonatomic, copy) NSString * integral;// "赠送积分",
@property (nonatomic, copy) NSString * goods_desc;//"商品图文详情",//HTML格式
@property (nonatomic, copy) NSString * goods_brief;//"商品简介",
@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"是否属于票券区",//大于 0 表示属于票券区
@property (nonatomic, copy) NSString * country_id;//"国家ID",// 0表示中国
@property (nonatomic, copy) NSString * country_logo;//国家logo
@property (nonatomic, copy) NSString * country_desc;//"商品进口国家描述",//如：越南进口，本地发货
@property (nonatomic, copy) NSString * country_tax;//"进口税",
@property (nonatomic, copy) NSString * mall_status;//":"1有库存 0无库存";
@property (nonatomic, copy) NSString * ticket_buy_discount;//"商品享受购物券折扣"
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
/*
 *富文本属性,用于加载html文件
 */
@property (nonatomic, copy) NSAttributedString * attrDesc;

@property (nonatomic, strong) SGroupBuyGroupBuyInfo * mInfo;
//@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
//@property (nonatomic, copy) NSString * easemob_account;//"商家环信账号",
@property (nonatomic, copy) NSString * level;//"店铺等级",
@property (nonatomic, copy) NSString * logo;//"店铺logo",
@property (nonatomic, copy) NSString * view_num;//"关注人数"
@property (nonatomic, copy) NSString * all_goods;//"宝贝总数",
@property (nonatomic, copy) NSString * goods_score;//"宝贝评分",
@property (nonatomic, copy) NSString * merchant_score;//"卖家评分",
@property (nonatomic, copy) NSString * shipping_score;//"物流评分"
@property (nonatomic, copy) NSString * merchant_easemob_account;//": "150582059257251",//商家客服账号
@property (nonatomic, copy) NSString * merchant_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-19/59c0ff9493ec1.png",//商家客服头像
@property (nonatomic, copy) NSString * merchant_nickname;//": "hi po n",//客服昵称

//店铺优惠活动
@property (nonatomic, copy) NSArray * promotion;
@property (nonatomic, copy) NSString * title;//"优惠活动名称",
@property (nonatomic, copy) NSString * promotion_id;//"优惠id",
//@property (nonatomic, copy) NSString * type;//"类型" //1.满减 2满折

//优惠券列表
@property (nonatomic, copy) NSArray * ticketList;
@property (nonatomic, copy) NSString * ticket_id;//"优惠券ID",
@property (nonatomic, copy) NSString * ticket_name;// "优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//"优惠券详情",
@property (nonatomic, copy) NSString * ticket_type;//"优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//"面额", //满减=>金额 满折=>折扣 满赠=>商品id


/*
 *添加优惠券描述属性
 */
@property (nonatomic, copy) NSString * value_replace;//优惠券描述

@property (nonatomic, copy) NSString * condition;//"满足条件",
@property (nonatomic, copy) NSString * start_time;//"开始时间",

/*
 *团购的倒计时结束时间和延迟时间
 */
@property (nonatomic, copy) NSString * end_time;//"结束时间""截止时间"
@property (nonatomic, copy) NSString * end_true_time;//"延迟后截止时间（若无延迟，此时间等于截止时间）"
@property (nonatomic, copy) NSString * sys_time;//"系统参照时间"


@property (nonatomic, copy) NSString * get_receive;//": "0"//0未领取 1已领取


//产品规格列表
@property (nonatomic, copy) NSArray * goods_common_attr;
@property (nonatomic, copy) NSArray * list;
//@property (nonatomic, copy) NSString * id;//"规格编号",
//@property (nonatomic, copy) NSString * attr_name;//"规格名称",
//@property (nonatomic, copy) NSString * attr_value;//"规格值"

//商品属性
@property (nonatomic, copy) NSArray * goodsAttr;
@property (nonatomic, copy) NSString * id;//"id",
@property (nonatomic, copy) NSString * aid;//"属性ID",
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

//商品属性列表
@property (nonatomic, copy) NSArray * goods_attr;
//@property (nonatomic, copy) NSString * attr_name;//": "尺寸",//属性名称
@property (nonatomic, copy) NSArray * attr_list;
//@property (nonatomic, copy) NSString * id;//": "54",
@property (nonatomic, copy) NSString * goods_attr_id;//": "697",//商品属性值id
//@property (nonatomic, copy) NSString * attr_name;//": "尺寸", //属性名
//@property (nonatomic, copy) NSString * attr_value;//": "M",   //属性值
//@property (nonatomic, copy) NSString * attr_price;//": "20.00"//属性附加价格
@property (nonatomic, assign) BOOL goods_attr_BOOL;//是否选中

//货品
@property (nonatomic, copy) NSArray * product;
//@property (nonatomic, copy) NSString * id;//"75",
//@property (nonatomic, copy) NSString * goods_id;//"12",
@property (nonatomic, copy) NSString * goods_attr_str;//"属性组合",
@property (nonatomic, copy) NSString * product_sn;//"货品号",
@property (nonatomic, copy) NSString * product_number;//"货品库存"

@property (nonatomic, strong) SGroupBuyGroupBuyInfo * comment;
//@property (nonatomic, copy) NSString * total;//"1"
//评论主体
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * body;
@property (nonatomic, copy) NSString * comment_id;//"评论ID",
//@property (nonatomic, copy) NSString * goods_id;//"商品ID",
//@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * user_id;//"用户ID",
//@property (nonatomic, copy) NSString * nickname;//"用户昵称",
@property (nonatomic, copy) NSString * content;//"评论内容",
@property (nonatomic, copy) NSString * all_star;// "评论星级",
//@property (nonatomic, copy) NSString * product_id;//"货品ID",
@property (nonatomic, copy) NSString * order_goods_id;//"1",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * user_head_pic;// "用户头像",
@property (nonatomic, copy) NSString * good_attr;//"所评价商品属性",
//@property (nonatomic, copy) NSString * goods_num;//"所买数量",
//@property (nonatomic, copy) NSString * shop_price;//"售价",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * order_type;// "订单类型" ////0普通订单 1团购订单 2无界预购 3竞拍汇 4积分夺宝 5无界商店 6汽车购 7房产购 8线下商城
//评论图片列表
@property (nonatomic, copy) NSArray * pictures;
//@property (nonatomic, copy) NSString * path;//"图片路径"

@property (nonatomic, copy) NSArray * group;
//@property (nonatomic, copy) NSString * id;//"团购ID",
//@property (nonatomic, copy) NSString * group_buy_id;//"组团ID",
//@property (nonatomic, copy) NSString * start_time;//"开始时间",
@property (nonatomic, copy) NSString * status;//"状态", //0待成团  1已成团 2未成团
@property (nonatomic, copy) NSString * group_num;//"需参团人数",
@property (nonatomic, copy) NSString * diff;//"参团信息" //"还差1人" ,"团已满"
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * head_user;
//@property (nonatomic, copy) NSString * head_pic;//"头像",
//@property (nonatomic, copy) NSString * nickname;//"昵称"


@property (nonatomic, copy) NSString * diff_num;//当前体验拼单的商品,是否已团满
/*
 *活动规则的详情
 */
@property (nonatomic, copy) NSString * max_num;
@property (nonatomic, copy) NSString * award_num;
@property (nonatomic, copy) NSString * return_num;
@property (nonatomic, copy) NSArray * memo;
/*
 *是否参加过体验拼单活动
 */
@property (nonatomic, copy) NSString * is_member;

//商品服务信息
@property (nonatomic, copy) NSArray * goods_server;
//@property (nonatomic, copy) NSString * id;//": "2",
@property (nonatomic, copy) NSString * server_name;//": "七天无理由退换货",//服务标题
//@property (nonatomic, copy) NSString * desc;//": "自实际收货日期的次日起七天内，商品完好无损，可进行无理由退换货，产生多余运费由买家承担。",//服务描述
//@property (nonatomic, copy) NSString * icon;//": "服务图标"

//优惠组合
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * cheap_group;
@property (nonatomic, copy) NSString * group_name;//": "双十一最佳搭配，超省组合",//优惠组合名称
//@property (nonatomic, copy) NSString * group_price;//": "98.80",//优惠组合价格
//@property (nonatomic, copy) NSString * integral;//": "0",//赠送积分
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "10%",//最多可使用多少代金券
@property (nonatomic, copy) NSString * goods_price;//": "0"//商品总价、
//商品
@property (nonatomic, copy) NSArray * goods;
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * shop_price;//": "商品价格"

//猜你喜欢
@property (nonatomic, copy) NSArray * guess_goods_list;
//@property (nonatomic, copy) NSString * goods_id;//": "商品id",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "是否是折扣商品",//0 不是 大于0就是
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率",//在是折扣商品时才会有
//@property (nonatomic, copy) NSString * country_id;//": "国家id",
//@property (nonatomic, copy) NSString * country_logo;//": "国家logo"
//@property (nonatomic, copy) NSString * shop_price;//": "售价",
//@property (nonatomic, copy) NSString * market_price;//": "市场价",
//@property (nonatomic, copy) NSString * sell_num;//": "卖出数量",

//属性列表
@property (nonatomic, copy) NSArray * first_list;
@property (nonatomic, copy) NSString * first_list_name;//": "颜色",        // 属性名
@property (nonatomic, copy) NSArray * first_list_val;
@property (nonatomic, copy) NSString * val;//": "红色"             // 属性值
@property (nonatomic, copy) NSString * val_isno;//@""未选中 @"1"选中 @"2"无库存

//属性比对列表
@property (nonatomic, copy) NSArray * first_val;
//@property (nonatomic, copy) NSString * id;//": "118",                    // 属性id
//@property (nonatomic, copy) NSString * shop_price;//": "777.00",           // 售价
//@property (nonatomic, copy) NSString * goods_num;//": "777",              //库存
//@property (nonatomic, copy) NSString * goods_img;//": "",            //商品图
@property (nonatomic, copy) NSString * arrtValue;//": "红+L+工装"        // 组合属性


/*
 * 添加多少人在拼团
 */
@property (nonatomic, copy) NSString * group_count;

/*
 *普通商品返还的积分
 */
@property (nonatomic, copy) NSString * p_integral;

@property (nonatomic, copy) NSString * a_id;////体验品活动id，非体验品拼单时此id为0

/*
 *添加拼单购商品,查看分类跳转
 */
@property (nonatomic, copy) NSString * pcate_id;//": "商品三级分类id",
@property (nonatomic, copy) NSString * top_cate_id;//顶级分类id

/*
 *店铺的联系方式
 */
@property (nonatomic, copy) NSString * merchant_phone;//店铺电话

@property (nonatomic, assign) CGFloat CellHeight;

/*
 *动态消息
 */
@property (nonatomic, strong) NSArray * event_msg;
@property (nonatomic, copy) NSString * nick_name;
@property (nonatomic, copy) NSString * msg;


//手气排行
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * group_rank;
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * user_info;
@property (nonatomic, strong) NSArray * rank_list;
@property (nonatomic, copy) NSString * rank;
//@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * user_name;
//@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * user_count;


@property (nonatomic, assign) BOOL RBtn_BOOL;
- (void)sGroupBuyGroupBuyInfoSuccess:(SGroupBuyGroupBuyInfoSuccessBlock)success andFailure:(SGroupBuyGroupBuyInfoFailureBlock)failure;
@end
