//
//  SCarOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderOrderList.h"

@implementation SCarOrderOrderList

- (void)sCarOrderOrderListSuccess:(SCarOrderOrderListSuccessBlock)success andFailure:(SCarOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderOrderList_Url andParameters:@{@"type":_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SCarOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
