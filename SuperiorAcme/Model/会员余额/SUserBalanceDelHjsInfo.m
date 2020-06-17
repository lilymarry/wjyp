//
//  SUserBalanceDelHjsInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceDelHjsInfo.h"

@implementation SUserBalanceDelHjsInfo

- (void)sUserBalanceDelHjsInfoSuccess:(SUserBalanceDelHjsInfoSuccessBlock)success andFailure:(SUserBalanceDelHjsInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceDelHjsInfo_Url andParameters:@{@"order_id":_order_id,@"order_status":_order_status} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
