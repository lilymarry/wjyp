//
//  SLimitBuyLimitBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyLimitBuyIndex.h"

@implementation SLimitBuyLimitBuyIndex

- (void)sLimitBuyLimitBuyIndexSuccess:(SLimitBuyLimitBuyIndexSuccessBlock)success andFailure:(SLimitBuyLimitBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyLimitBuyIndex_Url andParameters:@{@"stage_id":_stage_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SLimitBuyLimitBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"stage_list":@"SLimitBuyLimitBuyIndex",@"limitBuyList":@"SLimitBuyLimitBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SLimitBuyLimitBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
