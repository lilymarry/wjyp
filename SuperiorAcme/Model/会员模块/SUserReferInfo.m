//
//  SUserReferInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserReferInfo.h"

@implementation SUserReferInfo

- (void)sUserReferInfoSuccess:(SUserReferInfoSuccessBlock)success andFailure:(SUserReferInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserReferInfo_Url andParameters:@{@"refer_id":_refer_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserReferInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"product_pic":@"SUserReferInfo",@"other_license":@"SUserReferInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserReferInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
