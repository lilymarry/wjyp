//
//  SHouseBuyHouseList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseBuyHouseList.h"

@implementation SHouseBuyHouseList

- (void)sHouseBuyHouseListSuccess:(SHouseBuyHouseListSuccessBlock)success andFailure:(SHouseBuyHouseListFailureBlock)failure {
    [HttpManager postWithUrl:SHouseBuyHouseList_Url andParameters:@{@"lng":_lng,@"lat":_lat,@"integral_sort":_integral_sort,@"distance_sort":_distance_sort,@"price_sort":_price_sort,@"sort":_sort,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseBuyHouseList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"car_list":@"SHouseBuyHouseList"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseBuyHouseList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
