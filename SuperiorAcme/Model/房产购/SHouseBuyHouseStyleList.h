//
//  SHouseBuyHouseStyleList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseBuyHouseStyleListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SHouseBuyHouseStyleListFailureBlock) (NSError * error);

@interface SHouseBuyHouseStyleList : NSObject
@property (nonatomic, copy) NSString * house_id;//户型id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * style_id;//": "户型id",
@property (nonatomic, copy) NSString * style_name;//": "户型名称",
@property (nonatomic, copy) NSString * house_style_img;//": "户型封面图",
@property (nonatomic, copy) NSString * pre_money;//": "代金券",
@property (nonatomic, copy) NSString * true_pre_money;//": "可抵金额",
@property (nonatomic, copy) NSString * one_price;//": "房价",
@property (nonatomic, copy) NSString * all_price;//": "房全款",
@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * ticket_discount;//": "购物券比例",
@property (nonatomic, copy) NSString * developer;//": "开发商",
@property (nonatomic, copy) NSString * total;//": "总数",
@property (nonatomic, copy) NSString * sell_num;//": "已售"
@property (nonatomic, copy) NSString * country_logo;//:国家logo
@property (nonatomic, copy) NSString * country_id;

- (void)sHouseBuyHouseStyleListSuccess:(SHouseBuyHouseStyleListSuccessBlock)success andFailure:(SHouseBuyHouseStyleListFailureBlock)failure;
@end
