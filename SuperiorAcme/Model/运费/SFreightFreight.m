//
//  SFreightFreight.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SFreightFreight.h"

@implementation SFreightFreight

- (void)sFreightFreightSuccess:(SFreightFreightSuccessBlock)success andFailure:(SFreightFreightFailureBlock)failure {
    [HttpManager postWithUrl:SFreightFreight_Url andParameters:@{@"goods_id":_goods_id,@"address":_address,@"goods_num":_goods_num,@"product_id":_product_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SFreightFreight mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
