//
//  SBalancePayBalancePay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SBalancePayBalancePaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SBalancePayBalancePayFailureBlock) (NSError * error);

@interface SBalancePayBalancePay : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id    否    文本    1
@property (nonatomic, copy) NSString * order_type;//    订单类型1普通订单 2拼单购 3无界预购 4比价购 5限量购 6积分抽奖 7比价购保证金 8积分抽奖追加
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝(多个选择用','隔开)
@property (nonatomic, copy) NSString * goods_num;//    商品数量（积分抽奖追加时传）

- (void)sBalancePayBalancePaySuccess:(SBalancePayBalancePaySuccessBlock)success andFailure:(SBalancePayBalancePayFailureBlock)failure;
@end
