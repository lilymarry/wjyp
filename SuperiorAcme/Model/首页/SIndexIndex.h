//
//  SIndexIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIndexIndexSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIndexIndexFailureBlock) (NSError * error);

@interface SIndexIndex : NSObject
@property (nonatomic, copy) NSString * lng;//经度
@property (nonatomic, copy) NSString * lat;//纬度
@property (nonatomic, copy) NSString * page_size;//纬度
@property (nonatomic, strong) SIndexIndex * data;
@property (nonatomic, copy) NSString * auto_update_status;//   0开启自动更新  1不开启自动更新
@property (nonatomic, copy) NSString * city_status;//": 0              // 是否填写个人资料所在地（0->否，1->是）
@property (nonatomic, copy) NSString * activity_status;//":"//首页活动是否开启  0不开启 1开启"
@property (nonatomic, copy) NSString * msg_tip;//"0",//消息提醒数

@property (nonatomic, copy) NSString * return_ticket;//奖励金额

//首页轮播列表
@property (nonatomic, copy) NSArray * index_banner;
@property (nonatomic, copy) NSString * ads_id;//": "广告id",
@property (nonatomic, copy) NSString * picture;//": "广告图片",
@property (nonatomic, copy) NSString * desc;//": "广告描述",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

//顶级导航列表
@property (nonatomic, copy) NSArray * top_nav;
@property (nonatomic, copy) NSString * cate_id;//": 0,
@property (nonatomic, copy) NSString * short_name;//": "推荐",
@property (nonatomic, copy) NSString * name;//": "推荐"

//头条列表
@property (nonatomic, copy) NSArray * headlines;
@property (nonatomic, copy) NSString * headlines_id;//": "头条id",
@property (nonatomic, copy) NSString * title;//": "头条标题"

//三个活动位图
@property (nonatomic, strong) SIndexIndex * three_img;
//品牌团
@property (nonatomic, strong) SIndexIndex * brand;
//中国质造
@property (nonatomic, strong) SIndexIndex * china;
//科技前沿
@property (nonatomic, strong) SIndexIndex * science;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"

//限量购
@property (nonatomic, strong) SIndexIndex * limit_buy;
@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * limit_buy_id;//": "限量购id",
@property (nonatomic, copy) NSString * limit_price;//": "限量购价格",
@property (nonatomic, copy) NSString * limit_store;//": "库存",
@property (nonatomic, copy) NSString * limit_num;//": "每人限购数量",
@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * sell_num;//": "已售",
@property (nonatomic, copy) NSString * market_price;//": "原价",
@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
@property (nonatomic, copy) NSString * country_id;//": "国家id",
@property (nonatomic, copy) NSString * ticket_buy_id;//": "票券id",
@property (nonatomic, copy) NSString * country_logo;//": "国家logo",
@property (nonatomic, copy) NSString * ticket_buy_discount;//": "可使用购物券折扣率"
@property (nonatomic, copy) NSString * end_time;//": "1504875600",//结束时间
@property (nonatomic, copy) NSString * start_time;//": "1504864800",//开始时间

/*
 *添加体验拼单商品提示
 */
//"group_type": "类型 1试用品拼单 2常规拼单",
@property (nonatomic, copy) NSString * group_type;//体验拼单

@property (nonatomic, strong) SIndexIndex * ticket_buy;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * goods_id;//": "商品id",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "是否是折扣商品",//0 不是 大于0就是
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率",//在是折扣商品时才会有
//@property (nonatomic, copy) NSString * country_id;//": "国家id",
//@property (nonatomic, copy) NSString * country_logo;//": "国家logo"
@property (nonatomic, copy) NSString * shop_price;//": "售价",
//@property (nonatomic, copy) NSString * market_price;//": "市场价",
//@property (nonatomic, copy) NSString * sell_num;//": "卖出数量",

@property (nonatomic, strong) SIndexIndex * pre_buy;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * pre_buy_id;//": "预购id",
@property (nonatomic, copy) NSString * deposit;//": "定金",
@property (nonatomic, copy) NSString * pre_store;//": "预购库存",
@property (nonatomic, copy) NSString * success_max_num;//满多少开始
//@property (nonatomic, copy) NSString * sell_num;//": "销量",
//@property (nonatomic, copy) NSString * start_time;//": "开始时间",
//@property (nonatomic, copy) NSString * end_time;//": "结束时间",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * market_price;//:'市场价'
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * country_id;//": "国家ID",
//@property (nonatomic, copy) NSString * country_logo;//":国家logo
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "票券id",
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率"

@property (nonatomic, strong) SIndexIndex * country;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
//@property (nonatomic, copy) NSString * goods_id;//": "商品id",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * market_price;//": "市场价",
//@property (nonatomic, copy) NSString * shop_price;//": "销售价",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * country_id;//": "国家ID",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "票券ID",
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "票券折扣率",  //当票券id大于0时出现
//@property (nonatomic, copy) NSString * country_logo;//": "国家logo"

@property (nonatomic, strong) SIndexIndex * auction;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"

//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * auction_id;//": "拍卖id",
//@property (nonatomic, copy) NSString * start_time;//": "拍卖开始时间",
//@property (nonatomic, copy) NSString * end_time;//": "结束时间",
@property (nonatomic, copy) NSString * start_price;//": "起拍价",
//@property (nonatomic, copy) NSString * market_price;//": "原价",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * country_id;//": "国家id",
//@property (nonatomic, copy) NSString * country_logo;//":'国家logo'
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "折扣id"
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率"

@property (nonatomic, strong) SIndexIndex * one_buy;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * one_buy_id;//": "一元购ID",
@property (nonatomic, copy) NSString * person_num;//": "需参与人数",
@property (nonatomic, copy) NSString * add_num;//": "已参与人数",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * country_id;//": "国家ID",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "抵扣券id",
@property (nonatomic, copy) NSString * diff_num;//": 还剩是多少人数,
//@property (nonatomic, copy) NSString * country_logo;//": "国家logo"
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "可用抵扣"

@property (nonatomic, strong) SIndexIndex * car;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * car_id;//": "汽车id",
@property (nonatomic, copy) NSString * car_name;//": "汽车名称",
@property (nonatomic, copy) NSString * car_img;//": "汽车图片",
//@property (nonatomic, copy) NSString * lng;//": "经度",
//@property (nonatomic, copy) NSString * lat;//": "纬度",
@property (nonatomic, copy) NSString * pre_money;//": "代金券",
@property (nonatomic, copy) NSString * true_pre_money;//": "可抵车款",
@property (nonatomic, copy) NSString * all_price;//": "车全价",
//@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * distance;//": "距离",
@property (nonatomic, copy) NSString * ticket_discount;//": "购物券比例",
@property (nonatomic, copy) NSString * brand_id;//": "品牌id",
@property (nonatomic, copy) NSString * brand_logo;//": "品牌logo"

@property (nonatomic, strong) SIndexIndex * house;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * house_id;//": "楼盘id",
@property (nonatomic, copy) NSString * house_name;//": "楼盘名称",
@property (nonatomic, copy) NSString * house_img;//": "封面图片",
//@property (nonatomic, copy) NSString * lng;//": "经度",
//@property (nonatomic, copy) NSString * lat;//": "纬度",
@property (nonatomic, copy) NSString * min_price;//": "最低房价",
@property (nonatomic, copy) NSString * max_price;//": "最高房价",
@property (nonatomic, copy) NSString * now_num;//": "在售房源",
@property (nonatomic, copy) NSString * developer;//": "开发商",
//@property (nonatomic, copy) NSString * distance;//": "距离"

@property (nonatomic, strong) SIndexIndex * group_buy;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "广告id",
//@property (nonatomic, copy) NSString * picture;//": "广告图片",
//@property (nonatomic, copy) NSString * desc;//": "广告描述",
//@property (nonatomic, copy) NSString * href;//": "广告链接"
//@property (nonatomic, copy) NSArray * goodsList;
@property (nonatomic, copy) NSString * group_buy_id;//": "团购ID",
@property (nonatomic, copy) NSString * group_price;//": "团购价",
//@property (nonatomic, copy) NSString * shop_price;//"单买价"
@property (nonatomic, copy) NSString * group_num;//": "团购所需人数",
@property (nonatomic, copy) NSString * total;//": "已被团数量",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片g",
//@property (nonatomic, copy) NSString * country_id;//": "国家ID",
//@property (nonatomic, copy) NSString * ticket_buy_id;//": "抵扣券id",
//@property (nonatomic, copy) NSString * country_logo;//": "国家图片",
//@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率"
 //两个参团人头像
@property (nonatomic, copy) NSArray * append_person;
@property (nonatomic, copy) NSString * log_id;//": "团编号",
@property (nonatomic, copy) NSString * user_id;//": "开团者id",
@property (nonatomic, copy) NSString * head_pic;//": "开团者头像"

@property (nonatomic, copy) NSString * a_id;//手气拼团 id

//爆款专区
@property (nonatomic, strong) SIndexIndex * hot_goods;

@property (nonatomic, copy) NSString * position;


@property (nonatomic, copy) NSString * fresh_time;//": "广告图片",

@property (nonatomic, copy) NSString * discount;//": "广告链接"

@property (nonatomic, copy) NSString * yellow_discount;//": "广告id",
@property (nonatomic, copy) NSString * blue_discount;//": "广告图片",

//省钱购
@property (nonatomic, strong) SIndexIndex * shengqiangou;
//@property (nonatomic, strong) SIndexIndex * ads;
//@property (nonatomic, copy) NSString *ads_id;
//@property (nonatomic, copy) NSString *desc ;
//@property (nonatomic, copy) NSString *goods_id;
//@property (nonatomic, copy) NSString *href ;
//@property (nonatomic, copy) NSString *merchant_id;
//@property (nonatomic, copy) NSString *picture ;
//@property (nonatomic, copy) NSString *position ;
@property (nonatomic, strong) NSArray * goods_list;
@property (nonatomic, copy) NSString * biaoshi;//" = "http://item.taobao.com/item.htm?id=584876831488";
@property (nonatomic, copy) NSString * item_url;// = "\U8eab\U7f8e\U62c9\U65d7\U8230\U5e97";
@property (nonatomic, copy) NSString * pict_url;//" = 584876831488;
@property (nonatomic, copy) NSString * reserve_price;//" = "https://img.alicdn.com/tfscom/i2/3306149389/O1CN01Bu4fv62JEDAPZL7zz_!!0-item_pic.jpg";
//@property (nonatomic, copy) NSString * title;// = "\U5e7f\U4e1c \U5e7f\U5dde";
//@property (nonatomic, copy) NSString * reserve_price;//" = "275.00";
@property (nonatomic, copy) NSString * volume;//" = 3306149389;
@property (nonatomic, copy) NSString *zk_final_price;//" =                 {




- (void)sIndexIndexSuccess:(SIndexIndexSuccessBlock)success andFailure:(SIndexIndexFailureBlock)failure;
@end
