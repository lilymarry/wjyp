//
//  SArticleHelpCenter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SArticleHelpCenter.h"

@implementation SArticleHelpCenter

- (void)sArticleHelpCenterSuccess:(SArticleHelpCenterSuccessBlock)success anFailure:(SArticleHelpCenterFailureBlock)failure {
    [HttpManager postWithUrl:SArticleHelpCenter_Url andParameters:@{@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SArticleHelpCenter mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SArticleHelpCenter"};
        }];
        success(dic[@"code"],dic[@"message"],[SArticleHelpCenter mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

- (id)copyWithZone:(NSZone *)zone
{
    SArticleHelpCenter *copy = [[[self class] allocWithZone:zone] init];
    copy.title  = [_title copy];
    copy.content  =[_content copy];
    copy.isChild= NO;
    copy.isExpended=NO;
    copy.webHeight=0;
    return copy;
}

@end
