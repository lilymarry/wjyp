//
//  SShopManagementModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopManagementModel.h"

@implementation SShopManagementModel
//获取店铺的信息
+ (void)getShopMessageWithShopID:(NSString *)shopid andSuccess:(SShopManagementModelSuccessBlock)success andFailure:(SShopManagementModelFailureBlock)failure {
     [SRegisterLogin shareInstance].method = @"GET";
    [HttpManager getWithUrl:@"Distribution/shops" andParameters:@{@"id":shopid} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        id data = dic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            [SShopManagementModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"data":@"SShopSetModel"};
            }];
            data = [SShopManagementModel mj_objectArrayWithKeyValuesArray:data];
        }else{
            data = [SShopManagementModel mj_objectWithKeyValues:data];
        }
        success(dic[@"code"],dic[@"message"],data,dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
