//
//  SArticleAboutUs.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SArticleAboutUs.h"

@implementation SArticleAboutUs

- (void)sArticleAboutUsSuccess:(SArticleAboutUsSuccessBlock)success andFailure:(SArticleAboutUsFailureBlock)failure {
    [HttpManager postWithUrl:SArticleAboutUs_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SArticleAboutUs mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
