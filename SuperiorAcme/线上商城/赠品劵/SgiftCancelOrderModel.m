//
//  SgiftCancelOrderModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftCancelOrderModel.h"

@implementation SgiftCancelOrderModel
- (void)SgiftCancelOrderModelSuccess:(SgiftCancelOrderModelSuccessBlock)success andFailure:(SgiftCancelOrderModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/CancelOrder" baseurl:SgiftBase_url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
