//
//  SHouseBuyHouseList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseBuyHouseListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SHouseBuyHouseListFailureBlock) (NSError * error);

@interface SHouseBuyHouseList : NSObject
@property (nonatomic, copy) NSString * lng;//经度
@property (nonatomic, copy) NSString * lat;//纬度
@property (nonatomic, copy) NSString * integral_sort;//积分排序 1 正序 2倒序
@property (nonatomic, copy) NSString * distance_sort;//距离排序 1 正序 2倒序
@property (nonatomic, copy) NSString * price_sort;//价格 1 正序 2倒序
@property (nonatomic, copy) NSString * sort;//综合排序(默认)
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SHouseBuyHouseList * data;

@property (nonatomic, strong) SHouseBuyHouseList * ads;
@property (nonatomic, copy) NSString * ads_id;//": "轮播id",
@property (nonatomic, copy) NSString * picture;//": "轮播图",
@property (nonatomic, copy) NSString * desc;//": "轮播描述",
@property (nonatomic, copy) NSString * position;//": "位置参数"//不用考虑
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * car_list;
@property (nonatomic, copy) NSString * house_id;//": "楼盘id",
@property (nonatomic, copy) NSString * house_name;//": "楼盘名称",
@property (nonatomic, copy) NSString * house_img;//": "封面图片",
//@property (nonatomic, copy) NSString * lng;//": "经度",
//@property (nonatomic, copy) NSString * lat;//": "纬度",
@property (nonatomic, copy) NSString * min_price;//": "最低房价",
@property (nonatomic, copy) NSString * max_price;//": "最高房价",
@property (nonatomic, copy) NSString * now_num;//": "在售房源",
@property (nonatomic, copy) NSString * developer;//": "开发商",
@property (nonatomic, copy) NSString * distance;//": "距离"
@property (nonatomic, copy) NSString * integral;//积分

- (void)sHouseBuyHouseListSuccess:(SHouseBuyHouseListSuccessBlock)success andFailure:(SHouseBuyHouseListFailureBlock)failure;
@end
