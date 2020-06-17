//
//  SgiftShoppingPayModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftShoppingPayModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^SgiftShoppingPayModelFailureBlock) (NSError * error);

@interface SgiftShoppingPayModel : NSObject


@property (nonatomic, copy) NSString * order_id;//    订单id    否    文本    1
@property (nonatomic, copy) NSString * order_type;//    订单类型1普通订单 2拼单购 3无界预购 4比价购 5限量购 6积分抽奖 8积分抽奖追加 10 无界商店
@property (nonatomic, copy) NSString * auct_id;//    竞拍id（比价购时传）
@property (nonatomic, copy) NSString * goods_num;//    商品数（积分抽奖追加时传）    否    文本    1

- (void)SgiftShoppingPayModelSuccess:(SgiftShoppingPayModelSuccessBlock)success andFailure:(SgiftShoppingPayModelFailureBlock)failure;
@end
