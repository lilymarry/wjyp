//
//  SMemberAliPayFindPayResult.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/1.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberAliPayFindPayResultSuccessBlock) (NSString * code, NSString * message);
typedef void(^SMemberAliPayFindPayResultFailureBlock) (NSError * error);

@interface SMemberAliPayFindPayResult : NSObject
@property (nonatomic, copy) NSString * order_id;//    会员卡订单id    否    文本    1
@property (nonatomic, copy) NSString * type;//    订单类型（1->会员卡）

- (void)sMemberAliPayFindPayResultSuccess:(SMemberAliPayFindPayResultSuccessBlock)success andFailure:(SMemberAliPayFindPayResultFailureBlock)failure;
@end
