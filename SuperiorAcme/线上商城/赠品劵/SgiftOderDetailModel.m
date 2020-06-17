//
//  SgiftOderDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftOderDetailModel.h"

@implementation SgiftOderDetailModel
- (void)SgiftOderDetailModelSuccess:(SgiftOderDetailModelSuccessBlock)success andFailure:(SgiftOderDetailModelFailureBlock)failure {
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/details" baseurl:SgiftBase_url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SgiftOderDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SgiftOderDetailModel"};
        }];
        success(dic[@"code"],dic[@"message"],[SgiftOderDetailModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
