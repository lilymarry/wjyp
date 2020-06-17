//
//  SgiftOderReceivingModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftOderReceivingModel.h"

@implementation SgiftOderReceivingModel
- (void)SgiftOderReceivingModelSuccess:(SgiftOderReceivingModelSuccessBlock)success andFailure:(SgiftOderReceivingModelFailureBlock)failure{
    
      [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/Receiving" baseurl:SgiftBase_url andParameters:@{@"order_id":_order_id,@"status":_status} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
