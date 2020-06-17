//
//  SCountryCountryIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCountryCountryIndex.h"

@implementation SCountryCountryIndex

- (void)sCountryCountryIndexSuccess:(SCountryCountryIndexSuccessBlock)success andFailure:(SCountryCountryIndexFailureBlock)failure {
    [HttpManager postWithUrl:SCountryCountryIndex_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCountryCountryIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"country_list":@"SCountryCountryIndex",@"goods_list":@"SCountryCountryIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SCountryCountryIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
