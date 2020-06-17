//
//  SOrderDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderDetails.h"

@implementation SOrderDetails

- (void)sOrderDetailsSuccess:(SOrderDetailsSuccessBlock)success andFailure:(SOrderDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SOrderDetails_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOrderDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SOrderDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SOrderDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
