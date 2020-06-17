//
//  SCountryCountryGoods.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCountryCountryGoods.h"

@implementation SCountryCountryGoods

- (void)sCountryCountryGoodsSuccess:(SCountryCountryGoodsSuccessBlock)success andFailure:(SCountryCountryGoodsFailureBlock)failure {
    [HttpManager postWithUrl:SCountryCountryGoods_Url andParameters:@{@"country_id":_country_id,@"cate_id":_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCountryCountryGoods mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SCountryCountryGoods",@"two_cate_list":@"SCountryCountryGoods",@"list":@"SCountryCountryGoods"};
        }];
        success(dic[@"code"],dic[@"message"],[SCountryCountryGoods mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
