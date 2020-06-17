//
//  SUserIntegralLog.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserIntegralLogSuccessBlock) (NSString * code,  NSString * message, id data);
typedef void(^SUserIntegralLogFailureBlock) (NSError * error);

@interface SUserIntegralLog : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;//"月份",

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * log_id;//"记录id",
@property (nonatomic, copy) NSString * reason;//": "原因",
@property (nonatomic, copy) NSString * use_integral;//": "得到成长值",
@property (nonatomic, copy) NSString * create_time;//": "日期"
@property (nonatomic, copy) NSString * img;//
@property (nonatomic, copy) NSString * add_sub;//
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_type; //区分跳转详情页面
@property (nonatomic, copy) NSString * chat;//该订单已删除

- (void)sUserIntegralLogSuccess:(SUserIntegralLogSuccessBlock)success andFailure:(SUserIntegralLogFailureBlock)failure;
@end
