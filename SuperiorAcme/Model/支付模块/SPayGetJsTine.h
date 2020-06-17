//
//  SPayGetJsTine.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPayGetJsTineSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPayGetJsTineFailureBlock) (NSError * error);

@interface SPayGetJsTine : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：discount_type 0不使用代金券 1使用红券 2使用黄券 3使用蓝券(多个用','隔开)    否    文本    0
@property (nonatomic, copy) NSString * type;//    类型：type 1.充值,2汽车购订单，3房产购 4 订单支付(限量购) 5 预购 6拼单购 8竞拍汇    否    文本    1
@property (nonatomic, copy) NSString * money;//    充值时传，充值金额

@property (nonatomic, strong) SPayGetJsTine * data;
@property (nonatomic, copy) NSString * appid;//": "wxc971edce6f70ca57",
@property (nonatomic, copy) NSString * mch_id;//": "1496110892",
@property (nonatomic, copy) NSString * nonce_str;//": "WBmSrdvnhjxLi2sk",
@property (nonatomic, copy) NSString * prepay_id;//": "wx20180119144757dd554baa480106784940",
@property (nonatomic, copy) NSString * sign;//": "81381B9F0167B57726B61227970CD8EF",
@property (nonatomic, copy) NSString * package;//":"Sign=WXPay"
@property (nonatomic, copy) NSString * time_stamp;//": 1516600915
//@property (nonatomic, copy) NSString * order_id;//":"订单ID",

- (void)sPayGetJsTineSuccess:(SPayGetJsTineSuccessBlock)success andFailure:(SPayGetJsTineFailureBlock)failure;
@end
