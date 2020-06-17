//
//  SPayFindPayResult.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPayFindPayResultSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPayFindPayResultFailureBlock) (NSError * error);

@interface SPayFindPayResult : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * type;//    类型：type 1.充值,2汽车购订单，3房产购 4 订单支付 5 预购 6拼单购 4限量购 8竞拍汇

@property (nonatomic, strong) SPayFindPayResult * data;
@property (nonatomic, copy) NSString * status;//": "0"//0支付失败 1支付成功
@property (nonatomic, copy) NSString * order_sn;//线下店铺带商品下单时会返回
@property (nonatomic, copy) NSString * jump_url;
- (void)sPayFindPayResultSuccess:(SPayFindPayResultSuccessBlock)success andFailure:(SPayFindPayResultFailureBlock)failure;
@end
