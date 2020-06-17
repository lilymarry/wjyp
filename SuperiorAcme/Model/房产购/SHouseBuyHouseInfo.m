//
//  SHouseBuyHouseInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseBuyHouseInfo.h"

@implementation SHouseBuyHouseInfo

- (void)sHouseBuyHouseInfoSuccess:(SHouseBuyHouseInfoSuccessBlock)success andFailure:(SHouseBuyHouseInfoFailureBlock)failure {
    [HttpManager postWithUrl:SHouseBuyHouseInfo_Url andParameters:@{@"house_id":_house_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseBuyHouseInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"house_attr":@"SHouseBuyHouseInfo",@"banner":@"SHouseBuyHouseInfo",@"comment_new":@"SHouseBuyHouseInfo",@"pictures_arr":@"SHouseBuyHouseInfo",@"label_arr":@"SHouseBuyHouseInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseBuyHouseInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
