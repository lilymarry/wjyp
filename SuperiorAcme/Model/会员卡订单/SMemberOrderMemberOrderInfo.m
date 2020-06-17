//
//  SMemberOrderMemberOrderInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderMemberOrderInfo.h"

@implementation SMemberOrderMemberOrderInfo

- (void)sMemberOrderMemberOrderInfoSuccess:(SMemberOrderMemberOrderInfoSuccessBlock)success andFailure:(SMemberOrderMemberOrderInfoFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderMemberOrderInfo_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMemberOrderMemberOrderInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMemberOrderMemberOrderInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SMemberOrderMemberOrderInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
