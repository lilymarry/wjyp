//
//  SFreightSplit.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SFreightSplit.h"

@implementation SFreightSplit

- (void)sFreightSplitSuccess:(SFreightSplitSuccessBlock)success andFailure:(SFreightSplitFailureBlock)failure {
    [HttpManager postWithUrl:SFreightSplit_Url andParameters:@{@"address_id":_address_id,@"now_goods_id":_now_goods_id,@"goods_info":_goods_info} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SFreightSplit mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"tem":@"SFreightSplit"};
        }];
        success(dic[@"code"],dic[@"message"],[SFreightSplit mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
