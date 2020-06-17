//
//  SOrderCommentindex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCommentindex.h"

@implementation SOrderCommentindex

- (void)sOrderCommentindexSuccess:(SOrderCommentindexSuccessBlock)success andFailure:(SOrderCommentindexFailureBlock)failure {
    [HttpManager postWithUrl:SOrderCommentindex_Url andParameters:@{@"order_id":_order_id,@"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOrderCommentindex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_list":@"SOrderCommentindex",@"pictures":@"SOrderCommentindex"};
        }];
        success(dic[@"code"],dic[@"message"],[SOrderCommentindex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
