//
//  SGoodManagementModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
//typedef void(^SGoodManagementModelSuccessBlock) (id  code, NSString * message, id data, NSString * nums);
typedef void(^SGoodManagementModelSuccessBlock) (id result);
typedef void(^SGoodManagementFailureBlock) (NSError * error);
@interface SGoodManagementModel : BaseModel

@property (nonatomic, assign) BOOL isturnEditStatus;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) SGoodManagementModel * data;
@property (nonatomic, strong) NSMutableArray * list;//商品列表
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * p;
@property (nonatomic, copy) NSString * shop_id;
@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * country_id;
@property (nonatomic, copy) NSString * dsg_id;
@property (nonatomic, copy) NSString * g_integral;
@property (nonatomic, copy) NSString * goods_id;

@property (nonatomic, copy) NSString * goods_img;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_num;
@property (nonatomic, copy) NSString * integral;

@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * sell_num;
@property (nonatomic, copy) NSString * shop_price;

@property (nonatomic, copy) NSString * ticket_buy_discount;
@property (nonatomic, copy) NSString * ticket_buy_id;

#pragma  商品上架 下架 删除
@property (nonatomic, copy) NSString * shopidStr;
@property (nonatomic, copy) NSString * shop_goods_status;

@property (nonatomic, copy) NSString * goods_brief;//简介

@property (nonatomic, copy) NSString * receive_name;
@property (nonatomic, copy) NSString * country_name;
@property (nonatomic, copy) NSString * goods_gift;

@property (nonatomic, copy) NSString * active_type;
@property (nonatomic, copy) NSString * shop_goods_rec;
@property (nonatomic, copy) NSString * merchant_id;

@property (nonatomic, copy) NSString * is_distribution;

//商品信息
-(void)putOnLineaGoodsMethod:(SGoodManagementModelSuccessBlock)success andFailure:(SGoodManagementFailureBlock)failure;

//商品上架/下架/删除接口
-(void)mangerLineaGoodsMethod:(SGoodManagementModelSuccessBlock)success andFailure:(SGoodManagementFailureBlock)failure;


@end
