//
//  STicketBuyTicketBuyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^STicketBuyTicketBuyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^STicketBuyTicketBuyIndexFailureBlock) (NSError * error);

@interface STicketBuyTicketBuyIndex : NSObject
@property (nonatomic, copy) NSString * cate_id;//分类ID可选 默认显示第一个顶级分类的推荐
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) STicketBuyTicketBuyIndex * data;

//顶级分类导航条
@property (nonatomic, copy) NSArray * top_nav;
//@property (nonatomic, copy) NSString * cate_id;//"3",
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;//"分类名称"

//二级分类列表
@property (nonatomic, copy) NSArray * two_cate_list;
@property (nonatomic, copy) NSString * two_cate_id;//"二级分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称"
@property (nonatomic, copy) NSString * cate_img;//"二级分类图标"

@property (nonatomic, strong) STicketBuyTicketBuyIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告ID",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"广告说明",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * ticket_buy_list;
@property (nonatomic, copy) NSString * goods_id;//"商品id",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * ticket_buy_id;//"是否是折扣商品",//0 不是 大于0就是
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率",//在是折扣商品时才会有
@property (nonatomic, copy) NSString * country_id;//"国家id",
@property (nonatomic, copy) NSString * country_logo;//"国家logo"
@property (nonatomic, copy) NSString * shop_price;//"售价",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * sell_num;//"卖出数量",
@property (nonatomic, copy) NSString * integral;//积分

- (void)sTicketBuyTicketBuyIndexSuccess:(STicketBuyTicketBuyIndexSuccessBlock)success andFailure:(STicketBuyTicketBuyIndexFailureBlock)failure;
@end
