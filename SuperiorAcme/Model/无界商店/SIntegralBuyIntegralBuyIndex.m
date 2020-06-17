//
//  SIntegralBuyIntegralBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyIntegralBuyIndex.h"

@implementation SIntegralBuyIntegralBuyIndex

- (void)sIntegralBuyIntegralBuyIndexSuccess:(SIntegralBuyIntegralBuyIndexSuccessBlock)success andFailure:(SIntegralBuyIntegralBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyIntegralBuyIndex_Url andParameters:@{@"cate_id":_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyIntegralBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SIntegralBuyIntegralBuyIndex",@"two_cate_list":@"SIntegralBuyIntegralBuyIndex",@"integral_buy_list":@"SIntegralBuyIntegralBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyIntegralBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
