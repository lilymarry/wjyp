//
//  SPayGetHjsp.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPayGetHjspSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPayGetHjspFailureBlock) (NSError * error);

@interface SPayGetHjsp : NSObject
@property (nonatomic, copy) NSString * totalPrice;//    充值金额
@property (nonatomic, copy) NSString * order_id;//":"订单ID",

@property (nonatomic, strong) SPayGetHjsp * data;
@property (nonatomic, copy) NSString * appid;//": "wxc971edce6f70ca57",
@property (nonatomic, copy) NSString * mch_id;//": "1496110892",
@property (nonatomic, copy) NSString * nonce_str;//": "WBmSrdvnhjxLi2sk",
@property (nonatomic, copy) NSString * prepay_id;//": "wx20180119144757dd554baa480106784940",
@property (nonatomic, copy) NSString * sign;//": "81381B9F0167B57726B61227970CD8EF",
@property (nonatomic, copy) NSString * package;//":"Sign=WXPay"
@property (nonatomic, copy) NSString * time_stamp;//": 1516600915

- (void)sPayGetHjspSuccess:(SPayGetHjspSuccessBlock)success andFailure:(SPayGetHjspFailureBlock)failure;
@end
