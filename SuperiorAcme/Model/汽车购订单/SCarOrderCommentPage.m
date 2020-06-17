//
//  SCarOrderCommentPage.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderCommentPage.h"

@implementation SCarOrderCommentPage

- (void)sCarOrderCommentPageSuccess:(SCarOrderCommentPageSuccessBlock)success andFailure:(SCarOrderCommentPageFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderCommentPage_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarOrderCommentPage mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"label_list":@"SCarOrderCommentPage"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarOrderCommentPage mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
