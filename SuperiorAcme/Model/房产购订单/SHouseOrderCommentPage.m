//
//  SHouseOrderCommentPage.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderCommentPage.h"

@implementation SHouseOrderCommentPage

- (void)sHouseOrderCommentPageSuccess:(SHouseOrderCommentPageSuccessBlock)success andFailure:(SHouseOrderCommentPageFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderCommentPage_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseOrderCommentPage mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"label_list":@"SHouseOrderCommentPage"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseOrderCommentPage mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
