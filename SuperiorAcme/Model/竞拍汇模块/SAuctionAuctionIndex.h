//
//  SAuctionAuctionIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionAuctionIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SAuctionAuctionIndexFailureBlock) (NSError * error);

@interface SAuctionAuctionIndex : NSObject
@property (nonatomic, copy) NSString * next;//固定值 1 当next为1时获取的是拍卖预展
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SAuctionAuctionIndex * data;

@property (nonatomic, strong) SAuctionAuctionIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告id",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"广告描述",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * auction_list;
@property (nonatomic, copy) NSString * auction_id;//"拍卖id",
@property (nonatomic, copy) NSString * start_time;//"拍卖开始时间",
@property (nonatomic, copy) NSString * end_time;//"结束时间",
@property (nonatomic, copy) NSString * start_price;//"起拍价",
@property (nonatomic, copy) NSString * market_price;//"原价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家id",
@property (nonatomic, copy) NSString * country_logo;//'国家logo'
@property (nonatomic, copy) NSString * ticket_buy_id;//"折扣id"
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"
@property (nonatomic, copy) NSString * is_remind;//"1",//是否设置提醒 0未提醒 1提醒

- (void)sAuctionAuctionIndexSuccess:(SAuctionAuctionIndexSuccessBlock)success andFailure:(SAuctionAuctionIndexFailureBlock)failure;
@end
