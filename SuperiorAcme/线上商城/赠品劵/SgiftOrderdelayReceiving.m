//
//  SgiftOrderdelayReceiving.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftOrderdelayReceiving.h"

@implementation SgiftOrderdelayReceiving
- (void)SgiftOrderdelayReceivingSuccess:(SgiftOrderdelayReceivingSuccessBlock)success andFailure:(SgiftOrderdelayReceivingFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/delayReceiving" baseurl:SgiftBase_url andParameters:@{@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
