//
//  SOneBuyOneBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOneBuyOneBuyInfo.h"

@implementation SOneBuyOneBuyInfo

- (void)sOneBuyOneBuyInfoSuccess:(SOneBuyOneBuyInfoSuccessBlock)success andFailure:(SOneBuyOneBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SOneBuyOneBuyInfo_Url andParameters:@{@"one_buy_id":_one_buy_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOneBuyOneBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goodsGallery":@"SOneBuyOneBuyInfo",@"oneBuyLog":@"SOneBuyOneBuyInfo",@"outTime_log":@"SOneBuyOneBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SOneBuyOneBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
