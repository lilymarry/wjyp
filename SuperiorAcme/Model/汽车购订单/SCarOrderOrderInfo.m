//
//  SCarOrderOrderInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderOrderInfo.h"

@implementation SCarOrderOrderInfo

- (void)sCarOrderOrderInfoSuccess:(SCarOrderOrderInfoSuccessBlock)success andFailure:(SCarOrderOrderInfoFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderOrderInfo_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SCarOrderOrderInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
