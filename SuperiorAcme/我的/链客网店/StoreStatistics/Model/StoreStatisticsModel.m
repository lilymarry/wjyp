//
//  StoreStatisticsModel.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "StoreStatisticsModel.h"

@implementation StoreStatisticsModel

/**
 获取小店营收数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getStatisticsData:(Success)success andFailure:(Failure)failure {
    [HttpManager getWithUrl:@"Distribution/shops" andParameters:@{@"id" : _storeId, @"type" : _type, @"c_type" : _c_type, @"c_base_type" : _c_base_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        if (success) {
            if ([dic[@"code"] integerValue]==200) {
                success(dic);
            }
        }
    } andFail:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
