//
//  SHouseBuyCommentList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseBuyCommentList.h"

@implementation SHouseBuyCommentList

- (void)sHouseBuyCommentListSuccess:(SHouseBuyCommentListSuccessBlock)success andFailure:(SHouseBuyCommentListFailureBlock)failure {
    [HttpManager postWithUrl:SHouseBuyCommentList_Url andParameters:@{@"house_id":_house_id,@"label_id":_label_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseBuyCommentList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"label_list":@"SHouseBuyCommentList",@"comment_list":@"SHouseBuyCommentList",@"pictures_arr":@"SHouseBuyCommentList",@"label_arr":@"SHouseBuyCommentList"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseBuyCommentList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
