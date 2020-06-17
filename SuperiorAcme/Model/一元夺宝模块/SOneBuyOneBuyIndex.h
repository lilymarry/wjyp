//
//  SOneBuyOneBuyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOneBuyOneBuyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SOneBuyOneBuyIndexFailureBlock) (NSError * error);

@interface SOneBuyOneBuyIndex : NSObject
@property (nonatomic, copy) NSString * add_num;//排序参数 按照已经参与人数（进度）排序 1正序 2倒序
@property (nonatomic, copy) NSString * person_num;//排序参数 按照需参与人数排序 1正序 2倒序
@property (nonatomic, copy) NSString * integral;//排序参数 按照积分排序 1正序 2倒序
@property (nonatomic, copy) NSString * is_hot;//当is_hot 为1的时候 显示热门
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SOneBuyOneBuyIndex * data;

@property (nonatomic, copy) NSArray * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告id",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"图片描述",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

//头条列表
@property (nonatomic, copy) NSArray * news;
@property (nonatomic, copy) NSString * headlines_id;//"头条id",
@property (nonatomic, copy) NSString * title;//"头条标题"

//积分夺宝商品列表
@property (nonatomic, copy) NSArray * oneBuyList;
@property (nonatomic, copy) NSString * one_buy_id;//"一元购ID",
//@property (nonatomic, copy) NSString * person_num;//"需参与人数",
//@property (nonatomic, copy) NSString * add_num;//"已参与人数",
//@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * start_time;//": "开始时间",
@property (nonatomic, copy) NSString * end_time;//": "结束时间",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * ticket_buy_id;//"抵扣券id",
@property (nonatomic, copy) NSString * diff_num;//还剩是多少人数,
@property (nonatomic, copy) NSString * country_logo;//"国家logo"
@property (nonatomic, copy) NSString * ticket_buy_discount;// "可用抵扣"

@property (nonatomic, copy) NSArray * rules;
//@property (nonatomic, copy) NSString * title;//'规则标题',
@property (nonatomic, copy) NSString * content;//规则内容

- (void)sOneBuyOneBuyIndexSuccess:(SOneBuyOneBuyIndexSuccessBlock)success andFailure:(SOneBuyOneBuyIndexFailureBlock)failure;
@end
