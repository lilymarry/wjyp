//
//  SUserMyRecommend.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyRecommend.h"

@implementation SUserMyRecommend

- (void)sUserMyRecommendSuccess:(SUserMyRecommendSuccessBlock)success andFailure:(SUserMyRecommendFailureBlock)failure {
//    [HttpManager postWithUrl:SUserMyRecommend_Url
    [HttpManager postWithUrl:SUserMyRecommendNew_Url
               andParameters:@{@"p":_p,@"parent_id":_parent_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
                   
        [SUserMyRecommend mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMyRecommend"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyRecommend mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
