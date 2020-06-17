//
//  SCountryThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCountryThreeList.h"

@implementation SCountryThreeList

- (void)sCountryThreeListSuccess:(SCountryThreeListSuccessBlock)success andFailure:(SCountryThreeListFailureBlock)failure {
    [HttpManager postWithUrl:SCountryThreeList_Url andParameters:@{@"country_id":_country_id,@"two_cate_id":_two_cate_id,@"three_cate_id":_three_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCountryThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"SCountryThreeList",@"list":@"SCountryThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCountryThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
