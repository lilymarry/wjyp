//
//  SPreOrderPreSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreSetOrder.h"

@implementation SPreOrderPreSetOrder

- (void)sPreOrderPreSetOrderSuccess:(SPreOrderPreSetOrderSuccessBlock)success andFailure:(SPreOrderPreSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreSetOrder_Url andParameters:@{@"goods_num":_goods_num,@"address_id":_address_id,@"order_id":_order_id,@"pre_id":_pre_id,@"freight":_freight,@"freight_type":_freight_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SPreOrderPreSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
