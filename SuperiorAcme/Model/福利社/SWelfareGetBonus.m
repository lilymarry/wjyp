//
//  SWelfareGetBonus.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareGetBonus.h"

@implementation SWelfareGetBonus

- (void)sWelfareGetBonusSuccess:(SWelfareGetBonusSuccessBlock)success andFailure:(SWelfareGetBonusFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareGetBonus_Url andParameters:@{@"bonus_id":_bonus_id,@"bonus_val":_bonus_val} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SWelfareGetBonus mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
