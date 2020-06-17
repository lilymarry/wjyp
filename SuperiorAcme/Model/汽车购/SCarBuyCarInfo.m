//
//  SCarBuyCarInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarBuyCarInfo.h"

@implementation SCarBuyCarInfo

- (void)sCarBuyCarInfoSuccess:(SCarBuyCarInfoSuccessBlock)success andFailure:(SCarBuyCarInfoFailureBlock)failure {
    [HttpManager postWithUrl:SCarBuyCarInfo_Url andParameters:@{@"car_id":_car_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarBuyCarInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"banner":@"SCarBuyCarInfo",@"attr":@"SCarBuyCarInfo",@"comment_new":@"SCarBuyCarInfo",@"pictures_arr":@"SCarBuyCarInfo",@"label_arr":@"SCarBuyCarInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarBuyCarInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
