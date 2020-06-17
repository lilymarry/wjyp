//
//  SArticleGetArticle.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SArticleGetArticle.h"

@implementation SArticleGetArticle

- (void)sArticleGetArticleSuccess:(SArticleGetArticleSuccessBlock)success andFailure:(SArticleGetArticleFailureBlock)failure {
    [HttpManager postWithUrl:SArticleGetArticle_Url andParameters:@{@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SArticleGetArticle mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
