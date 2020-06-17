//
//  SUserMyIntegral.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyIntegralSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMyIntegralFailureBlock) (NSError * error);

@interface SUserMyIntegral : NSObject
@property (nonatomic, strong) SUserMyIntegral * data;
@property (nonatomic, copy) NSString * exchange_status;//":"1今日已经兑换 0今日尚未兑换"
@property (nonatomic, copy) NSString * user_card_status;//"会员等级判断1不能兑换 0能兑换"
@property (nonatomic, copy) NSString * time_out_status;//"超时判断 1不能兑换 0能兑换"
@property (nonatomic, copy) NSString * article;//": "",              // 自动兑换文字说明
@property (nonatomic, copy) NSString * my_integral;//"我的积分",
@property (nonatomic, copy) NSString * integral_percentage;//": "10%",              // 积分兑换手续费比

@property (nonatomic, copy) NSString * status;//": 1              // 是否可兑换（0->不可，1->可以）
@property (nonatomic, copy) NSString * auto_status;//"  0显示 1强制隐藏

@property (nonatomic, copy) NSString * point_desc;//积分兑换方式描述详情
@property (nonatomic, copy) NSArray * point_list;//无界指数信息
@property (nonatomic, copy) NSString * point_num;//": "666",                    //无界指数
@property (nonatomic, copy) NSString * change;//": "今日您可使用99460.5 积分兑换66240693余额另赠送您99460.5购物券",   // 兑换内容
@property (nonatomic, copy) NSString * date;//": ""               //可兑换时间
@property (nonatomic, copy) NSString * my_change_integral;//": "666",                    //可兑换积分数


- (void)sUserMyIntegralSuccess:(SUserMyIntegralSuccessBlock)success andFailure:(SUserMyIntegralFailureBlock)failure;
@end
