//
//  SGoodsGroupGoodsList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsGroupGoodsListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGoodsGroupGoodsListFailureBlock) (NSError * error);

@interface SGoodsGroupGoodsList : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * cheap_group_id;//": "1",//搭配购id
@property (nonatomic, copy) NSString * group_name;//": "双十一最佳搭配，超省组合",//搭配购名称
@property (nonatomic, copy) NSString * group_price;//": "98.80",//搭配购价格
@property (nonatomic, copy) NSString * integral;//": "5.42",//积分
@property (nonatomic, copy) NSString * ticket_buy_discount;//": "10",//优惠券
@property (nonatomic, copy) NSString * goods_price;//": "28.9",//商品总价
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, assign) BOOL open_isno;
//商品列表
@property (nonatomic, copy) NSArray * goods;
//@property (nonatomic, copy) NSString * goods_id;//": "17",//商品id
@property (nonatomic, copy) NSString * goods_name;//": "小麻花50根特惠套餐",//商品名称
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-11-09/5a041dcb9da9f.jpg",//商品图片
@property (nonatomic, copy) NSString * shop_price;//": "25.00"//商品价格
@property (nonatomic, copy) NSString * product_id;//": "0"   // 商品属性id
@property (nonatomic, copy) NSString * product;//": "组合套餐=默认"        // 商品属性


- (void)sGoodsGroupGoodsListSuccess:(SGoodsGroupGoodsListSuccessBlock)success andFailure:(SGoodsGroupGoodsListFailureBlock)failure;
@end
