//
//  SMemberOrderSetOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderSetOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderSetOrderFailureBlock) (NSError * error);

@interface SMemberOrderSetOrder : NSObject
@property (nonatomic, copy) NSString * member_coding;//    会员卡id    否    文本    1
@property (nonatomic, copy) NSString * number;//    数量    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝(多个选择用','隔开)    否    文本    1
@property (nonatomic, copy) NSString * pay_type;//   支付方式（1->余额,2->积分支付，3->支付宝，4->微信）
@property (nonatomic, copy) NSString * order_id;//

@property (nonatomic, strong) SMemberOrderSetOrder * data;

//@property (nonatomic, copy) NSString * order_id;//    会员卡订单id    否    文本    1


//支付宝参数
@property (nonatomic, copy) NSString * pay_string;

//微信参数
@property (nonatomic, copy) NSString * mch_id;//商户号
@property (nonatomic, copy) NSString * prepay_id;//预支付id
@property (nonatomic, copy) NSString * nonce_str;//随机字符串
@property (nonatomic, copy) NSString * time_stamp;//时间戳
@property (nonatomic, copy) NSString * sign;//签名

- (void)sMemberOrderSetOrderSuccess:(SMemberOrderSetOrderSuccessBlock)success andFailure:(SMemberOrderSetOrderFailureBlock)failure;
@end
