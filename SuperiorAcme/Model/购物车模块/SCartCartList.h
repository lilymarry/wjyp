//
//  SCartCartList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCartCartListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCartCartListFailureBlock) (NSError * error);

@interface SCartCartList : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * merchant_id;//": "1",//商家ID
@property (nonatomic, copy) NSString * merchant_name;//": "第一家店",//商家名称
//商品
@property (nonatomic, copy) NSArray * goods;
@property (nonatomic, copy) NSString * cart_id;//": "2",//购物车ID
@property (nonatomic, copy) NSString * goods_id;//": "17",//商品ID
@property (nonatomic, copy) NSString * product_id;//": "1",//货品ID
@property (nonatomic, copy) NSString * num;//": "2",//购物车数量
@property (nonatomic, copy) NSString * goods_name;//": "小麻花50根特惠套餐",//商品名称
@property (nonatomic, copy) NSString * shop_price;//": "25.00",//价格
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-11-09/5a041dcb9da9f.jpg",//商品缩略图
@property (nonatomic, copy) NSString * sell_num;//": 3,               // 卖出数量
@property (nonatomic, copy) NSString * integral;//": "11111 ",
@property (nonatomic, copy) NSString * one_first_name;//": "口味",         //主属性名
@property (nonatomic, copy) NSString * two_first_name;//": "尺寸",        // 副属性名
@property (nonatomic, copy) NSString * goods_attr_name;//": "红色,M"  //已选规格
@property (nonatomic, copy) NSString * goods_num;//": "24",       // 当前属性库存
@property (nonatomic, assign) BOOL RBtn_BOOL;
@property (nonatomic, copy) NSString * return_integral;

//属性列表
@property (nonatomic, copy) NSString * first_list;
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

- (void)sCartCartListSuccess:(SCartCartListSuccessBlock)success andFailure:(SCartCartListFailureBlock)failure;
@end
