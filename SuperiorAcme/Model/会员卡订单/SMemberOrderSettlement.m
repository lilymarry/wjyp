//
//  SMemberOrderSettlement.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderSettlement.h"

@implementation SMemberOrderSettlement

- (void)sMemberOrderSettlementSuccess:(SMemberOrderSettlementSuccessBlock)success andFailure:(SMemberOrderSettlementFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderSettlement_Url andParameters:@{@"member_coding":_member_coding} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SMemberOrderSettlement mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
