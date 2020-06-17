//
//  SUserVouchersList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserVouchersList.h"

@implementation SUserVouchersList

- (void)sUserVouchersListSuccess:(SUserVouchersListSuccessBlock)success andFailure:(SUserVouchersListFailureBlock)failure {
    [HttpManager postWithUrl:SUserVouchersList_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserVouchersList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"out":@"SUserVouchersList",@"normal":@"SUserVouchersList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserVouchersList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
