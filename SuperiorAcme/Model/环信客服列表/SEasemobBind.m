//
//  SEasemobBind.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEasemobBind.h"

@implementation SEasemobBind

- (void)sEasemobBindSuccess:(SEasemobBindSuccessBlock)success andFailure:(SEasemobBindFailureBlock)failure {
    [HttpManager postWithUrl:SEasemobBind_Url andParameters:@{@"merchant_id":_merchant_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SEasemobBind mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SEasemobBind"};
        }];
        success(dic[@"code"],dic[@"message"],[SEasemobBind mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
