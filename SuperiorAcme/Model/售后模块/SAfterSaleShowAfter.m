//
//  SAfterSaleShowAfter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleShowAfter.h"

@implementation SAfterSaleShowAfter

- (void)sAfterSaleShowAfterSuccess:(SAfterSaleShowAfterSuccessBlock)success andFailure:(SAfterSaleShowAfterFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleShowAfter_Url andParameters:@{@"apply_id":_apply_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAfterSaleShowAfter mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SAfterSaleShowAfter"};
        }];
        success(dic[@"code"],dic[@"message"],[SAfterSaleShowAfter mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
