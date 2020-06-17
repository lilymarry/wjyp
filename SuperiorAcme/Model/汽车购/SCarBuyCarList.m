//
//  SCarBuyCarList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarBuyCarList.h"

@implementation SCarBuyCarList

- (void)sCarBuyCarListSuccess:(SCarBuyCarListSuccessBlock)success andFailure:(SCarBuyCarListFailureBlock)failure {
    [HttpManager postWithUrl:SCarBuyCarList_Url andParameters:@{@"min_price":_min_price,@"max_price":_max_price,@"style_id":_style_id,@"brand_id":_brand_id,@"lng":_lng,@"lat":_lat,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarBuyCarList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SCarBuyCarList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarBuyCarList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
