//
//  SUserCollectCollectList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserCollectCollectListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserCollectCollectListFailureBlock) (NSError * error);

@interface SUserCollectCollectList : NSObject
@property (nonatomic, copy) NSString * type;//收藏类型 1商品（默认） 2店铺 3书院
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, assign) BOOL choice_isno;

/**
  * 商品类型
  */
@property (nonatomic, copy) NSString * collect_id;//"收藏编号ID",
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"销售价",
@property (nonatomic, copy) NSString * integral;//"积分"
@property (nonatomic, copy) NSString * ticket_buy_id;//": "0",
@property (nonatomic, copy) NSString * country_id;//": "85",
@property (nonatomic, copy) NSString * sell_num;//": "销量",
@property (nonatomic, copy) NSString * country_logo;//": "国家logo",
@property (nonatomic, copy) NSString * ticket_buy_discount;//": "折扣率"

/**
 * 收藏店铺
 */
//@property (nonatomic, copy) NSString * collect_id;//"收藏编号",
@property (nonatomic, copy) NSString * mid;//"店铺ID",

@property (nonatomic, strong) SUserCollectCollectList * merchantFace;
@property (nonatomic, strong) SUserCollectCollectList * merInfo;//店铺信息
@property (nonatomic, copy) NSString * merchant_id;//"店铺ID",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
@property (nonatomic, copy) NSString * merchant_desc;//"店铺描述",
@property (nonatomic, copy) NSString * score;//"评分",
@property (nonatomic, copy) NSString * logo;//"店铺Logo"
@property (nonatomic, copy) NSArray * goodsList;//三个封面商品
//@property (nonatomic, copy) NSString * goods_id;//"商品ID",
//@property (nonatomic, copy) NSString * goods_img;//"商品图片",
//@property (nonatomic, copy) NSString * shop_price;//"售价"

/**
 * 收藏文章
 */

//@property (nonatomic, copy) NSString * collect_id;//"收藏编号",
@property (nonatomic, copy) NSString * aid;// "文章id",
@property (nonatomic, copy) NSString * title;//"文章标题",
//@property (nonatomic, copy) NSString * logo;//"文章封面图",
@property (nonatomic, copy) NSString * collect_num;//"收藏数",
@property (nonatomic, copy) NSString * page_views;//"浏览量"

/*
 *   线下
 */

/**
 店铺ID
 */
@property (nonatomic, copy) NSString * s_id;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, assign) NSInteger user_id;
/**
 距离
 */
@property (nonatomic, copy) NSString * distance;
/**
 月消单
 */
@property (nonatomic, copy) NSString * months_order;

@property (nonatomic, copy) NSString * goods_num;


- (void)sUserCollectCollectListSuccess:(SUserCollectCollectListSuccessBlock)success andFailure:(SUserCollectCollectListFailureBlock)failure;
@end
