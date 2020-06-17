//
//  SPreBuyThreeList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreBuyThreeListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SPreBuyThreeListFailureBlock) (NSError * error);

@interface SPreBuyThreeList : NSObject
@property (nonatomic, copy) NSString * two_cate_id;//二级分类id
@property (nonatomic, copy) NSString * three_cate_id;//三级分类id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SPreBuyThreeList * data;

//三级分类列表
@property (nonatomic, copy) NSArray * three_cate_list;
//@property (nonatomic, copy) NSString * three_cate_id;//"三级分类id",
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;//"分类名称"

@property (nonatomic, copy) NSArray * pre_buy_list;
@property (nonatomic, copy) NSString * pre_buy_id;//"预购id",
@property (nonatomic, copy) NSString * deposit;//"定金",
@property (nonatomic, copy) NSString * pre_store;//"预购库存",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * start_time;// "开始时间",
@property (nonatomic, copy) NSString * end_time;//"结束时间",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * market_price;//'市场价'
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * country_logo;//country_logo
@property (nonatomic, copy) NSString * ticket_buy_id;//"票券id",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"
@property (nonatomic, copy) NSString * success_max_num;

- (void)sPreBuyThreeListSuccess:(SPreBuyThreeListSuccessBlock)success andFailure:(SPreBuyThreeListFailureBlock)failure;
@end
