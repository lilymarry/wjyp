//
//  SUserBalanceCashIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceCashIndex.h"

@implementation SUserBalanceCashIndex

- (void)sUserBalanceCashIndexSuccess:(SUserBalanceCashIndexSuccessBlock)success andFailure:(SUserBalanceCashIndexFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceCashIndex_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserBalanceCashIndex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
