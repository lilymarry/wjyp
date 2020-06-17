//
//  SUserBalanceUnderMoneys.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceUnderMoneys.h"

@implementation SUserBalanceUnderMoneys

- (void)sUserBalanceUnderMoneysSuccess:(SUserBalanceUnderMoneysSuccessBlock)success andFailure:(SUserBalanceUnderMoneysFailureBlock)failure {
    if (_status_type != nil && [_status_type isEqualToString:@"1"]) {
//        赠送蓝色券某条具体明细
        [HttpManager postWithUrl:SUserBalanceBlueCouponLogDetail_Url andParameters:@{@"p":_p,@"voucher_id":_voucher_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            [SUserBalanceUnderMoneys mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"data":@"SUserBalanceUnderMoneys",@"list":@"SUserBalanceUnderMoneys"};
            }];
            success(dic[@"code"],dic[@"message"],[SUserBalanceUnderMoneys mj_objectWithKeyValues:dic]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    } else {
        [HttpManager postWithUrl:SUserBalanceUnderMoneys_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            [SUserBalanceUnderMoneys mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"data":@"SUserBalanceUnderMoneys",@"list":@"SUserBalanceUnderMoneys"};
            }];
            success(dic[@"code"],dic[@"message"],[SUserBalanceUnderMoneys mj_objectWithKeyValues:dic]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    }
}
@end
