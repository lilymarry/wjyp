//
//  SWelfareShareContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareShareContent.h"

@implementation SWelfareShareContent

- (void)sWelfareShareContentSuccess:(SWelfareShareContentSuccessBlock)success andFailure:(SWelfareShareContentFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareShareContent_Url andParameters:@{@"bonus_id":_bonus_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SWelfareShareContent mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
