//
//  SCarBuyCarSelect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarBuyCarSelect.h"

@implementation SCarBuyCarSelect

- (void)sCarBuyCarSelectSuccess:(SCarBuyCarSelectSuccessBlock)success andFailure:(SCarBuyCarSelectFailureBlock)failure {
    [HttpManager postWithUrl:SCarBuyCarSelect_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarBuyCarSelect mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"style_list":@"SCarBuyCarSelect",@"brand_list":@"SCarBuyCarSelect"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarBuyCarSelect mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
