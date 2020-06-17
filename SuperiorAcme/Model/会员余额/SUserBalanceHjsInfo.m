//
//  SUserBalanceHjsInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceHjsInfo.h"

@implementation SUserBalanceHjsInfo

- (void)sUserBalanceHjsInfoSuccess:(SUserBalanceHjsInfoSuccessBlock)success andFailure:(SUserBalanceHjsInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceHjsInfo_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceHjsInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceHjsInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceHjsInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
