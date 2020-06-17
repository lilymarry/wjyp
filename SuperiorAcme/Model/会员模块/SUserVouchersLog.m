//
//  SUserVouchersLog.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserVouchersLog.h"

@implementation SUserVouchersLog

- (void)sUserVouchersLogSuccess:(SUserVouchersLogSuccessBlock)success andFailure:(SUserVouchersLogFailureBlock)failure {
    NSString *strApi = SUserVouchersLog_Url;
    if ([_giveStatus isEqualToString:@"1"]) {
        //赠送明细
        strApi = SUserBalanceBlueCouponLog_Url;
    }
    [HttpManager postWithUrl:strApi andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserVouchersLog mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserVouchersLog",@"list":@"SUserVouchersLog"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserVouchersLog mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
