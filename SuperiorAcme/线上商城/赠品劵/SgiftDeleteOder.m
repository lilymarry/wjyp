//
//  SgiftDeleteOder.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftDeleteOder.h"

@implementation SgiftDeleteOder
- (void)SgiftDeleteOderModelSuccess:(SgiftDeleteOderSuccessBlock)success andFailure:(SgiftDeleteOderFailureBlock)failure;{
    
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/DeleteOrder" baseurl:SgiftBase_url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
