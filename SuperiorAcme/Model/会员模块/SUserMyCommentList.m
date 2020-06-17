//
//  SUserMyCommentList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyCommentList.h"

@implementation SUserMyCommentList

- (void)sUserMyCommentListSuccess:(SUserMyCommentListSuccessBlock)success andFailure:(SUserMyCommentListFailureBlock)failure {
    [HttpManager postWithUrl:SUserMyCommentList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMyCommentList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMyCommentList",@"pictures":@"SUserMyCommentList",@"reply_pictures_list":@"SUserMyCommentList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyCommentList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
