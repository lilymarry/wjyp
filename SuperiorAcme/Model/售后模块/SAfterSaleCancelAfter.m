//
//  SAfterSaleCancelAfter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleCancelAfter.h"

@implementation SAfterSaleCancelAfter

- (void)sAfterSaleCancelAfterSuccess:(SAfterSaleCancelAfterSuccessBlock)success andFailure:(SAfterSaleCancelAfterFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleCancelAfter_Url andParameters:@{@"back_apply_id":_back_apply_id,@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
