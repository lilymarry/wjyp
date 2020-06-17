//
//  SAuctionOrderAuct.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderAuctSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAuctionOrderAuctFailureBlock) (NSError * error);

@interface SAuctionOrderAuct : NSObject
@property (nonatomic, copy) NSString * auction_id;//    竞拍id

@property (nonatomic, strong) SAuctionOrderAuct * data;
@property (nonatomic, copy) NSString * auc_type;//": 0,              // 0->未交 1->已交
@property (nonatomic, copy) NSString * base_money;//": "1.00",   // 保证金金额
@property (nonatomic, copy) NSString * merchant_name;//": "",      //店铺名称
@property (nonatomic, copy) NSString * base_balance;//"    //余额
@property (nonatomic, copy) NSString * order_id;//"    //保证金id
@property (nonatomic, copy) NSString * min_price;//"                            // 竞拍最低价
- (void)sAuctionOrderAuctSuccess:(SAuctionOrderAuctSuccessBlock)success andFailure:(SAuctionOrderAuctFailureBlock)failure;
@end
