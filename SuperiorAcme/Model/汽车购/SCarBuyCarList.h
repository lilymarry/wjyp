//
//  SCarBuyCarList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarBuyCarListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SCarBuyCarListFailureBlock) (NSError * error);

@interface SCarBuyCarList : NSObject
@property (nonatomic, copy) NSString * min_price;//价格最小不能为0 单位为元
@property (nonatomic, copy) NSString * max_price;//价格最大值
@property (nonatomic, copy) NSString * style_id;//车型id(默认不限)
@property (nonatomic, copy) NSString * brand_id;//品牌id(默认不限)
@property (nonatomic, copy) NSString * lng;//经度
@property (nonatomic, copy) NSString * lat;//纬度
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * car_id;//"汽车id",
@property (nonatomic, copy) NSString * car_name;// "汽车名称",
@property (nonatomic, copy) NSString * car_img;//"汽车图片",
//@property (nonatomic, copy) NSString * lng;//"经度",
//@property (nonatomic, copy) NSString * lat;//"纬度",
@property (nonatomic, copy) NSString * pre_money;//"代金券",
@property (nonatomic, copy) NSString * true_pre_money;//"可抵车款",
@property (nonatomic, copy) NSString * all_price;//"车全价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * distance;//"距离",
@property (nonatomic, copy) NSString * ticket_discount;//"购物券比例",
@property (nonatomic, copy) NSString * brand_logo;//"国家logo"

- (void)sCarBuyCarListSuccess:(SCarBuyCarListSuccessBlock)success andFailure:(SCarBuyCarListFailureBlock)failure;
@end
