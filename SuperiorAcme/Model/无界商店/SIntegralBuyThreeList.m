//
//  SIntegralBuyThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyThreeList.h"

@implementation SIntegralBuyThreeList

- (void)sIntegralBuyThreeListSuccess:(SIntegralBuyThreeListSuccessBlock)success andFailure:(SIntegralBuyThreeListFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyThreeList_Url andParameters:@{@"two_cate_id":_two_cate_id,@"three_cate_id":_three_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"SIntegralBuyThreeList",@"integral_buy_list":@"SIntegralBuyThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
