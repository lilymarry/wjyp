//
//  SHouseBuyHouseStyleList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseBuyHouseStyleList.h"

@implementation SHouseBuyHouseStyleList

- (void)sHouseBuyHouseStyleListSuccess:(SHouseBuyHouseStyleListSuccessBlock)success andFailure:(SHouseBuyHouseStyleListFailureBlock)failure {
    [HttpManager postWithUrl:SHouseBuyHouseStyleList_Url andParameters:@{@"house_id":_house_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseBuyHouseStyleList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SHouseBuyHouseStyleList"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseBuyHouseStyleList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
