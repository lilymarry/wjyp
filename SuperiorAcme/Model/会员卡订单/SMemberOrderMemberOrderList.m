//
//  SMemberOrderMemberOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderMemberOrderList.h"

@implementation SMemberOrderMemberOrderList

- (void)sMemberOrderMemberOrderListSuccess:(SMemberOrderMemberOrderListSuccessBlock)success andFailure:(SMemberOrderMemberOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderMemberOrderList_Url andParameters:@{@"pay_status":_pay_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMemberOrderMemberOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMemberOrderMemberOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMemberOrderMemberOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
