//
//  SOrderOrderLogistics.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderOrderLogistics.h"

@implementation SOrderOrderLogistics

- (void)sOrderOrderLogisticsSuccess:(SOrderOrderLogisticsSuccessBlock)success andFailure:(SOrderOrderLogisticsFailureBlock)failure {
    NSString *type = @"0";
    if ([_order_type isEqualToString:@"拼单购"]) {
        type = @"1";
    }else if ([_order_type isEqualToString:@"无界商店"]){
        type = @"5";
    }
    [HttpManager postWithUrl:SOrderOrderLogistics_Url andParameters:@{@"order_id":_order_id,@"type":type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOrderOrderLogistics mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SOrderOrderLogistics"};
        }];
        success(dic[@"code"],dic[@"message"],[SOrderOrderLogistics mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
