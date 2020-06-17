//
//  SHouseOrderOrderInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderOrderInfo.h"

@implementation SHouseOrderOrderInfo

- (void)sHouseOrderOrderInfoSuccess:(SHouseOrderOrderInfoSuccessBlock)success andFailure:(SHouseOrderOrderInfoFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderOrderInfo_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SHouseOrderOrderInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
