//
//  SHouseOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderOrderList.h"

@implementation SHouseOrderOrderList

- (void)sHouseOrderOrderListSuccess:(SHouseOrderOrderListSuccessBlock)success andFailure:(SHouseOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderOrderList_Url andParameters:@{@"type":_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SHouseOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
