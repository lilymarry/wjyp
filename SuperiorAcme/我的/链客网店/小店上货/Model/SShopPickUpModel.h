//
//  SShopPickUpModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MicroToolHeader.h"
#import "BaseModel.h"
typedef void(^SShopPickUpModelSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SShopPickUpModelFailureBlock) (NSError * error);

@interface SShopPickUpModel : BaseModel

@property (nonatomic, strong) NSArray * top_nav;//一级分类

#pragma mark - two_cate_list(二级分类)
@property (nonatomic, strong) NSArray * two_cate_list;//二级分类
@property (nonatomic, copy) NSString * id;//二级分类的id
@property (nonatomic, copy) NSString * name;//二级分类的名字
@property (nonatomic, copy) NSString * short_name;//二级分类的简称
@property (nonatomic, copy) NSString * cate_img;//二级分类的图片
@property (nonatomic, copy) NSString * two_cate_id;//二级分类的id  和 id是一个值

#pragma mark  - list(商品的列表)
@property (nonatomic, strong) NSArray * list;//商品列表
@property (nonatomic, copy) NSString * goods_id;//商品id
@property (nonatomic, copy) NSString * goods_name;//商品名字
@property (nonatomic, copy) NSString * country_id;//商品的国家id
@property (nonatomic, copy) NSString * path;//
@property (nonatomic, copy) NSString * goods_img;//商品的图片url
@property (nonatomic, copy) NSString * market_price;//商品的市场价
@property (nonatomic, copy) NSString * shop_price;//商品的店铺价
@property (nonatomic, copy) NSString * integral;//商品赠送的积分
@property (nonatomic, copy) NSString * ticket_buy_id;//
@property (nonatomic, copy) NSString * discount;//折扣百分比
@property (nonatomic, copy) NSString * yellow_discount;//黄券折扣百分比
@property (nonatomic, copy) NSString * blue_discount;//蓝券折扣百分比
@property (nonatomic, copy) NSString * sell_num;//卖出的数量
@property (nonatomic, copy) NSString * country_logo;//商品所属国家的logo
@property (nonatomic, copy) NSString * ticket_buy_discount;//
@property (nonatomic, copy) NSString * all_goods_num;//商品的总数

#pragma mark - **************   获取上架商品   ****************
//自定属性   是否被点击了 点击了改变状态
@property (assign, nonatomic) BOOL isClicked;
//数据参数
@property (nonatomic, copy) NSString *cate_id;  //小店点标id
/*
 排序字段名
 积分：’red_return_integral’
 代金券：’discount’，
 价格：’shop_price’,
 销量：’new_sell_num’
 
 name
 */

/**正序（asc） 倒序 (desc)*/
@property (nonatomic, copy) NSString *flag;

/**分页*/
@property (nonatomic, assign) NSInteger p;
#pragma mark - **************   获取上架商品   ****************

#pragma mark - (商品信息更新接口) 上架

/* 1. id   商品id */

/**
 2. （默认0 [0 正常(上架中) 1 下架 9 删除]） 选填
 */
@property (nonatomic, copy) NSString *shop_goods_status;

/**
 3. product_id(唯一标识) 选填
 */
@property (nonatomic, copy) NSString *product_id;

/**
 4.   1 是专区商品（399区商品） 0 普通商品 （默认）选填
 */
@property (nonatomic, copy) NSString *is_special;

/**
 5.   小店id  必填
 */
@property (nonatomic, copy) NSString *shop_id;

/**
 6.   商品id  goods_id  必填
 */

#pragma mark - (商品信息更新接口) 上架

//获取上架商品
-(void)GetShopPickUpGoodsListWith:(SShopPickUpModelSuccessBlock)success andFailure:(SShopPickUpModelFailureBlock)failure;

//上架商品
-(void)putawayGoodsMethod:(SShopPickUpModelSuccessBlock)success andFailure:(SShopPickUpModelFailureBlock)failure;

@end
