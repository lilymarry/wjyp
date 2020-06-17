//
//  SOrderCompleteModel.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/29.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOrderCompleteModel : NSObject

@property (nonatomic, copy) NSString *order_id; //订单ID
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *pay_time; //支付时间
@property (nonatomic, assign) BOOL pay_status; //支付状态 0支付失败 1支付成功
@property (nonatomic, assign) float order_price;   //定单金额
@property (nonatomic, copy) NSString *ticket_color; //使用券类型 0未使用 1红 2黄 3蓝
@property (nonatomic, copy) NSString *pay_tickets; //使用券数量
@property (nonatomic, copy) NSString *return_integral; //返回积分数

@end
